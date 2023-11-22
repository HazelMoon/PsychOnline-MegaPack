local u = false
local r = 0
local shot = false
local agent = 1
local health = 0
local xx = 700
local yy = -2000
local xx2 = 1634.05
local yy2 = -54.3
local ofs = 50
local followchars = true
local del = 0
local del2 = 0

local danceCycle = {'danceLeft', 'danceRight'}
local bfDanced = 0.5
local blackDanced = 0.5
local bfSuffix = false

local sprGroups = {}

function makeSprGroup(tag, x, y)
    x = x or 0
    y = y or 0
    table.insert(sprGroups, 1, tag)
    _G[tag] = {['x'] = x, ['y'] = y, members = {}, oldx = y, oldy = y}
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

function onEvent(eventName, value1, value2)
    if eventName == 'scream danger' then
        setProperty('airshipskyflash.alpha', 1)
        playAnim('airshipskyflash', bop)
    elseif eventName == 'unscream danger' then
        setProperty('airshipskyflash.alpha', 0)
    elseif eventName == 'bye gf' then
        doTweenX('haha bye gf', 'gf', -2000, 4, 'quartIn')
    end
end

local legPosY = {13, 7, -3, -1, -1, 2, 7, 9, 7, 2, 0, 0, 3, 1, 3, 7, 13}
local legPosX = {3, 4, 4, 5, 5, 4, 3, 2, 0, 0, -3, -4, -4, -5, -5, -4, -3}
local bfAnchorPoint = {0, 0}
local dadAnchorPoint = {0, 0}

