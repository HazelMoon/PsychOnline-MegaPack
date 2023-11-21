local allowCountdown = false
function onStartCountdown()
    if not allowCountdown and isStoryMode and not seenCutscene then --Block the first countdown
        setProperty('inCutscene', true);
        runTimer('startDialogue', 0.8);
        allowCountdown = true;
        return Function_Stop;
    end
    return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'startDialogue' then
        startDialogue('dialogue', '');
    end
end

function onNextDialogue(count)
    print(count);
    if count == 5 then
        playSound('confirmMenu', 0.4);
    end
end