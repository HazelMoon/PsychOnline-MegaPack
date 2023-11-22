
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0
local xx = 1300;
local yy = 700;
local xx2 = 1800;
local yy2 = 700;
local ofs = 10;
local followchars = true;
local del = 0;
local del2 = 0;

function onCreate()
    addLuaScript('custom_events/chromToggle')
    makeLuaSprite('bg', 'airship/graybg')
    setProperty('bg.active', false)
    addLuaSprite('bg')

    makeAnimatedLuaSprite('thebackground', 'airship/grayglowy', 1930, 400)
    addAnimationByPrefix('thebackground', 'bop', 'jar??')
    playAnim('thebackground', 'bop')
    addLuaSprite('thebackground')

    makeAnimatedLuaSprite('crowd', 'airship/grayblack', 240, 350)
    addAnimationByPrefix('crowd', 'bop', 'whoisthismf', 24, false)
    playAnim('crowd', 'bop', true)
    addLuaSprite('crowd')

    makeLuaSprite('lightoverlay', 'airship/grayfg')
    setProperty('lightoverlay.active', false)
    addLuaSprite('lightoverlay', true)

    makeLuaSprite('lightoverlay2', 'airship/graymultiply')
    setBlendMode('lightoverlay2', 'multiply')
    setProperty('lightoverlay2.active', false)
    addLuaSprite('lightoverlay2', true)

    makeLuaSprite('lightoverlay3', 'airship/graymultiply')
    setBlendMode('lightoverlay3', 'multiply')
    setProperty('lightoverlay3.alpha', 0.4)
    setProperty('lightoverlay3.active', false)
    addLuaSprite('lightoverlay3', true)
end

function onCreatePost()
    initLuaShader('ChromaticAbberation')
    makeLuaSprite('ChromaticAbberation')
    setSpriteShader('ChromaticAbberation', 'ChromaticAbberation')
    runHaxeCode([[setVar('ChromaticAbberation', game.getLuaObject('ChromaticAbberation').shader);]])
    runHaxeCode([[getVar('ChromaticAbberation').setFloat('amount', -0.5);]])

    runHaxeCode([[game.camGame.setFilters([new ShaderFilter(getVar('ChromaticAbberation'))]);]])
end

function onBeatHit()
    if curBeat % 2 == 0 then
        playAnim('crowd', 'bop', true)
    end
end

function onUpdate()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.8)
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

            setProperty('defaultCamZoom',0.8)
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
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
    
end

