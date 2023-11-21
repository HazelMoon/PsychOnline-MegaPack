--General Variables
local IndieCrossGameOverStyle = ''
local GameOverActive = false
local enableEnd = true
local timePercent = 0
--[[local cupheadEnable = {'Snake-Eyes','Technicolor-Tussle','Knockout','Devils-Gambit','Satanic-Funkin'}
local sansEnable = {'Whoopee','Sansational','Burning-In-Hell','Final-Stretch','Bad-Time','Bad-To-The-Bone','Bonedoggle'}
local bendyEnable = {'Imminent-Demise','Terrible-Sin','Last-Reel','Nightmare-Run','Ritual','Despair'}]]--
local dialogue = {
    "I've fought monsters 10 times your size!",
    "I'm surprised that you had the balls to fight me!",
    "It was too easy to defeat you!",
    "Time your dodges better, geese"
}
local dialogeFound = ''

--Cuphead Variables
local GameOverState = 0
local CupSelection = 0
local AlphaCupEffect = 1

function onCreate()
    local stage = getPropertyFromClass('PlayState','curStage')
    if string.match(stage,'field') == 'field' or string.match(stage,'devilHall') == 'devilHall' then
            setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'Cup/CupDeath');
            setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver');
            setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');
            IndieCrossGameOverStyle = 'Cuphead'

            makeAnimatedLuaSprite('BfGhost','cup/BF_Ghost',0,0)
            addAnimationByPrefix('BfGhost','Death','thrtr instance 1',24,true)
            setProperty('BfGhost.alpha',0.001)
            addLuaSprite('BfGhost',true)

            makeLuaSprite('You re dead','cup/death',200,300)
            setObjectCamera('You re dead','other')
            scaleObject('You re dead',0.9,0.9)

            local cardTexture = 'cup/cuphead_death'
            if songName == 'Knockout' or songName == 'Devils-Gambit' then
                cardTexture = 'cup/cuphead_death2'
            elseif songName == 'Satanic-Funkin' then
                cardTexture = 'cup/devil_death'
            end
            makeLuaSprite('CupBlackScreen',nil,0,0)
            makeGraphic('CupBlackScreen',screenWidth + 10,screenHeight + 10,'000000')
            setObjectCamera('CupBlackScreen','other')
            setProperty('CupBlackScreen.alpha',0.001)
            addLuaSprite('CupBlackScreen',false)

            makeLuaSprite('DeathCard',cardTexture,400,80)
            setObjectCamera('DeathCard','other')
            scaleObject('DeathCard',0.8,0.8)
            setProperty('DeathCard.angle',-55)
            setProperty('DeathCard.alpha',0)

            makeAnimatedLuaSprite('BfDeath','cup/NewCupheadrunAnim',getProperty('DeathCard.x') - 180,getProperty('DeathCard.y') + 128)
            --makeAnimatedLuaSprite('BfDeath','cup/NewCupheadrunAnim',getProperty('DeathCard.x') + 115,getProperty('DeathCard.y') + 76)
            addAnimationByPrefix('BfDeath','run','Run_cycle_gif copy instance 1',24,true)
            setObjectCamera('BfDeath','other')
            setProperty('BfDeath.alpha',0)
            scaleObject('BfDeath',0.5,0.5)

            makeAnimatedLuaSprite('CupRetryButton','cup/buttons',getProperty('DeathCard.x') + 230,getProperty('DeathCard.y') + 360)
            addAnimationByPrefix('CupRetryButton','Selected','retry white',24,true)
            addAnimationByPrefix('CupRetryButton','Normal','retry basic',24,true)
            setProperty('CupRetryButton.alpha',0)

            makeAnimatedLuaSprite('CupExitButton','cup/buttons',getProperty('DeathCard.x') + 175,getProperty('DeathCard.y') + 425)
            addAnimationByPrefix('CupExitButton','Normal','menu basic',24,true)
            addAnimationByPrefix('CupExitButton','Selected','menu white',24,true)
            setProperty('CupExitButton.alpha',0)
            setObjectCamera('CupExitButton','other')


            setObjectCamera('CupRetryButton','other')
            enableEnd = false
                
            if (songName == 'Knockout') then
                dialogeFound = "You had your run, but now you're done!"
            elseif (songName == 'Satanic-Funkin' or songName == 'Devils-Gambit') then
                dialogeFound = "Anyone who opposes me will be destroyed!"
            else
                dialogeFound = dialogue[math.random(1,#dialogue)]
            end
            
            makeLuaText('CupText',"'"..dialogeFound.."'",500,getProperty('DeathCard.x') + 5,getProperty('DeathCard.y') + 255)
            setObjectCamera('CupText','other')
            setProperty('CupText.color',getColorFromHex('000000'))
            setTextBorder('CupText',0)
            setProperty('CupText.alpha',0)
            setTextFont('CupText','CupheadICFont.ttf')

            precacheImage('cup/BfGhost')
            precacheImage('cup/death')
            precacheImage('cup/cuphead_death')
            precacheImage('cup/NewCupheadrunAnim')
            precacheImage('cup/buttons')
    end
    if string.match(stage,'hall') == 'hall' then
        setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'sans/gameovernormal'); --put in mods/sounds/
        setPropertyFromClass('PauseSubState', 'songName', 'sans/pause'); --put in mods/music/
        IndieCrossGameOverStyle = 'Sans'
    elseif string.match(stage,'factory') == 'factory' then
        setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-bendy-death'); --Character json file for the death animation
        setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'bendy/BendyGameOver'); --put in mods/sounds/
        setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'bendy/BendyHeartbeat'); --put in mods/music/
        setPropertyFromClass('GameOverSubstate', 'endSoundName', 'bendy/BendyClick'); --put in mods/music/
        IndieCrossGameOverStyle = 'Bendy'
    end

