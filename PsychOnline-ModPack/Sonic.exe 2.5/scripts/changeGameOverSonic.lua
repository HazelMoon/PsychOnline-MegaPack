local curGameOver = ''

local songsState = 0
function onCreatePost()
    detectGameOver()
end
function detectGameOver()
    local bfCharacter = getProperty('boyfriend.curCharacter')

    local characterName = 'bf-dead'
    local deathSound = 'fnf_loss_sfx'
    local loopSoundName = 'gameOver'
    local endSoundName = 'gameOverEnd'

    curGameOver = ''
    if getProperty('dad.curCharacter') == 'starved' then
        characterName = 'starved-die'
        deathSound = 'starved-death'
        loopSoundName = 'staticBUZZ'
        curGameOver = 'starved'
    end
    if bfCharacter == 'bf-fatal' then
        characterName = 'bf-fatal-death'
        deathSound = 'fatal-death'
        loopSoundName = 'starved-loop'
        curGameOver = 'fatal'
    end
    if bfCharacter == 'bf-needle' then
        characterName = 'bf-needle-die'
        loopSoundName = 'needlemouse-loop'
        endSoundName = 'needlemouse-retry'
        curGameOver = 'needle'
    end
    if bfCharacter == 'bf-running-sonic' or getProperty('boyfriend.curCharacter') == 'bf-Sonic-Peelout' then

        curGameOver = 'prey'
    end
    if songsState == 1 and curGameOver == 'prey' then
        if getProperty('boyfriend.animation.curAnim.curFrame') == 15 then
            playSound('SonicDash')
            songsState = 2
        end
    end
    setPropertyFromClass('substates.GameOverSubstate','characterName',characterName)
    setPropertyFromClass('substates.GameOverSubstate','deathSoundName',deathSound)
    setPropertyFromClass('substates.GameOverSubstate','loopSoundName',loopSoundName)
    setPropertyFromClass('substates.GameOverSubstate','endSoundName',endSoundName)
end
function onGameOverConfirm()
    if songsState == 0 and curGameOver == 'prey' then
        playSound('SonicJump')
        songsState = 1
    end
end