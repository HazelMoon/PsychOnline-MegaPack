
function onCreate()
    makeAnimatedLuaSprite('bg', 'defeat/defeat', -545, -175);
    addAnimationByPrefix('bg', 'bop', 'defeat', 24, false)
    addAnimationByPrefix('bg', 'freeze', 'defeat', 0, false)
    scaleObject('bg', 1.25, 1.25)
    setProperty('bg.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    addLuaSprite('bg', false);
    playAnim('bg', 'bop')

    makeLuaSprite('iluminao omaga', 'defeat/iluminao omaga', -545, 125);
    setProperty('iluminao omaga.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    addLuaSprite('iluminao omaga', true);
    -- scaleObject('iluminao omaga', 1.2, 1.2)
    setBlendMode('iluminao omaga', 'add')

    makeLuaSprite('lol thing', 'defeat/lol thing', -1015, 15);
    scaleObject('lol thing', 1.47, 1.47)
    setScrollFactor('lol thing', 0.7, 0.7)
    setProperty('lol thing.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))

    makeLuaSprite('deadBG', 'defeat/deadBG', -800, 425);
    scaleObject('deadBG', 0.454, 0.454)
    setScrollFactor('deadBG', 0.7, 0.7)
    setProperty('deadBG.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))

    makeLuaSprite('deadFG', 'defeat/deadFG', -715, 695);
    scaleObject('deadFG', 0.445, 0.445)
    setScrollFactor('deadFG', 1.45, 0.65)
    setProperty('deadFG.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))

    setProperty('lol thing.alpha', 0)
    setProperty('deadBG.alpha', 0)
    setProperty('deadFG.alpha', 0)

    addLuaSprite('lol thing', false);
    addLuaSprite('deadBG', false);
    addLuaSprite('deadFG', true);
end

function onCreatePost()
	setProperty('gf.alpha', 0);
end

local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0
local xx = 750;
local yy = 500;
local xx2 = 750;
local yy2 = 500;
local ofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;

local yoff = 150 -- oops

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
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy + yoff)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy + yoff)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy + yoff-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy + yoff+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy + yoff)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy + yoff)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy + yoff-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy + yoff+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy + yoff)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy + yoff)
            end
        else
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2 + yoff)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2 + yoff)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2 + yoff-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2 + yoff+ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2 + yoff)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2 + yoff)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
end

function onBeatHit()
    if curBeat % 4 == 0 and getProperty('iluminao omaga.alpha') > 0 then
        playAnim('bg', 'bop', true)
    end
    if curBeat == 16 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 750
        yy = 500
        xx2 = 750
        yy2 = 500
    elseif curBeat == 32 then
        setProperty('defaultCamZoom',0.7)
		followchars = true
        xx = 750
        yy = 500
        xx2 = 750
        yy2 = 500
    elseif curBeat == 48 then
        setProperty('defaultCamZoom',0.8)
		followchars = true
        xx = 750
        yy = 500
        xx2 = 750
        yy2 = 500
    elseif curBeat == 68 then
        setProperty('defaultCamZoom',0.5)
		followchars = true
        xx = 750
        yy = 500
        xx2 = 750
        yy2 = 500
    elseif curBeat == 100 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 500
        yy = 500
        xx2 = 900
        yy2 = 500
    elseif curBeat == 164 then
        setProperty('defaultCamZoom',0.5)
		followchars = true
        xx = 750
        yy = 500
        xx2 = 750
        yy2 = 500
    elseif curBeat == 194 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 750
        yy = 500
        xx2 = 750
        yy2 = 500
    elseif curBeat == 196 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 750
        yy = 500
        xx2 = 750
        yy2 = 500
    elseif curBeat == 212 then
        setProperty('defaultCamZoom',0.7)
		followchars = true
        xx = 750
        yy = 500
        xx2 = 750
        yy2 = 500
    elseif curBeat == 228 then
        setProperty('defaultCamZoom',0.8)
		followchars = true
        xx = 750
        yy = 500
        xx2 = 750
        yy2 = 500
    elseif curBeat == 244 then
        setProperty('defaultCamZoom',0.85)
		followchars = true
        xx = 750
        yy = 500
        xx2 = 750
        yy2 = 500
    elseif curBeat == 260 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 750
        yy = 500
        xx2 = 750
        yy2 = 500
    elseif curBeat == 292 then
        setProperty('defaultCamZoom',0.75)
		followchars = true
        xx = 750
        yy = 500
        xx2 = 750
        yy2 = 500
    elseif curBeat == 360 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 500
        yy = 500
        xx2 = 900
        yy2 = 500
    elseif curBeat == 424 then
        setProperty('defaultCamZoom',0.7)
		followchars = true
        xx = 750
        yy = 500
        xx2 = 750
        yy2 = 500
    elseif curBeat == 456 then
        setProperty('defaultCamZoom',0.8)
		followchars = true
        xx = 750
        yy = 500
        xx2 = 750
        yy2 = 500
    elseif curBeat == 472 then
        setProperty('defaultCamZoom',0.9)
		followchars = true
        xx = 750
        yy = 500
        xx2 = 750
        yy2 = 500
    elseif curBeat == 488 then
        setProperty('defaultCamZoom',50)
		followchars = true
        xx = 750
        yy = 500
        xx2 = 750
        yy2 = 500
    end
end