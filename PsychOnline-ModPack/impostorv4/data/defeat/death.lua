local alrCutscene = false
local canEnd = false
local deathTime = 0
local kaderEngine = false

function onGameOver()
    if not alrCutscene then
        if not canEnd then
            -- debugPrint(canEnd, ' ', alrCutscene)
            setProperty('iconP1.visible', false)
            setProperty('iconP2.visible', false)
            runTimer('defeatDeath', 0.0001)
            canEnd = true
        end
        return Function_Stop
    end
    return Function_Continue
end

function onGameOverStart()
    if kaderEngine then
        makeLuaSprite('defeatBG', nil, -70, -70)
        makeGraphic('defeatBG', 5000, 5000, '0xFF1a182e')
        screenCenter('defeatBG')
        addLuaSprite('defeatBG')
    end
end

function onCreate()
    precacheSound('edefeat')
    precacheImage('characters/defeat_death')
    precacheImage('characters/bf_defeat_death')
    precacheImage('characters/bf_defeat_death_balls')
    precacheImage('characters/defeatDeath')
    precacheImage('characters/noMoreBalls')
end

function onPause()
    if canEnd then
        return Function_Stop
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'defeatDeath' then
        deathTime = getPropertyFromClass('Conductor', 'songPosition')

        runHaxeCode([[game.vocals.pause();]])
        if not kaderEngine then
            runHaxeCode([[FlxG.sound.music.pause();]])
        end

        -- setProperty('vocals.volume', 0)
        -- setPropertyFromClass('flixel.FlxG', 'sound.music', 0)

        for i = 0, getProperty('notes.length')-1 do
            setPropertyFromGroup('notes', i, 'visible', false);
            setPropertyFromGroup('notes', i, 'blockHit', true);
        end

        triggerEvent('Camera Follow Pos', '480', '662')

        if kaderEngine then
            setProperty('camHUD.alpha', 0)
            setProperty('defaultCamZoom', 0.9)
            playSound('black-death')
            setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup') + 1)
        else
            triggerEvent('Change Character', '1', 'blackKill')
            doTweenAlpha('byeHUD', 'camHUD', 0, 0.7, 'quadinout')
    
            setProperty('dad.x', -85)
            setProperty('dad.y', 275)

            setProperty('defaultCamZoom', 0.65)
            playSound('edefeat')
        end

        if kaderEngine then
            runTimer('defDed3', 0.55)
        else
            runTimer('defDed1', 1.8)
            runTimer('defDed2', 2.7)
            runTimer('defDed3', 3.4)
        end

        triggerEvent('Play Animation', 'kill1', 'dad')
    elseif tag == 'defDed1' then
        triggerEvent('Play Animation', 'kill2', 'dad')

        setProperty('defaultCamZoom', 0.5)
        triggerEvent('Camera Follow Pos', '840', '662')
    elseif tag == 'defDed2' then
        triggerEvent('Play Animation', 'kill3', 'dad')
    elseif tag == 'defDed3' then
        alrCutscene = true
    end
end

function onUpdate(elapsed)
    if canEnd then
        if keyJustPressed('back') or keyJustPressed('accept') then end -- disables pausing for some reason lmfao
        setPropertyFromClass('backend.Conductor', 'songPosition', deathTime)
    end
end

function onEvent(eventName, value1, value2)
    if eventName == 'Defeat Retro' then
        kaderEngine = not kaderEngine
    end

    if kaderEngine then
        if getRandomBool(10) then
            setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'bf-defeat-balls');
            setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/no-balls');
        else
            setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'bf-defeat-old');
            setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/loss-defeat');
        end
    end
end