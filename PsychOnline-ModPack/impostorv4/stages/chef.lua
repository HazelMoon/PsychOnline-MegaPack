function onCreatePost()
    makeLuaSprite('backWall', 'chef/Back Wall Kitchen', 480, 120)
    makeLuaSprite('floor', 'chef/Chef Floor', -500, 1000)
    makeLuaSprite('backTable', 'chef/Back Table Kitchen', 150, 270)
    makeLuaSprite('oven', 'chef/oven', 1700, 480)
    makeAnimatedLuaSprite('grey', 'chef/Boppers', 1050, 580)
    makeAnimatedLuaSprite('saster', 'chef/Boppers', 1350, 580)
    makeLuaSprite('shadow', 'chef/black_overhead_shadow', -350, -300)
    makeLuaSprite('counter', 'chef/Kitchen Counter', 900, 720)
    makeLuaSprite('light', 'chef/bluelight', 100, 100)

    scaleObject('backWall', 0.8, 0.8)
    scaleObject('backTable', 0.8, 0.8)
    scaleObject('oven', 0.8, 0.8)
    scaleObject('grey', 0.8, 0.8)
    scaleObject('saster', 0.8, 0.8)
    scaleObject('counter', 0.94, 0.94)
    scaleObject('light', 0.8, 0.8)

    setProperty('light.alpha', 0.6)

    addAnimationByPrefix('grey', 'idle', 'grey', 24, false)
    addAnimationByPrefix('saster', 'idle', 'saster', 24, false)

    addLuaSprite('backWall')
    addLuaSprite('floor')
    addLuaSprite('backTable')
    addLuaSprite('oven')
    addLuaSprite('grey')
    addLuaSprite('saster')
    addLuaSprite('shadow')
    addLuaSprite('counter')
    addLuaSprite('light', true)

    setProperty('gf.visible', false)
end

function onBeatHit()
    if curBeat % 2 == 0 then
        playAnim('grey', 'idle', true, false, 0)
        playAnim('saster', 'idle', true, false, 0)
    end
end

local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 1200;
local yy = 800;
local xx2 = 1400;
local yy2 = 800;
local ofs = 10;
local followchars = true;
local del = 0;
local del2 = 0;
function onUpdate()
	setProperty('gf.alpha', 0);
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

	if curStep >= 171 and curStep < 176 then
		setProperty('defaultCamZoom',1)
	end

    if curBeat == 44 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 112 then
		setProperty('defaultCamZoom',0.9)
		xx = 1180;
		yy = 820;
	end

	if curBeat == 113 then
		setProperty('defaultCamZoom',1)
		xx = 1160;
		yy = 840;
	end

	if curBeat == 114 then
		setProperty('defaultCamZoom',1.1)
		xx = 1140;
		yy = 860;
	end

	if curBeat == 115 then
		setProperty('defaultCamZoom',1.2)
		xx = 1120;
		yy = 880;
	end

	if curBeat == 116 then
		setProperty('defaultCamZoom',0.8)
		xx = 1200;
		yy = 800;
	end

	if curStep == 206 or curStep == 207 then
		setProperty('defaultCamZoom',1)
	end

	if curStep >= 399 and curStep < 404 then
		setProperty('defaultCamZoom',1)
	end

	if curStep == 404 then
		setProperty('defaultCamZoom',0.8)
	end

	if curStep == 1172 then
		setProperty('defaultCamZoom', 0.8)
	end

	if curStep >= 1164 and curStep < 1172 then
		setProperty('defaultCamZoom',1)
	end

	if curStep == 1172 then
		setProperty('defaultCamZoom',0.8)
	end

	if curBeat == 304 then
		setProperty('defaultCamZoom',0.9)
		xx = 1180;
		yy = 820;
	end

	if curBeat == 305 then
		setProperty('defaultCamZoom',1)
		xx = 1160;
		yy = 840;
	end

	if curBeat == 306 then
		setProperty('defaultCamZoom',1.1)
		xx = 1140;
		yy = 860;
	end

	if curBeat == 307 then
		setProperty('defaultCamZoom',1.2)
		xx = 1120;
		yy = 880;
	end

	if curBeat == 308 then
		setProperty('defaultCamZoom',0.8)
		xx = 1200;
		yy = 800;
	end

	if curBeat == 320 then
		setProperty('defaultCamZoom',0.9)
		xx = 1180;
		yy = 820;
	end

	if curBeat == 321 then
		setProperty('defaultCamZoom',1)
		xx = 1160;
		yy = 840;
	end

	if curBeat == 322 then
		setProperty('defaultCamZoom',1.1)
		xx = 1140;
		yy = 860;
	end

	if curBeat == 323 then
		setProperty('defaultCamZoom',1.2)
		xx = 1120;
		yy = 880;
	end

	if curBeat >= 324 then
		setProperty('defaultCamZoom',0.7)
		followchars = false
		triggerEvent('Camera Follow Pos', 1300, 700)
	end
    
end