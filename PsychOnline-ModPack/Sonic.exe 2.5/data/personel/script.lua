function onCreate()
    setProperty('camGame.alpha',0.001)
end
function onSongStart()
    if curStep > 32 then
        setProperty('camGame.alpha',1)
        close(true)
    end
end
function onStepHit()
    if curStep == 32 then
        setProperty('camGame.alpha',1)
        close(true)
    end
end