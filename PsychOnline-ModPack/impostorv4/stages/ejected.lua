local sprGroups = {}

function lerp(from,to,i)
	return from+(to-from)*i
end

function boundTo(value, min, max)
	return math.max(min, math.min(max, value))
end

function wrap(value, min, max)
    return (((value - min) % (max - min)) + (max - min)) % (max - min) + min
end

function makeSprGroup(tag, x, y, code)
    x = x or 0
    y = y or 0
    code = code or false
    table.insert(sprGroups, 1, tag)
    _G[tag] = {['x'] = x, ['y'] = y, members = {}, oldx = y, oldy = y, ['code'] = code}
end

-- use semicolon with other spr stuff
-- anims is an array that goes as follows:
-- anims = {{animName:String, animPrefix:String, ?animIndices:String = '', ?framerate:Float = 24, ?loop:Bool = false}}
-- if making static sprite, set anims to false
function makeSpr(tag, img, x, y, anims, scroll, scale)
    anims = anims or {}
    x = x or getProperty(tag..'.x') or 0
    y = y or getProperty(tag..'.y') or 0
    scroll = scroll or {1, 1}
    scale = scale or {1, 1}
    if anims == false then
        makeLuaSprite(tag, img, x, y)
    else
        makeAnimatedLuaSprite(tag, img, x, y)
        animSpr(tag, anims)
    end
    setScrollFactor(tag, scroll[1], scroll[2])
    scaleObject(tag, scale[1], scale[2])
end

-- anims is an array that goes as follows:
-- anims = {{animName:String, animPrefix:String, ?animIndices:String = '', ?framerate:Float = 24, ?loop:Bool = false}}
function animSpr(tag, anims)
    for _, curAnim in ipairs(anims) do
        for i = #curAnim, 5 do
            table.insert(curAnim, #curAnim + 1, false)
        end

        if not curAnim[4] then curAnim[4] = 24 end

        if not curAnim[4] then
            if curAnim[5] then
                addAnimationByIndicesLoop(tag, curAnim[1], curAnim[2], curAnim[3], curAnim[4])
            else
                addAnimationByIndices(tag, curAnim[1], curAnim[2], curAnim[3], curAnim[4])
            end
        end
    end
end

-- for both spr groups and just adding to stage
-- group acts as sprite and spr acts like front if adding to stage
function add(group, spr)
    spr = spr or false
    if spr == true or spr == false then
        if luaSpriteExists(group) then
            addLuaSprite(group, spr)
        else
            for _, s in ipairs(_G[group].members) do
                addLuaSprite(s, spr)
            end
        end
    else
        table.insert(_G[group].members, 1, spr)
    end
end

function removeGroup(group, destroy)
    destroy = destroy or true
    for _, i in ipairs(_G[group].members) do
        removeLuaSprite(i, destroy)
        removeLuaText(i, destroy)
    end
    if destroy then
        _G[group] = nil
    end
end

function scrollGroup(group, initPoses, wrap, speed, dir, tag, img, anims, scroll, scale, front, x, y)
    makeSprGroup(group, x, y,
    function(tag, elapsed, curGroup)
        local sprDim = getProperty(tag..'.'..curGroup.dir)
        setProperty(tag..'.'..curGroup.dir, wrap(lerp(curGroup.dir, curGroup.dir - curGroup.speed[1], boundTo(elapsed * curGroup.speed[2], 0, 1)), curGroup.wrap[1], curGroup.wrap[2]))
    end)
    _G[group]['wrap'] = wrap
    _G[group]['speed'] = speed
    _G[group]['dir'] = dir
    for i = 0, #initPoses-1 do
        makeSpr(tag..i, img, initPoses[i][1], initPoses[i][2], anims, scroll, scale)
        add(group, tag..i)
    end
    add(group, front)
end

function onCreate()
    setProperty('defaultCamZoom', 0.45)
    makeLuaSprite('sky', 'ejected/sky', -2372.25, -4181.7)
    setScrollFactor('sky', 0, 0)
    addLuaSprite('sky')

    makeLuaSprite('fgCloud', 'ejected/fgClouds', -2660.4, -402)
    setScrollFactor('fgCloud', 0.2, 0.2)
    addLuaSprite('fgCloud')

    scrollGroup(group, initPoses, wrap, speed, dir, tag, img, anims, scroll, scale, x, y)
    scrollGroup(group, initPoses, wrap, speed, dir, tag, img, anims, scroll, scale, x, y)
end

local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx =  275;
local yy =  550;
local xx2 = 275;
local yy2 = 550;
local ofs = 20;
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
    if followchars then
        if not mustHitSection then
            setProperty('defaultCamZoom',0.45)
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
            setProperty('defaultCamZoom',0.45)
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

function onUpdatePost(elapsed)
    for i, tag in ipairs(sprGroups) do
        curGroup = _G[tag]
        if curGroup == null then
            sprGroups[i] = nil
            goto continue
        end
        for _, spr in ipairs(curGroup.members) do
            if not curGroup.code then
                setProperty(spr..'.x', getProperty(spr..'.x') - curGroup.oldx + curGroup.x)
                setProperty(spr..'.y', getProperty(spr..'.y') - curGroup.oldy + curGroup.y)
            else
                curGroup.code(spr, elapsed, curGroup)
            end
        end
        curGroup.oldx = curGroup.x
        curGroup.oldy = curGroup.y
        ::continue::
    end
end