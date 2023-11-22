function onCreatePost()
    precacheImage('characters/whitegreen')
    precacheImage('characters/whitebf')

    initLuaShader('BWShader')
    makeLuaSprite('charShader')
    setSpriteShader('charShader', 'BWShader')

    runHaxeCode([[
        charShader = game.getLuaObject("charShader").shader;
        charShader.setBool('invert', true);
        charShader.setFloat('lowerBound', 0.01);
        charShader.setFloat('upperBound', 0.12);
    ]]);

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
    if eventName == 'Lights out' then
        setProperty('loBlack.alpha', 1)
        cameraFlash('game', 'FFFFFF', 0.35, true)
        if dadName == 'impostor3' then
            triggerEvent('Change Character', 'dad', 'whitegreen')
        else
            runHaxeCode([[game.dad.shader = charShader;]])
        end
        if boyfriendName == 'bf' then
            triggerEvent('Change Character', 'bf', 'whitebf')
        else
            runHaxeCode([[game.boyfriend.shader = charShader;]])
        end
        runHaxeCode([[game.iconP1.shader = charShader;]])
        runHaxeCode([[game.iconP2.shader = charShader;]])
    end
end