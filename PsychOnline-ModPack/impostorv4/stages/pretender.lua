local cloud1x = 0
local cloud2x = 0
local cloud3x = 0
local cloud4x = 0
local width1 = 0
local width2 = 0
local width3 = 0
local width4 = 0
function onCreatePost()
	setProperty('gf.visible', false)

	makeLuaSprite('bg sky', 'mira/pretender/bg sky', -1500, -800);
	addLuaSprite('bg sky', false);

	makeLuaSprite('bg1', 'mira/pretender/cloud fathest', -1300, -100);
	addLuaSprite('bg1', false);
	scaleObject('bg1', 1, 1)

	makeLuaSprite('bg2', 'mira/pretender/cloud front', -1300, 0);
	addLuaSprite('bg2', false);
	scaleObject('bg2', 1, 1)

	makeLuaSprite('cloud1', 'mira/pretender/cloud 1', 0, -1000)
	addLuaSprite('cloud1', false)

	makeLuaSprite('cloud1b', 'mira/pretender/cloud 1', 0, -1000)
	addLuaSprite('cloud1b', false)

	makeLuaSprite('cloud2', 'mira/pretender/cloud 2', 0, -1200)
	addLuaSprite('cloud2', false)

	makeLuaSprite('cloud2b', 'mira/pretender/cloud 2', 0, -1200)
	addLuaSprite('cloud2b', false)

	makeLuaSprite('cloud3', 'mira/pretender/cloud 3', 0, -1400)
	addLuaSprite('cloud3', false)

	makeLuaSprite('cloud3b', 'mira/pretender/cloud 3', 0, -1400)
	addLuaSprite('cloud3b', false)

	makeLuaSprite('cloud4', 'mira/pretender/cloud 4', 0, -1600)
	addLuaSprite('cloud4', false)

	makeLuaSprite('cloud4b', 'mira/pretender/cloud 4', 0, -1600)
	addLuaSprite('cloud4b', false)

	makeLuaSprite('cloudbig', 'mira/pretender/bigcloud', 0, -1200)
	addLuaSprite('cloudbig', false)
	scaleObject('cloudbig', 0.9, 0.9)

	makeLuaSprite('glasses', 'mira/pretender/ground', -1200, -750);
	addLuaSprite('glasses', false);

	makeLuaSprite('what is this', 'mira/pretender/front plant', 0, -650);
	addLuaSprite('what is this', false);

	makeLuaSprite('real3', 'mira/pretender/knocked over plant', 1000, 230);
	addLuaSprite('real3', false);

	makeLuaSprite('lmao', 'mira/pretender/knocked over plant 2', -800, 260);
	addLuaSprite('lmao', false);

	makeLuaSprite('real4', 'mira/pretender/tomatodead', 950, 250);
	addLuaSprite('real4', false);

	makeLuaSprite('real5', 'mira/pretender/ripbozo', 700, 450);
	addLuaSprite('real5', false);
	scaleObject('real5', 0.7, 0.7)

	makeLuaSprite('real6', 'mira/pretender/rhm dead', 1350, 450);
	addLuaSprite('real6', false);

	makeLuaSprite('pot', 'mira/pretender/front pot', -1550, 650);
    setScrollFactor('pot', 1.2, 1)
	addLuaSprite('pot', true);

	makeLuaSprite('vines', 'mira/pretender/green', -1450, -550);
    setScrollFactor('vines', 1.2, 1)
	addLuaSprite('vines', true);

	doTweenX('cloudTween1',   'cloud1',   getProperty('cloud1.x') - 2700,   300, 'linear')
	doTweenX('cloudTween2',   'cloud2',   getProperty('cloud2.x') - 8100,   300, 'linear')
	doTweenX('cloudTween3',   'cloud3',   getProperty('cloud3.x') - 5400,   300, 'linear')
	doTweenX('cloudTween4',   'cloud4',   getProperty('cloud4.x') - 270,    300, 'linear')
	doTweenX('cloudTweenbig', 'cloudbig', getProperty('cloudbig.x') - 1350, 300, 'linear')

	addLuaScript('scripts/bgchars/bgchars')
	setGlobalFromScript('scripts/bgchars/bgchars', 'path', 'mira/pretender/')
	setGlobalFromScript('scripts/bgchars/bgchars', 'bgchars', {
		['2'] = {
			{'bob bop', -1150, 400, 'blued', 18, 1, {1.2, 1}}
		},
		['1'] = {
			{'GF Dancing Beat', 0, 100, 'gf_dead_p', 16, 1.1}
		}
	})

	makeLuaSprite('real2', 'mira/pretender/lightingpretender', -1670, -700);
	addLuaSprite('real2', true);

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
    setProperty('gf.alpha', 0)
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