function onCreatePost()
    bfAnchorPoint = {getProperty('boyfriend.x'), getProperty('boyfriend.y')}
    dadAnchorPoint = {getProperty('dad.x'), getProperty('dad.y')}

    makeSprGroup('airshipPlatform')
    makeSprGroup('airFarClouds')
    makeSprGroup('airMidClouds')
    makeSprGroup('airCloseClouds')
    makeSprGroup('airSpeedlines')

    makeLuaSprite('sky', 'airship/sky', -1604, -897.55)
    scaleObject('sky', 1.5, 1.5)
    setScrollFactor('sky', 0, 0)
    add('sky')

    makeLuaSprite('cloudfar0', 'airship/farthestClouds', -1150, -142.2)
    setScrollFactor('cloudfar0', 0.1, 0.1)
    add('airFarClouds', 'cloudfar0')
    makeLuaSprite('cloudfar1', 'airship/farthestClouds', -5678.95, -142.2)
    setScrollFactor('cloudfar1', 0.1, 0.1)
    add('airFarClouds', 'cloudfar1')
    makeLuaSprite('cloudfar2', 'airship/farthestClouds', 3385.95, -142.2)
    setScrollFactor('cloudfar2', 0.1, 0.1)
    add('airFarClouds', 'cloudfar2')
    add('airFarClouds', false)

    makeLuaSprite('cloudmid0', 'airship/backClouds', -1162.4, 76.55)
    setScrollFactor('cloudmid0', 0.2, 0.2)
    add('airMidClouds', 'cloudmid0')
    makeLuaSprite('cloudmid1', 'airship/backClouds', 3352.4, 76.55)
    setScrollFactor('cloudmid1', 0.2, 0.2)
    add('airMidClouds', 'cloudmid1')
    makeLuaSprite('cloudmid2', 'airship/backClouds', -5651.4, 76.55)
    setScrollFactor('cloudmid2', 0.2, 0.2)
    add('airMidClouds', 'cloudmid2')
    add('airMidClouds', false)

    makeLuaSprite('airship', 'airship/airship', 1114.75, -873.05)
    setScrollFactor('airship', 0.25, 0.25)
    add('airship')

    makeAnimatedLuaSprite('fan', 'airship/airshipFan', 2285.4, 102)
    addAnimationByPrefix('fan', 'idle', 'ala avion instance 1', 24, true)
    setScrollFactor('fan', 0.27, 0.27)
    add('fan')
    playAnim('fan', 'idle')

    makeLuaSprite('airBigCloud', 'airship/bigCloud')
    setScrollFactor('airBigCloud', 0.4, 0.4)
    add('airBigCloud')

    makeLuaSprite('cloudclose0', 'airship/frontClouds', -1903.9, 422.15)
    setScrollFactor('cloudclose0', 0.3, 0.3)
    add('airCloseClouds', 'cloudclose0')
    makeLuaSprite('cloudclose1', 'airship/frontClouds', -9900.2, 422.15)
    setScrollFactor('cloudclose1', 0.3, 0.3)
    add('airCloseClouds', 'cloudclose1')
    makeLuaSprite('cloudclose2', 'airship/frontClouds', 6092.2, 422.15)
    setScrollFactor('cloudclose2', 0.3, 0.3)
    add('airCloseClouds', 'cloudclose2')
    add('airCloseClouds', false)

    makeLuaSprite('platform0', 'airship/fgPlatform', -1454.2, 282.25)
    add('airshipPlatform', 'platform0')
    makeLuaSprite('platform1', 'airship/fgPlatform', -7184.8, 282.25)
    add('airshipPlatform', 'platform1')
    add('airshipPlatform', false)

    makeAnimatedLuaSprite('airshipskyflash', 'airship/screamsky', -800, -1600)
    addAnimationByPrefix('airshipskyflash', 'bop', 'scream sky  instance 1')
    scaleObject('airshipskyflash', 3, 3)
    setProperty('airshipskyflash.antialiasing', false)
    setProperty('airshipskyflash.alpha', 0.000001)
    add('airshipskyflash')

    makeAnimatedLuaSprite('blacklegs', 'characters/blacklegs', getProperty('dad.x') - 47, getProperty('dad.y') + 705)
    addAnimationByPrefix('blacklegs', 'idle', 'legs0')
    scaleObject('blacklegs', 1.3, 1.3)
    add('blacklegs')

    makeAnimatedLuaSprite('bfLegs', 'characters/bf_legs', getProperty('boyfriend.x') - 90, getProperty('boyfriend.y') + 205)
    addAnimationByIndices('bfLegs', 'danceLeft', 'run legs0', '1,2,3,4,5,6,7,8,9')
    addAnimationByIndices('bfLegs', 'danceRight', 'run legs0', '11,12,13,14,15,16,17,18,19,20')
    add('bfLegs')

    makeAnimatedLuaSprite('bfLegsmiss', 'characters/bf_legs', getProperty('boyfriend.x') - 90, getProperty('boyfriend.y') + 205)
    addAnimationByIndices('bfLegsmiss', 'danceLeft', 'miss run legs0', '1,2,3,4,5,6,7,8,9')
    addAnimationByIndices('bfLegsmiss', 'danceRight', 'miss run legs0', '11,12,13,14,15,16,17,18,19,20')
    setProperty('bfLegsmiss.visible', false)
    add('bfLegsmiss')

    makeLuaSprite('speedline0', 'airship/speedlines', -912.75, -1035.95)
    setScrollFactor('speedline0', 1.3, 1.3)
    setProperty('speedline0.alpha', 0.2)
    add('airSpeedlines', 'speedline0')
    makeLuaSprite('speedline1', 'airship/speedlines', -3352.1, -1035.95)
    setScrollFactor('speedline1', 1.3, 1.3)
    setProperty('speedline1.alpha', 0.2)
    add('airSpeedlines', 'speedline1')
    makeLuaSprite('speedline2', 'airship/speedlines', 5140.05, -1035.95)
    setScrollFactor('speedline2', 1.3, 1.3)
    setProperty('speedline2.alpha', 0.2)
    add('airSpeedlines', 'speedline2')
    add('airSpeedlines', true)

    setProperty('camGame.height', screenHeight + 200)
end

