local cloud1x = 0
local cloud2x = 0
local cloud3x = 0
local cloud4x = 0
local width1 = 0
local width2 = 0
local width3 = 0
local width4 = 0

function onCreate()
	makeLuaSprite('bg skypink', 'mira/bg sky', -1500, -800)
	addLuaSprite('bg skypink', false)

	makeLuaSprite('bg1', 'mira/cloud fathest', -1300, -100)
	addLuaSprite('bg1', false)

	makeLuaSprite('bg2', 'mira/cloud front', -1300, 0)
	addLuaSprite('bg2', false)

	makeLuaSprite('cloudbig', 'mira/bigcloud', 0, -1200)
	addLuaSprite('cloudbig', false)
	scaleObject('cloudbig', 0.9, 0.9)

	makeLuaSprite('cloud1', 'mira/cloud 1', 0, -1000)
	addLuaSprite('cloud1', false)

	makeLuaSprite('cloud1b', 'mira/cloud 1', 0, -1000)
	addLuaSprite('cloud1b', false)

	makeLuaSprite('cloud2', 'mira/cloud 2', 0, -1200)
	addLuaSprite('cloud2', false)

	makeLuaSprite('cloud2b', 'mira/cloud 2', 0, -1200)
	addLuaSprite('cloud2b', false)

	makeLuaSprite('cloud3', 'mira/cloud 3', 0, -1400)
	addLuaSprite('cloud3', false)

	makeLuaSprite('cloud3b', 'mira/cloud 3', 0, -1400)
	addLuaSprite('cloud3b', false)

	makeLuaSprite('cloud4', 'mira/cloud 4', 0, -1600)
	addLuaSprite('cloud4', false)

	makeLuaSprite('cloud4b', 'mira/cloud 4', 0, -1600)
	addLuaSprite('cloud4b', false)

	makeLuaSprite('glasses', 'mira/glasses', -1200, -750)
	addLuaSprite('glasses', false)

	makeLuaSprite('what is this', 'mira/what is this', 0, -650)
	addLuaSprite('what is this', false)

	makeLuaSprite('lmao', 'mira/lmao', -800, -10)
	addLuaSprite('lmao', false)
	scaleObject('lmao', 0.9, 0.9)

	makeLuaSprite('pot', 'mira/front pot', -1550, 650)
	setScrollFactor('pot', 1.2, 1)
	addLuaSprite('pot', true);

	-- {'green', -970, -700, 'vines', 52, 1},
	makeAnimatedLuaSprite('vines', 'mira/vines', -1200, -1200)
	addAnimationByPrefix('vines', 'sway', 'green', 24, true)
    setScrollFactor('vines', 1.4, 1)
	playAnim('vines', 'sway')
	addLuaSprite('vines', true);

	addLuaScript('scripts/bgchars/bgchars')
	setGlobalFromScript('scripts/bgchars/bgchars', 'path', 'mira/')
	setGlobalFromScript('scripts/bgchars/bgchars', 'bgchars', {
		['2'] = {
			{'grey', -260, -75, 'crew', 14, 1},
			{'tomatomongus', 740, -50, 'crew', 18, 1},
			{'RHM', 1000, 125, 'crew', 19, 1, {1.2, 1}}
		},
		['1'] = {
			{'blue', -1300, 0, 'crew', 26, 1, {1.2, 1}}
		}
	})

	width1 = getProperty('cloud1.width')
	width2 = getProperty('cloud2.width')
	width3 = getProperty('cloud3.width')
	width4 = getProperty('cloud4.width')
end

-- cloud backdrops!!
local lerpDur = 0
function onUpdatePost(elapsed)
	lerpDur = boundTo(elapsed * 9, 0, 1)
	cloud1x = screenWrap(lerp(cloud1x, cloud1x - 1, lerpDur), width1)
	cloud2x = screenWrap(lerp(cloud2x, cloud2x - 3, lerpDur), width2)
	cloud3x = screenWrap(lerp(cloud3x, cloud3x - 2, lerpDur), width3)
	cloud4x = screenWrap(lerp(cloud4x, cloud4x - 0.3, lerpDur), width4)
	setProperty('cloud1.x', cloud1x)
	setProperty('cloud2.x', cloud2x)
	setProperty('cloud3.x', cloud3x)
	setProperty('cloud4.x', cloud4x)
	setProperty('cloud1b.x', cloud1x - width1)
	setProperty('cloud2b.x', cloud2x - width2)
	setProperty('cloud3b.x', cloud3x - width3)
	setProperty('cloud4b.x', cloud4x - width4)
end

function lerp(from,to,i)
	return from+(to-from)*i
end

function boundTo(value, min, max)
	return math.max(min, math.min(max, value))
end

function screenWrap(v, width)
	local min = width * -0.5
	local max = width + min
	if v > max then
		v = v - max
	elseif v < min then
		v = max - v
	end
	return v
end

local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx =  100;
local yy =  200;
local xx2 = 380;
local yy2 = 200;
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
    if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.5)
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

            setProperty('defaultCamZoom',0.5)
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

function onEndSong()
    followchars = false;
    triggerEvent('Camera Follow Pos','400','150')
end