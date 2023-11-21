local loopingStatic =  false
function onCreate()
    makeAnimatedLuaSprite('FlashingShitTooSlow','daSTAT',0,0)
    addAnimationByPrefix('FlashingShitTooSlow','static','staticFLASH',24,false)
    setProperty('FlashingShitTooSlow.alpha',0.5)
    scaleObject('FlashingShitTooSlow',3.2,2.45)
    setObjectCamera('FlashingShitTooSlow','other')
end
function onUpdate()
    if getProperty('FlashingShitTooSlow.animation.curAnim.finished') == true then
        if loopingStatic == false then
            removeLuaSprite('FlashingShitTooSlow',false)
        else
            objectPlayAnimation('FlashingShitTooSlow','static',true)
        end
    end
end
function onEvent(name,v1,v2)
    if name == 'TooSlowFlashinShit' then
        if string.lower(v1) ~= 'destroy' then
            addLuaSprite('FlashingShitTooSlow',true)
            objectPlayAnimation('FlashingShitTooSlow','static',true)
            playSound('staticBUZZ')
        else
            removeLuaSprite('FlashingShitTooSlow',false)
            loopingStatic = false
        end
        if string.lower(v2) == 'true' then
            runTimer('loopBUZZsong',0.157)
            loopingStatic = true
        else
            loopingStatic = false
        end
    end
end
function onTimerCompleted(tag)
    if tag == 'loopBUZZsong' and loopingStatic == true then
        playSound('staticBUZZ')
        runTimer('loopBUZZsong',0.157)
    end
end