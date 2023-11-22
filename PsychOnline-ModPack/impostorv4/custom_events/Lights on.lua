function onCreatePost()
    if not luaSpriteExists('loBlack') then
        makeLuaSprite('loBlack', nil, 0, 0)
        makeGraphic('loBlack', screenWidth * 4, screenHeight + 700, '000000')
        setProperty('loBlack.alpha', 0)
        addLuaSprite('loBlack')
        screenCenter('loBlack')
        local gfOrder = getObjectOrder('gfGroup')
        setObjectOrder('loBlack', gfOrder + 1)
    end
end

function onEvent(eventName, value1, value2)
    if eventName == 'Lights on' then
        setProperty('loBlack.alpha', 0)
        cameraFlash('game', '000000', 0.35, true)
        if dadName == 'whitegreen' then
            triggerEvent('Change Character', 'dad', 'impostor3')
        else
            runHaxeCode([[game.dad.shader = null;]])
        end
        if boyfriendName == 'whitebf' then
            triggerEvent('Change Character', 'bf', 'bf')
        else
            runHaxeCode([[game.boyfriend.shader = null;]])
        end
        runHaxeCode([[game.iconP1.shader = null;]])
        runHaxeCode([[game.iconP2.shader = null;]])
    end
end