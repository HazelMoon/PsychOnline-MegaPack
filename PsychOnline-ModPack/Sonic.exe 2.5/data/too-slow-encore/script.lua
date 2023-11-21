
function onCreate()
    makeLuaSprite('blackscreenSlow','',0,0)
    setObjectCamera('blackscreenSlow','hud')
    makeGraphic('blackscreenSlow',screenWidth,screenHeight,'000000')
end
function onStepHit()
    if curStep == 384 then
        addLuaSprite('blackscreenSlow',false)
        setProperty('blackscreenSlow.alpha',1)
    end
    if curStep == 400 then
        doTweenAlpha('byeBlackSlow','blackscreenSlow',0,0.5,'linear')
    end
end
function onTweenCompleted(tag)
    if tag == 'byeBlackSlow' then
        removeLuaSprite('blackscreenSlow',true)
    end 
end
