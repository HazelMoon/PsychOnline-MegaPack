function onCreate()
    makeLuaSprite('SansSwap',nil,0,0)
    setObjectCamera('SansSwap','hud')
    makeGraphic('SansSwap',screenWidth + 10,screenHeight + 10,'000000')
    setProperty('SansSwap.alpha',0.001)
    addLuaSprite('SansSwap',false)
end
function onEvent(name,v1)
    if name == 'SansSwap' then
        if v1 ~= '0' then
            makeLuaSprite('SansSwap',nil,0,0)
            setObjectCamera('SansSwap','hud')
            makeGraphic('SansSwap',screenWidth + 10,screenHeight + 10,'000000')
            setProperty('SansSwap.alpha',1)
            addLuaSprite('SansSwap',false)
        else
            removeLuaSprite('SansSwap',true)

        end
        playSound('sans/countdown')
    end
end