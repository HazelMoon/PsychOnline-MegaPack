function setSpriteSize(sprite, size)
    setGraphicSize(sprite, math.ceil(getProperty(sprite..'.width') * size - 1))
end

local globalOffset = {420, 300} -- lazy woo
function makeSprite(spr, img, x, y)
    makeLuaSprite(spr, img, x + globalOffset[1], y + globalOffset[2])
end

function onCreate()
    luaDebugMode = true

    makeSprite('sky', 'polus/newsky', 0, 0)
    setSpriteSize('sky', 0.75)
    setProperty('sky.active', false)
    addLuaSprite('sky')

    makeSprite('cloud', 'polus/newcloud', 0, 0)
    setSpriteSize('cloud', 0.75)
    setProperty('cloud.alpha', 0.59)
    setProperty('cloud.active', false)
    addLuaSprite('cloud')

    makeSprite('rocks', 'polus/newrocks', 0, 0)
    setSpriteSize('rocks', 0.75)
    setProperty('rocks.alpha', 0.49)
    setProperty('rocks.active', false)
    addLuaSprite('rocks')

    makeSprite('backwall', 'polus/backwall', 0, 0)
    setSpriteSize('backwall', 0.75)
    setProperty('backwall.active', false)
    addLuaSprite('backwall')

    makeSprite('stage', 'polus/newstage', 0, 0)
    setSpriteSize('stage', 0.75)
    setProperty('stage.active', false)
    addLuaSprite('stage')

    makeLuaSprite('mainoverlay', 'polus/newoverlay', 500, 250)
    setProperty('mainoverlay.active', false)
    setSpriteSize('mainoverlay', 0.75)
    setProperty('mainoverlay.alpha', 0.44)
    setBlendMode('mainoverlay', 'add')
    addLuaSprite('mainoverlay', true)

    makeLuaSprite('lightoverlay', 'polus/newoverlay', 500, 250)
    setProperty('lightoverlay.active', false)
    setSpriteSize('lightoverlay', 0.75)
    setProperty('lightoverlay.alpha', 0.21)
    setBlendMode('lightoverlay', 'add')
    addLuaSprite('lightoverlay', true)

    makeAnimatedLuaSprite('snow2', 'polus/snowback', 1150-500, 600-350)
    addAnimationByPrefix('snow2', 'cum', 'Snow group instance 1')
    playAnim('snow2', 'cum')
    setProperty('snow2.alpha', 0.53)
    setSpriteSize('snow2', 2)
    addLuaSprite('snow2', true)

    makeAnimatedLuaSprite('snow', 'polus/snowfront', 1150-500, 800-350)
    addAnimationByPrefix('snow', 'cum', 'snow fall front instance 1')
    playAnim('snow', 'cum')
    setProperty('snow.alpha', 0.37)
    setSpriteSize('snow', 2)
    addLuaSprite('snow', true)
end

local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx =  1600;
local yy =  1300;
local xx2 = 1800;
local yy2 = 1300;
local ofs = 10;
local followchars = true;
local del = 0;
local del2 = 0;

function onUpdate()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.7)
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

