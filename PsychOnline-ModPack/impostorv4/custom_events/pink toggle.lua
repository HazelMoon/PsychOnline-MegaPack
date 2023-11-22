local show = false
local songSpeed = 0
-- local flashStrength = 0

function onCreate()
    luaDebugMode = true
end

function onCreatePost()
    initLuaShader("ColorShader")
    makeLuaSprite('heartColorShader')
    setSpriteShader("heartColorShader", "ColorShader")

    runHaxeCode([[
        heartColorShader = game.getLuaObject("heartColorShader").shader;
        heartColorShader.setFloat('amount', 0)
    ]]);

    makeAnimatedLuaSprite('heartsImage', 'mira/hearts', -25, 0)
    addAnimationByPrefix('heartsImage', 'boil', 'Symbol 2000', 24, true)
    playAnim('heartsImage', 'boil')
    setObjectCamera('heartsImage', 'other')
    setProperty('heartsImage.alpha', 0)
    runHaxeCode('game.getLuaObject("heartsImage").shader = heartColorShader')
    addLuaSprite('heartsImage', true)

    makeLuaSprite('pinkVignette', 'mira/vignette', 0, 0)
    setObjectCamera('pinkVignette', 'hud')
    setProperty('pinkVignette.alpha', 0)
    setBlendMode('pinkVignette', 'add')

    makeLuaSprite('pinkVignette2', 'mira/vignette2', 0,0)
    setObjectCamera('pinkVignette2', 'hud')
    setProperty('pinkVignette2.alpha', 0)

    addLuaSprite('pinkVignette2')
    addLuaSprite('pinkVignette')

    songSpeed = playbackRate
end

local fadeTime = 0.75 -- i found you fader!
local heartyID = 0
local heartyName = ''
-- local alivePar = {}
local lifespan = 0
local heartEmitter = {500, 1050}
local particleWidth = 600.225
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'hearty' and show then
        heartyID = heartyID + 1
        heartyName = 'lilHeart'..heartyID
        lifespan = getRandomFloat(4.0, 4.5) / songSpeed
        makeAnimatedLuaSprite(heartyName, 'mira/littleheart', heartEmitter[1] + getRandomFloat(0-particleWidth, particleWidth), heartEmitter[2])
        addAnimationByPrefix(heartyName, 'hearts', 'littleheart', 24, true)
        scaleObject(heartyName, 1.75, 1.75)
        setBlendMode(heartyName, 'add')
        runHaxeCode('game.getLuaObject("'..heartyName..'").shader = heartColorShader')
        setProperty(heartyName..'.velocity.x', getRandomFloat(-50, 50) * songSpeed)
        setProperty(heartyName..'.velocity.y', getRandomFloat(-800, -400) * songSpeed)
        setObjectCamera(heartyName, 'hud')
        setObjectOrder(heartyName, 0)
        playAnim(heartyName, 'hearts', true, false, getRandomInt(0,2))
        addLuaSprite(heartyName, true)
        doTweenX('vTweenX'..heartyID, heartyName..'.velocity', getRandomFloat(-100, 100) * songSpeed, lifespan, 'linear')
        doTweenY('vTweenY'..heartyID, heartyName..'.velocity', getRandomFloat(-800, 0) * songSpeed, lifespan, 'linear')
        doTweenX('dTweenX'..heartyID, heartyName..'.drag', getRandomFloat(5, 10) * songSpeed, lifespan, 'linear')
        doTweenY('dTweenY'..heartyID, heartyName..'.drag', getRandomFloat(5, 10) * songSpeed, lifespan, 'linear')
        doTweenX('sTweenX'..heartyID, heartyName..'.scale', 0, lifespan, 'linear')
        doTweenY('sTweenY'..heartyID, heartyName..'.scale', 0, lifespan, 'linear')
    end
end

local removeHeart = ''
function onTweenCompleted(tag)
    if string.find(tag, 'dTweenY') then
        removeHeart = 'lilHeart'..stringSplit(tag, 'Y')[2]
        removeLuaSprite(removeHeart)
    end
end

function onBeatHit()
    if show then
        if curBeat % 2 == 1 then
            setProperty('pinkVignette.alpha', 1.00)
            doTweenAlpha('pinkTw3', 'pinkVignette', 0.2, 1.2 / songSpeed, 'sineout')

            setShaderFloat('heartColorShader', 'amount', 0.50)
            runHaxeCode([[
                setVar('amount', heartColorShader.getFloat('amount'));
                FlxTween.num(getVar('amount'), 0, 0.75, {ease: FlxEase.sineOut},
                function(num){
                    heartColorShader.setFloat('amount', num); setVar('amount', num);
                });
            ]]);
        end
    end
end

function onEvent(t, v1, v2)
    if t == 'pink toggle' then
        setProperty('heartsImage.alpha', 1)
        setProperty('pinkVignette.alpha', 1)

        show = not show
        if show then
            if v1 == nil or v1 == '' then
                fadeTime = 0.5 / songSpeed
            else
                fadeTime = tonumber(v1)*1.2 / songSpeed
            end
            if v1 == nil or v1 == '' then fadeTime = 0.01 / songSpeed end
            runTimer('hearty', getRandomFloat(0.3, 0.4) / songSpeed, 0)
            setProperty('pinkVignette2.alpha', 0.3)
        elseif not show then
            if v1 == nil or v1 == '' then
                fadeTime = 0.5 / songSpeed
            else
                fadeTime = tonumber(v1)*2 / songSpeed
            end
            cancelTimer('hearty')
            cancelTween('pinkTw3')
            cancelTween('pinkTw33')
            setProperty('pinkVignette2.alpha', 0.4)
            doTweenAlpha('pinkTw', 'heartsImage', 0, fadeTime, 'cubeinout')
            doTweenAlpha('pinkTw2', 'pinkVignette', 0, fadeTime, 'cubeinout')
            doTweenAlpha('pinkTw22', 'pinkVignette2', 0, fadeTime, 'cubeinout')
        end
        setShaderFloat('heartColorShader', 'amount', 1.00)
        runHaxeCode([[
            setVar('amount', heartColorShader.getFloat('amount'));
            FlxTween.num(getVar('amount'), 0, ]]..fadeTime..[[, {ease: FlxEase.cubeInOut},
            function(num){
                heartColorShader.setFloat('amount', num); setVar('amount', num);
            });
        ]]);
    end
end