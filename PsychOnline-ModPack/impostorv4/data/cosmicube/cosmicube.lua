function sprite(tag, img, x, y, animated, scroll, scale, camera)
    animated = animated or false
    x = x or getProperty(tag..'.x') or 0
    y = y or getProperty(tag..'.y') or 0
    scroll = scroll or {1, 1}
    scale = scale or {1, 1}
    if anims == false then
        makeLuaSprite(tag, img, x, y)
    else
        makeAnimatedLuaSprite(tag, img, x, y)
    end
    setScrollFactor(tag, scroll[1], scroll[2])
    scaleObject(tag, scale[1], scale[2])
end

function add(spr, group)
    group = group or false
    if luaSpriteExists(spr) then
        addLuaSprite(spr, group)
    elseif luaTextExists(spr) then
        addLuaText(spr, group)
    end
end

local focusPos = {0, 0}
function onCreate()
    setProperty('skipCountdown', true)
    setProperty('camGame.visible', false)
    setProperty('camHUD.visible', false)
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)
    addHaxeLibrary('FlxCamera', 'flixel')
    makeLuaSprite('camLook', nil, 0, 0)
    setObjectCamera('camLook', 'hud')
    screenCenter('camLook')
    focusPos = {getProperty('camLook.x'), getProperty('camLook.y')}
    add('camLook')
    runHaxeCode([[
        game.camOther.target = game.getLuaObject('camLook')
    ]])
    new()
end

local endFirst = true
function onEndSong()
    if endFirst then
        return Function_Stop
    end
    return Function_Continue
end

function onUpdate(e)
    if keyJustPressed('back') then
        endFirst = false
        endSong()
    end
    if keyJustPressed('accept') then
        restartSong()
    end
    scrollCheck(e)
end

local nodeData = {
    {name = 'ghost', sprite = 'defeat/dummypostor2', connection = {'root', 0, 1}},
    {name = 'ghost2', sprite = 'defeat/dummypostor2', connection = {'ghost', 1, 0}},
}
local gap = 150
function new()
    debugPrint('start')
    makeLuaSprite('root', 'defeat/dummypostor1', 0, 0)
    screenCenter('root')
    add('root')
    setObjectCamera('root', 'other')
    for i = 1, #nodeData do
        local curData = nodeData[i]
        local connection = curData.connection[1]
        makeLuaSprite(curData.name, curData.sprite, getProperty(connection..'.x') + curData.connection[2]*gap, getProperty(connection..'.y') + curData.connection[3]*gap)
        setObjectCamera(curData.name, 'other')
        debugPrint('hi')
        add(curData.name)
    end
    debugPrint('end')
end

function lerp(from,to,i)
    -- debugPrint(from+(to-from)*i)
	return from+(to-from)*i
end

local oldMouse = {0, 0}
local newMouse = {0, 0}
function scrollCheck(e)
    newMouse = {getMouseX('other'), getMouseY('other')}
    -- debugPrint(newMouse)
    if mousePressed('left') and newMouse ~= oldMouse then
        local diff = {newMouse[1] - oldMouse[1], newMouse[2] - oldMouse[2]}
        debugPrint(diff)
        focusPos = {focusPos[1] - diff[1], focusPos[2] - diff[2]}
        debugPrint(focusPos)
        setProperty('camLook.x', lerp(getProperty('camLook.x'), focusPos[1], 0.2))
        setProperty('camLook.y', lerp(getProperty('camLook.y'), focusPos[2], 0.2))
        -- runHaxeCode([[
        --     game.variables['HUD'].scroll.x += ]]..diff[1]..[[
        --     game.variables['HUD'].scroll.y += ]]..diff[2]..[[
        -- ]])
    end
    oldMouse = newMouse
end