function onCreate()
        makeLuaSprite('Black?','',0,0)
        setObjectCamera('Black?','other')
        makeGraphic('Black?',screenWidth,screenHeight,'646464')
        setProperty('Black?.alpha',0)
        setBlendMode('Black?','SUBTRACT')
        addLuaSprite('Black?',true)
end

function onStepHit()

    if curStep == 16 then
        doTweenAlpha('BlackLightEffect', 'Black?', 0.5, 2,'quardInOut')
    end

    if curStep == 159 then
        doTweenAlpha('BlackLightEffect', 'Black?', 0, 2,'quardInOut')
    end
    if curStep > 159 and getProperty('Black?.alpha') <= 0 then
        removeLuaSprite('Black?',true)
    end
end