function onBeatHit()
    danceBF()
end

function danceBF()
    bfDanced = -bfDanced
    playAnim('bfLegs', danceCycle[bfDanced+1.5], true)
    playAnim('bfLegsmiss', danceCycle[bfDanced+1.5], true)
    setProperty('boyfriend.danced', bfDanced == -0.5)
    if stringStartsWith(getProperty('boyfriend.animation.curAnim.name'), 'dance') then
        characterDance('boyfriend') -- what the fuck??
    end
end

function lerp(from,to,i)
	return from+(to-from)*i
end

function boundTo(value, min, max)
	return math.max(min, math.min(max, value))
end

function wrap(value, min, max)
    return (((value - min) % (max - min)) + (max - min)) % (max - min) + min
end

local bigCloudSpeed = 10 -- wtf?
function onUpdatePost(elapsed)
    for _, spr in ipairs(airCloseClouds.members) do
        local sprX = getProperty(spr..'.x')
        setProperty(spr..'.x', wrap(lerp(sprX, sprX - 50, boundTo(elapsed * 9, 0, 1)), -10400.2, 5582.2))
    end
    for _, spr in ipairs(airMidClouds.members) do
        local sprX = getProperty(spr..'.x')
        setProperty(spr..'.x', wrap(lerp(sprX, sprX - 13, boundTo(elapsed * 9, 0, 1)), -6153.4, 2852.4))
    end
    for _, spr in ipairs(airSpeedlines.members) do
        local sprX = getProperty(spr..'.x')
        setProperty(spr..'.x', wrap(lerp(sprX, sprX - 350, boundTo(elapsed * 9, 0, 1)), -5140.05, 3352.1))
    end
    for _, spr in ipairs(airFarClouds.members) do
        local sprX = getProperty(spr..'.x')
        setProperty(spr..'.x', wrap(lerp(sprX, sprX - 7, boundTo(elapsed * 9, 0, 1)), -6178.95, 2874.95))
    end
    for _, spr in ipairs(airshipPlatform.members) do
        local sprX = getProperty(spr..'.x')
        setProperty(spr..'.x', wrap(lerp(sprX, sprX - 300, boundTo(elapsed * 9, 0, 1)), -7184.8, 4275.15))
        -- debugPrint(getProperty(spr..'.x'), ' ', getObjectOrder(spr))
        if getProperty(spr..'.x') > sprX then
            setObjectOrder(spr, getObjectOrder(spr) + 1) -- floor layering fix !!
        end
    end
    local sprX = getProperty('airBigCloud.x')
    setProperty('airBigCloud.x', lerp(sprX, sprX - bigCloudSpeed, boundTo(elapsed * 9, 0, 1)))
    if getProperty('airBigCloud.x') < -4163.7 then
        setProperty('airBigCloud.x', getRandomFloat(3931.5, 4824.05))
        setProperty('airBigCloud.y', getRandomFloat(-1087.5, -307.35))
        bigCloudSpeed = getRandomFloat(7, 15)
    end

    setObjectOrder('bfLegs', getObjectOrder('boyfriendGroup') - 0.1)
    setObjectOrder('bfLegsmiss', getObjectOrder('boyfriendGroup') - 0.1)
    setObjectOrder('blacklegs', getObjectOrder('dadGroup') - 0.1)
end

