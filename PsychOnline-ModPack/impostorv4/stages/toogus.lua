function onCreatePost()
    makeLuaSprite('bg', 'mira/mirabg', -1600, 50)
    scaleObject('bg', 1.06, 1.06)
    addLuaSprite('bg')

    if string.lower(songName) == 'lights-down' then
        makeAnimatedLuaSprite('bfvent', 'mira/bf_mira_vent', 70, 200)
        addAnimationByPrefix('bfvent', 'vent', 'bf vent')
        setProperty('bfvent.alpha', 0)
        addLuaSprite('bfvent')
    end

    makeLuaSprite('fg', 'mira/mirafg', -1600, 50)
    scaleObject('fg', 1.06, 1.06)
    addLuaSprite('fg')

    makeLuaSprite('tbl', 'mira/table_bg', -1600, 50)
    scaleObject('tbl', 1.06, 1.06)
    addLuaSprite('tbl')

    if string.lower(songName) == 'lights-down' then
        makeAnimatedLuaSprite('ldSpeaker', 'mira/stereo_taken', 400, 420)
        addAnimationByPrefix('ldSpeaker', 'boom', 'stereo boom')
        setProperty('ldSpeaker.alpha', 0)
        addLuaSprite('ldSpeaker')
    end
end

local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx =  500;
local yy =  475;
local xx2 = 900;
local yy2 = 475;
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
            setProperty('defaultCamZoom',0.9)
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

            setProperty('defaultCamZoom',0.9)
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

-- function onUpdate(elapsed)
--     setProperty('defaultCamZoom', 0.3)
-- end