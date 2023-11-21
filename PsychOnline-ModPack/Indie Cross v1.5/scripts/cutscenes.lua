local allowCountDown = true
local allowEndSong = true
function onCreate()
    if isStoryMode and getPropertyFromClass('PlayState','seenCutscene') ~= true then
        if songName == 'Snake-Eyes'  or songName == 'Whoopee' or songName == 'Burning-In-Hell' or songName == 'Final-Stretch' or songName == 'Imminent-Demise' then
            allowCountDown = false
            allowEndSong = false
            setProperty('inCutscene',true)
        end
        if songName == 'Technicolor-Tussle' or songName == 'Knockout' or songName == 'Terrible-Sin' or songName == 'Last-Reel' or songName == 'Nightmare-Run' then
            allowEndSong = false
        end
    end
end
function onStartCountdown()
    if not allowCountDown and not seenCutscene then
        allowCountDown = true
        if songName == 'Snake-Eyes' then
            startVideo('cup/cuphead1')
        elseif songName == 'Whoopee' then
            startVideo('sans/1')
        elseif songName == 'Final-Stretch' then
            startVideo('sans/3')
        elseif songName == 'Burning-In-Hell' then
            startVideo('sans/3b')
        elseif songName == 'Imminent-Demise' then
            startVideo('bendy/1')
        elseif songName == 'Terrible-Sin' then
            startVideo('bendy/2')
        else
            startCountdown()
        end
        return Function_Stop;
    end
end
function onEndSong()
    if not allowEndSong then
        if songName == 'Snake-Eyes' then
            startVideo('cup/cuphead2')
        elseif songName == 'Technicolor-Tussle' then
            startVideo('cup/cuphead3');
        elseif songName == 'Knockout' then
            startVideo('cup/cuphead4');
        elseif songName == 'Whoopee' then
            startVideo('sans/2')
        elseif songName == 'Burning-In-Hell' then
            startVideo('sans/4b')
        elseif songName == 'Final-Stretch' then
            startVideo('sans/4')
        elseif songName == 'Imminent-Demise' then
            startVideo('bendy/2')
        elseif songName == 'Terrible-Sin' then
            startVideo('bendy/3')
        elseif songName == 'Last-Reel' then
            startVideo('bendy/4')
        elseif songName == 'Nightmare-Run' then
            startVideo('bendy/5')
        end
        allowEndSong = true
        triggerEvent('coverScreen','1,other','0')
        return Function_Stop;
    end
    return Function_Continue;
end