local dadOffset = {-30, 620} -- i hate how weird the offsets are,,,
function onUpdate(elapsed)
    if stringEndsWith(getProperty('boyfriend.animation.curAnim.name'), 'miss') and getProperty('boyfriend.animation.curAnim.curFrame') > 1 then
        if not bfSuffix then
            bfSuffix = true
            setProperty('bfLegs.visible', false)
            setProperty('bfLegsmiss.visible', true)
        end
    else
        if bfSuffix then
            bfSuffix = false
            setProperty('bfLegs.visible', true)
            setProperty('bfLegsmiss.visible', false)
        end
    end

    if bfSuffix and getProperty('boyfriend.offset.x') == 0 then
        characterDance('boyfriend') -- what the fuck??
    end
    if dadName ~= 'black-run' then
        dadOffset = {90, 210}
    end

    setProperty('boyfriend.y', bfAnchorPoint[2] + legPosY[getProperty('bfLegs.animation.curAnim.curFrame')])
    setProperty('dad.x', dadAnchorPoint[1] --[[+ legPosX[getProperty('blacklegs.animation.curAnim.curFrame')]] + dadOffset[1])
    setProperty('dad.y', dadAnchorPoint[2] + legPosY[getProperty('blacklegs.animation.curAnim.curFrame')] + dadOffset[2])

    cameraShake('game', 0.0008, 0.01)
    setProperty('camGame.y', math.sin((getSongPosition() / 280))*(curBpm/60)*2-75)
    setProperty('camHUD.y', math.sin((getSongPosition() / 300))*(curBpm/60)*0.6)
    setProperty('camHUD.angle', math.sin((getSongPosition() / 350))*(curBpm/60)*-0.6)

    -- for i, tag in ipairs(sprGroups) do
    --     curGroup = _G[tag]
    --     if curGroup == null then
    --         sprGroups[i] = nil
    --         goto continue
    --     end
    --     for _, spr in ipairs(curGroup.members) do
    --         setProperty(spr..'.x', getProperty(spr..'.x') - curGroup.oldx + curGroup.x)
    --         setProperty(spr..'.y', getProperty(spr..'.y') - curGroup.oldy + curGroup.y)
    --     end
    --     _G[tag].oldx = curGroup.x
    --     _G[tag].oldy = curGroup.y
    --     ::continue::
    -- end

	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
           
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

function onStepHit()
    if songName == 'Danger' then
        if curStep == 1 then
            setProperty('defaultCamZoom',0.3)
            followchars = true
            xx = 1634.05
            yy = -54.3
            xx2 = 1634.05
            yy2 = -54.3
        end
        if curBeat == 64 then
            setProperty('defaultCamZoom', 0.4)
            followchars = true
            xx = 800
            yy = 150
            xx2 = 1200
            yy2 = 150
        end
        if curBeat == 96 then
            setProperty('defaultCamZoom', 0.6)
            followchars = true
            xx = 700
            yy = 150
            xx2 = 1200
            yy2 = 150
        end
        if curBeat == 128 then
            setProperty('defaultCamZoom', 0.4)
            xx = 800
            yy = 150
            xx2 = 1200
            yy2 = 150
        end
        if curBeat == 155 then
            setProperty('defaultCamZoom', 0.8)
            followchars = true
            xx = 450
            yy = 150
            xx2 = 450
            yy2 = 150
        end
        if curBeat == 160 then
            setProperty('defaultCamZoom', 0.4)
            followchars = true
            xx = 800
            yy = 150
            xx2 = 1200
            yy2 = 150
        end
        if curBeat == 192 then
            setProperty('defaultCamZoom',0.6)
            followchars = true
            xx = 700
            yy = 150
            xx2 = 1200
            yy2 = 150
        end
        if curBeat == 256 then
            setProperty('defaultCamZoom', 0.4)
            followchars = true
            xx = 800
            yy = 150
            xx2 = 1200
            yy2 = 150
        end
        if curBeat == 288 then
            setProperty('defaultCamZoom',0.6)
            followchars = true
            xx = 700
            yy = 150
            xx2 = 1200
            yy2 = 150
        end
        if curBeat == 320 then
            setProperty('defaultCamZoom', 0.3)
            followchars = true
            xx = 1634.05
            yy = -54.3
            xx2 = 1634.05
            yy2 = -54.3
        end
        if curBeat == 384 then
            setProperty('defaultCamZoom',0.6)
            followchars = true
            xx = 700
            yy = 150
            xx2 = 1200
            yy2 = 150
        end
    end 
end