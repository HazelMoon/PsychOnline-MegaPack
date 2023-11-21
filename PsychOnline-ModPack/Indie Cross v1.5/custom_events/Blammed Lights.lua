function onCreate()
    makeLuaSprite('blammedLight',nil,0,0)
    setScrollFactor('blammedLight',0,0)
    setProperty('blammedLight.alpha',0)
end
function onEvent(name,v1,v2)
    if name == 'Blammed Lights' then
        local light = tonumber(v1)
        local color = '0000000'
        local flashOrder = getObjectOrder('boyfriendGroup')
        local time = 1
        local easing = 'linear'

        local comma1v1 = 0
        local comma2v1 = 0

        local comma1v2 = 0
        local comma2v2 = 0
        if string.find(v1,',',0,true) ~= nil then
            comma1v1,comma2v1 = string.find(v1,',',0,true)
            light = tonumber(string.sub(v1,0,comma1v1 - 1))
            color = string.sub(v1,comma2v1 + 1)
        end
        if string.find(v2,',',0,true) ~= nil then
            comma1v2,comma2v2 = string.find(v2,',',0,true)
            time = tonumber(string.sub(v2,0,comma1v2 - 1))
            easing = string.sub(v2,comma2v2 + 1)
        else
            if v2 ~= '' then
                time = tonumber(v1)
            end
        end
        if flashOrder > getObjectOrder('dadGroup') - 1 then
            flashOrder = getObjectOrder('dadGroup') - 1
        end
        if light == 0 then
            if getProperty('blammedLight.alpha') > 0 then
                if time ~= 0 then
                doTweenAlpha('blammedLightBye','blammedLight',0,time,easing)
                else
                    setProperty('blammedLight.alpha',0)
                end
                light = -1
            end
        elseif light ~= 0 then
            makeGraphic('blammedLight',screenWidth,screenHeight,color)
            cancelTween('blammedLightBye')
            setObjectOrder('blammedLight',flashOrder)
            if time ~= 0 then
                doTweenAlpha('blammedLightHello','blammedLight',1,1,easing)
            else
                setProperty('blammedLight.alpha',1)
            end
            addLuaSprite('blammedLight',false)
        end
    end
end
function onUpdate()
    setProperty('blammedLight.x',math.min(0,-150 * ((1 - getProperty('camGame.zoom')) * 10)))
    setProperty('blammedLight.y',math.min(0,-100 *((1 - getProperty('camGame.zoom')) * 10)))
    local scale = math.max(1,1 + ((1 - getProperty('camGame.zoom'))*3))
    scaleObject('blammedLight',scale,scale)
end
function onTweenCompleted(name)
    if name == 'blammedLightBye' then
        removeLuaSprite('blammedLight',false)
    end
end