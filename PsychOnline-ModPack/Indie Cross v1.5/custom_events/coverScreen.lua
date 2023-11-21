local screenCreated = false
local currentLayer = 'hud'
local currentColor = '000000'
function createCover(alpha,layer,color)
    makeLuaSprite('coverScreen',nil,0,0)
    makeGraphic('coverScreen',screenWidth,screenHeight,color)
    setProperty('coverScreen.alpha',alpha)
    addLuaSprite('coverScreen',false)
    setLayer(layer)
    screenCreated = true
end
function onEvent(name,v1,v2)
    if name == 'coverScreen' then
        local comma1v1 = 0
        local comma2v1 = 0
        local comma3v1 = 0
        local comma4v1 = 0
        local target = 1
        local comma1v2 = 0
        local comma2v2 = 0
        local color = '000000'
        local speed = 0
        local layer = ''
        local easing = 'linearOut'
        if v1 ~= '' then
            comma1v1,comma2v1 = string.find(v1,',',0,true)
            if comma1v1 ~= nil then
                comma3v1,comma4v1 = string.find(v1,',',comma2v1 + 1,true)
                target = string.lower(string.sub(v1,0,comma1v1 - 1))
                if comma3v1 ~= nil then
                    layer = string.sub(v1,comma2v1 + 1,comma3v1 - 1)
                    color = string.sub(v1,comma4v1 + 1)
                else
                    layer = string.lower(string.sub(v1,comma2v1 + 1))
                end
            else
                target = string.lower(v1)
            end
        end
        if v2 ~= '' then
            comma1v2,comma2v2 = string.find(v2,',',0,true)
            if comma1v2 ~= nil then
                speed = tonumber(string.sub(v2,0,comma1v2 - 1))
                easing = string.lower(string.sub(v2,comma2v2 + 1))
            else
                speed = tonumber(v2)
            end
        end
        if layer == '.' or layer == '' then
            layer = currentLayer
        else
            currentLayer = layer
        end
        if screenCreated ~= true then
            createCover(0,currentLayer,color)
        else
            if currentColor ~= color then
                makeGraphic('coverScreen',screenWidth,screenHeight,color)
            end
            if currentLayer ~= layer then
                setLayer(currentLayer)
            end
        end
        if speed ~= 0 and speed ~= nil then
            if target ~= '0' then
                doTweenAlpha('coverScreenAppear','coverScreen',target,speed,easing)
            else
                doTweenAlpha('coverScreenBye','coverScreen',target,speed,easing)
            end
        else
            if target ~= '0' then
                cancelTween('coverScreenAppear')
                cancelTween('coverScreenBye')
                setProperty('coverScreen.alpha',tonumber(target))
            else
                removeLuaSprite('coverScreen',false)
                screenCreated = false
            end
        end
        currentLayer = layer
        currentColor = color
    end
end
function setLayer(layer)
    if layer == nil then
        layer = 'hud'
    end
    if layer == 'game' then
        setObjectCamera('coverScreen','hud')
        setObjectOrder('coverScreen',0)
    else
        setObjectCamera('coverScreen',layer)
    end
end
function onTweenCompleted(tag)
    if tag == 'coverScreenBye' then
        removeLuaSprite('coverScreen',false)
        screenCreated = false
    end
end