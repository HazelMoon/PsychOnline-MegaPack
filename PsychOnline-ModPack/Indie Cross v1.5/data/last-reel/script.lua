local enableInk = false
local inkMax = 3
function onCreate()
    if (not lowQuality) then
        precacheImage('bendy/third/Ink_Shit')
        precacheImage('bendy/third/InkRain')
        for inkShit = 1,inkMax do
            makeLuaSprite('InkedShit'..inkShit,'bendy/third/Ink_Shit',1000 - (760 * (inkShit - 1)),0)
            setObjectCamera('InkedShit'..inkShit,'hud')
            setProperty('InkedShit'..inkShit..'.alpha',0)
        end
        makeAnimatedLuaSprite('Inked-Rain','bendy/third/InkRain',0,0)
        addAnimationByPrefix('Inked-Rain','Rain','erteyd instance 1',24,true)
        setObjectCamera('Inked-Rain','hud')
    end
end
local fps = 0
function onUpdate(el)
    if (not lowQuality) then
        if enableInk then
            fps = fps + el
            if fps >= 1/240 then
                setProperty('InkedShit1.x',getProperty('InkedShit1.x') + 2)
                for inkShit = 2,inkMax do
                    setProperty('InkedShit'..inkShit..'.x',getProperty('InkedShit1.x') - (762 * (inkShit - 1)))
                end
                if getProperty('InkedShit3.x') >= 0 then
                    setProperty('InkedShit1.x',getProperty('InkedShit2.x'))
                end
            end
        end
    end
end
function onBeatHit()
    if (curStep > 1664 and curStep < 1792) then
        if (getProperty('health') > 0.05 and curStep < 1792) then
            setProperty('health',getProperty('health') - 0.005)
        end
    end
end
function onStepHit()
    if (not lowQuality) then
        if (curStep == 1664) then
            for inkShit = 1,inkMax do
                enableInk = true
                addLuaSprite('InkedShit'..inkShit,false)
                doTweenAlpha('heyInk'..inkShit,'InkedShit'..inkShit,0.6,1,'linear')
            end
            addLuaSprite('Inked-Rain', true)
            doTweenAlpha('heyInkRain','Inked-Rain',1,1,'linear')
        elseif (curStep == 1792) then
            for inkShit = 1,3 do
                doTweenAlpha('byeInk'..inkShit,'InkedShit'..inkShit,0,1,'linear')
            end
            doTweenAlpha('byeInkRain','Inked-Rain',0,1,'linear')
        end
    end
end
function onTweenCompleted(tag)
    if tag == 'byeInkRain' then
        for ink = 1,3 do
            removeLuaSprite('InkedShit'..ink,true)
        end
        enableInk = false
    end
end