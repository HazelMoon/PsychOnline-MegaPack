local genericDeath = {'genericdeath', 'fnf_loss_sfx', 'gameover_v4_LOOP', 'gameover_v4_End'}
local deathAssets = {
    -- song name, character, songLoop, songEnd
    defeat      =  {'bf-defeat-dead', 'death/defeat_kill_sfx'},
    pretender   =  {'pretender'}
}

local realSong = ''
local genericPause = 'sussus_muzak'
local pauseMusic = {
    -- song name, pause music name
    ['defeat']  =  'blackpause'
}

function onCreate()
    setDeathAssets()
    setPauseMusic()
end

function setDeathAssets()
    local songLower = string.lower(songName)
    local songAssets = deathAssets[songLower]

    if songAssets == nil then
        songAssets = genericDeath
    end

    local char = songAssets[1] or genericDeath[1]
    local dead = songAssets[2] or genericDeath[2]
    local loop = songAssets[3] or genericDeath[3]
    local beat = songAssets[4] or genericDeath[4]

    setPropertyFromClass('substates.GameOverSubstate', 'characterName', char);
    setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', dead);
    setPropertyFromClass('substates.GameOverSubstate', 'loopSoundName', 'death/'..loop);
    setPropertyFromClass('substates.GameOverSubstate', 'endSoundName', 'death/'..beat);

    if songLower == 'defeat' and getRandomBool(10) then
        setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'bf-defeat-dead-balls');
        setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/defeat_kill_ballz_sfx');
    end
end

function setPauseMusic()
    local songLower = string.lower(songName)
    local pause = pauseMusic[songLower] or genericPause
    
    realSong = getPropertyFromClass('backend.ClientPrefs', 'data.pauseMusic')
    setPropertyFromClass('backend.ClientPrefs', 'data.pauseMusic', pause)
end

function onDestroy()
    setPropertyFromClass('backend.ClientPrefs', 'data.pauseMusic', realSong)
end