local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 1760;
local yy = 380;
local xx2 = 1900;
local yy2 = 435;
local ofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;

function onCreate()
    makeAnimatedLuaSprite('lava', 'polus/wallBP', -400, -650)
    addAnimationByPrefix('lava', 'bop', 'Back wall and lava')
    playAnim('lava', 'bop')
    addLuaSprite('lava')

    makeLuaSprite('ground', 'polus/platform', 1050, 650)
    setProperty('ground.active', false)
    addLuaSprite('ground')

    makeAnimatedLuaSprite('bubbles', 'polus/bubbles', 800, 850)
    addAnimationByPrefix('bubbles', 'bop', 'Lava Bubbles')
    playAnim('bubbles', 'bop')
    addLuaSprite('bubbles')

    makeLuaSprite('lavaOverlay', 'polus/overlaythjing', 600, -220)
    scaleObject('lavaOverlay', 1.5, 1.5)
    setBlendMode('lavaOverlay', 'add')
    setProperty('lavaOverlay.alpha', 0.7)
    setProperty('lavaOverlay.active', false)
    addLuaSprite('lavaOverlay', true)
end

local songSpeed = 1
function onCreatePost()
    initLuaShader('heatwaveShader')
    makeLuaSprite('heat', 'heatwave')
    makeLuaSprite('heatwaveShader')
    setSpriteShader('heatwaveShader', 'heatwaveShader')
    setShaderSampler2D('heatwaveShader', 'distortTexture', 'polus/heatwave')
    runHaxeCode([[setVar('heatwaveShader', game.getLuaObject('heatwaveShader').shader);]])

    initLuaShader('ChromaticAbberation')
    makeLuaSprite('ChromaticAbberation')
    setSpriteShader('ChromaticAbberation', 'ChromaticAbberation')
    runHaxeCode([[setVar('ChromaticAbberation', game.getLuaObject('ChromaticAbberation').shader);]])
    runHaxeCode([[getVar('ChromaticAbberation').setFloat('amount', -0.2);]])

    runHaxeCode([[game.camGame.setFilters([new ShaderFilter(getVar('heatwaveShader')), new ShaderFilter(getVar('ChromaticAbberation'))]);]])

    runTimer('ember', 0.1)
    songSpeed = playbackRate
    -- followchars = false
end

local fadeTime = 0.75 -- i found you fader!
local heartyID = 0
local heartyName = ''
-- local alivePar = {}
local lifespan = 0
local heartEmitter = {1800, 1000}
local particleWidth = 1200.45
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'ember' then
        runTimer('ember', getRandomFloat(0.3, 0.4))
        -- debugPrint(heartyID)
        heartyID = heartyID + 1
        heartyName = 'ember'..heartyID
        lifespan = getRandomFloat(4.0, 4.5) / songSpeed
        makeAnimatedLuaSprite(heartyName, 'polus/ember', heartEmitter[1] + getRandomFloat(0-particleWidth, particleWidth), heartEmitter[2])
        addAnimationByPrefix(heartyName, 'ember', 'ember')
        scaleObject(heartyName, 1.75, 1.75)
        setBlendMode(heartyName, 'add')
        setProperty(heartyName..'.velocity.x', getRandomFloat(-50, 50) * songSpeed)
        setProperty(heartyName..'.velocity.y', getRandomFloat(-400, -800) * songSpeed)
        setProperty(heartyName..'.scale.x', getRandomFloat(1, 0.8) * songSpeed)
        setProperty(heartyName..'.scale.y', getRandomFloat(1, 0.8) * songSpeed)
        playAnim(heartyName, 'ember', true, false, getRandomInt(0,9))
        addLuaSprite(heartyName, true)
        doTweenX('vTweenX'..heartyID, heartyName..'.velocity', getRandomFloat(-100, 100) * songSpeed, lifespan, 'linear')
        doTweenY('vTweenY'..heartyID, heartyName..'.velocity', getRandomFloat(0, -800) * songSpeed, lifespan, 'linear')
        doTweenX('dTweenX'..heartyID, heartyName..'.drag', getRandomFloat(5, 10) * songSpeed, lifespan, 'linear')
        doTweenY('dTweenY'..heartyID, heartyName..'.drag', getRandomFloat(5, 10) * songSpeed, lifespan, 'linear')
        doTweenX('sTweenX'..heartyID, heartyName..'.scale', 0, lifespan, 'linear')
        doTweenY('sTweenY'..heartyID, heartyName..'.scale', 0, lifespan, 'linear')
        -- triggerEvent('Camera Follow Pos', getProperty(heartyName..'.x'), getProperty(heartyName..'.y'))
    end
end

local removeHeart = ''
function onTweenCompleted(tag)
    if string.find(tag, 'dTweenY') then
        removeHeart = 'ember'..stringSplit(tag, 'Y')[2]
        removeLuaSprite(removeHeart)
    end
end

local iTime = 0
function onUpdate()
    setProperty("gf.alpha", 0)

	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.6)
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else

            setProperty('defaultCamZoom',0.7)
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end

    iTime = iTime + elapsed
    runHaxeCode([[getVar('heatwaveShader').setFloat('iTime', ]]..iTime..[[);]])
end