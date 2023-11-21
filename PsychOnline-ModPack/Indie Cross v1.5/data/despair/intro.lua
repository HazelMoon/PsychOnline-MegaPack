function onCreatePost()
    setProperty('dad.alpha', 0.01)
end
function onEvent(name,v1,v2)
    if name == 'Play Animation' and v1 == 'Intro' and v2 == 'dad' and getProperty('dad.alpha') == 0.01 then
        setProperty('dad.alpha', 1)
        playSound('bendy/nmbendy_land')
        cameraShake('game',0.06,0.35)
    end
end