end
function onGameOver()
    timePercent = getSongPosition()/getProperty('songLength')
    if not GameOverActive and IndieCrossGameOverStyle == 'Cuphead' then
        setProperty('camHUD.alpha',0.7)
        timePercent = (getSongPosition()/getProperty('songLength') * 1.07)
        cameraShake('camGame',0.01,0.3)
        cameraShake('camHUD',0.01,0.3)
        cameraShake('camOther',0.01,0.3)
        setProperty('CupBlackScreen.alpha',0.4)
        playSound('cup/CupDeath')
        setProperty('boyfriend.visible',false)
        setProperty('BfGhost.alpha',1)
        setProperty('BfGhost.x',getProperty('boyfriend.x'))
        setProperty('BfGhost.y',getProperty('boyfriend.y'))
        addLuaSprite('You re dead',false)
        runTimer('GameOverText',2)
        GameOverActive = true
        addLuaSprite('DeathCard',true)
        addLuaSprite('CupExitButton',true)
        addLuaSprite('CupRetryButton',true)
        addLuaSprite('BfDeath',true)
        addLuaText('CupText',true)
        setPropertyFromClass('PlayState', 'instance.generatedMusic', false)
        setPropertyFromClass('PlayState', 'instance.vocals.volume', 0)
        setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
        timePercent = getSongPosition()/getProperty('songLength')
        return Function_Stop;
    end
    if GameOverActive then
        return Function_Stop
    end
    return Function_Continue;
end

function onPause()
    if GameOverActive and IndieCrossGameOverStyle == 'Cuphead' then
        return Function_Stop
    end
end
function onEndSong()
    if GameOverActive and not enableEnd and IndieCrossGameOverStyle == 'Cuphead' then
        return Function_Stop;
    end
    return Function_Continue;
end


function onUpdate()
    if IndieCrossGameOverStyle == 'Cuphead' then
        setProperty('CupExitButton.angle',getProperty('DeathCard.angle'))
        setProperty('CupRetryButton.angle',getProperty('DeathCard.angle'))
        setProperty('BfDeath.angle',getProperty('DeathCard.angle'))
        setProperty('CupText.angle',getProperty('DeathCard.angle'))

        if GameOverActive then
            setProperty('dad.animation.curAnim.frameRate',0)
            cameraSetTarget('boyfriend')
            setProperty('BfGhost.y',getProperty('BfGhost.y') - 4)

            for notesLength = 0, getProperty('notes.length')-1 do
                setPropertyFromGroup('notes', notesLength, 'active', false)
                setPropertyFromGroup('notes', notesLength, 'canBeHit', false)
            end
            for eventNotes = 0, getProperty('eventNotes.length')-1 do
                removeFromGroup('eventNotes', eventNotes, false)
                removeFromGroup('eventNotes', eventNotes, false)
            end
        end

        if GameOverState == 1 then
            for strumLineNotes = 0, 3 do
                setPropertyFromGroup('playerStrums', strumLineNotes, 'alpha', AlphaCupEffect)
                setPropertyFromGroup('opponentStrums', strumLineNotes, 'alpha', AlphaCupEffect)
            end
            for notesLength = 0, getProperty('notes.length')-1 do
                setPropertyFromGroup('notes', notesLength, 'alpha', AlphaCupEffect)
            end
        end

        if GameOverState == 2 then
            if CupSelection == 0 then
                objectPlayAnimation('CupRetryButton','Selected')
                objectPlayAnimation('CupExitButton','Normal')
                if keyJustPressed('up') or keyJustPressed('down') then
                    playSound('cup/select')
                    CupSelection = 1
                end
        
                if keyJustPressed('accept') then
                    playSound('cup/select')
                    restartSong(false)
                end
            else
                objectPlayAnimation('CupRetryButton','Normal')
                objectPlayAnimation('CupExitButton','Selected')
                if keyJustPressed('up') or keyJustPressed('down') then
                    playSound('cup/select')
                    CupSelection = 0
                end
                if keyJustPressed('accept') or keyJustPressed('esc') or keyJustPressed('back') then
                    playSound('cup/select')
                    exitSong(false);
                end
            end
        end
    end
end



function onTweenCompleted(tween)
    if tween == 'DeathCardAngle' then
        GameOverState = 2
        doTweenAlpha('heyRetryButton','CupRetryButton',1,0.5,'linear')
        doTweenAlpha('heyExitButton','CupExitButton',1,0.5,'linear')
        doTweenAlpha('heyBfRunBlue','BfDeath',1,0.5,'linear')
        doTweenAlpha('heyCupText','CupText',1,0.5,'linear')
        doTweenX('BfRunX','BfDeath',getProperty('DeathCard.x') + (-180 + (295 * timePercent)),1.5,'sineOut')
        doTweenY('BfRunY','BfDeath',getProperty('DeathCard.y') + (128 - (52 * timePercent)),1.5,'sineOut')
    end
end

function onTimerCompleted(tag)
    if tag == 'GameOverText' then
        GameOverState = 1
        doTweenAlpha('heyDeathCard','DeathCard',1,0.6,'linear')
        doTweenAlpha('camHUDBye','camHUD',0,0.3,'linear')
        doTweenAlpha('byeDeathText','You re dead',0,0.3,'linear')
        doTweenAngle('DeathCardAngle','DeathCard',-10,0.7,'cubeOut')
    end
end


