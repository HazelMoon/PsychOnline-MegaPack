function onCreate()
	makeLuaSprite('bgskypink', 'airship/fartingSky', -1468, -995)
	setScrollFactor('bgskypink', 0.3, 0.3)
	addLuaSprite('bgskypink', false)
    setProperty('bgskypink.active', false)

	makeLuaSprite('cloud5', 'airship/backSkyyellow', -1125, 284)
	setScrollFactor('cloud5', 0.4, 0.7)
	addLuaSprite('cloud5', false)
    setProperty('cloud5.active', false)

	makeLuaSprite('cloud6', 'airship/yellow cloud 3', 1330, 283)
	setScrollFactor('cloud6', 0.5, 0.8)
	addLuaSprite('cloud6', false)
    setProperty('cloud6.active', false)

	makeLuaSprite('cloud7', 'airship/yellow could 2', -837, 304)
	setScrollFactor('cloud7', 0.6, 0.9)
	addLuaSprite('cloud7', false)
    setProperty('cloud7.active', false)

	makeLuaSprite('glasses', 'airship/window', -1387, -1231)
	addLuaSprite('glasses', false)
    setProperty('glasses.active', false)

	makeLuaSprite('cloud4', 'airship/cloudYellow 1', -1541, 242)
	setScrollFactor('cloud4', 0.8, 0.8)
	addLuaSprite('cloud4', false)
    setProperty('cloud4.active', false)

	makeLuaSprite('lmao2', 'airship/backDlowFloor', -642, 325)
	addLuaSprite('lmao2', false)
    setProperty('lmao2.active', false)

	makeLuaSprite('lmao', 'airship/DlowFloor', -2440, 336)
	addLuaSprite('lmao', false)
    setProperty('lmao.active', false)

	makeLuaSprite('glow', 'airship/glowYellow', -1113, -1009)
	setBlendMode('glow', 'add')
	addLuaSprite('glow', false)
    setProperty('glow.active', false)
end

local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 300;
local yy = 500;
local xx2 = 700;
local yy2 = 500;
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
            setProperty('defaultCamZoom',0.6)
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