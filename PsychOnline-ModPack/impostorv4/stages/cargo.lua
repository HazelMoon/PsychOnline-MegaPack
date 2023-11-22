
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 2000;
local yy = 1050;
local xx2 = 2300;
local yy2 = 1050;
local ofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;
local showDlowDK = false;
local cargoDarken = false;
local cargoReadyKill = false;

function onCreate()
    setProperty('camZooming', true)

    luaDebugMode = true

    addHaxeLibrary('FlxTween', 'flixel.tweens')
    addHaxeLibrary('FlxEase', 'flixel.tweens')

    makeLuaSprite('bg', 'airship/cargo', 0, 0)
    setProperty('bg.active', false)
    addLuaSprite('bg')

    makeLuaSprite('cargoDark', nil, -1000, -1000)
    makeGraphic('cargoDark', screenWidth*3, screenHeight*3, '000000')
    setProperty('cargoDark.alpha', 0.001)
    setScrollFactor('cargoDark', 0, 0)
    addLuaSprite('cargoDark')
    setObjectOrder('cargoDark', getObjectOrder('boyfriendGroup')-0.2)

    makeLuaSprite('cargoAirsip', 'airship/airshipFlashback', 2100, 800) -- i sip the air in the car go
    scaleObject('cargoAirsip', 1.3, 1.3)
    setProperty('cargoAirsip.alpha', 0.001)
    addLuaSprite('cargoAirsip')
    setObjectOrder('cargoAirsip', getObjectOrder('boyfriendGroup')-0.1)

    makeLuaSprite('lightoverlayDK', 'airship/scavd', 0, 0)
    setProperty('lightoverlayDK.alpha', 0.51)
    setProperty('lightoverlayDK.active', false)
    setBlendMode('lightoverlayDK', 'add')
    addLuaSprite('lightoverlayDK', true)

    makeLuaSprite('mainoverlayDK', 'airship/overlay ass dk', -100, 0)
    setProperty('mainoverlayDK.alpha', 0.6)
    setProperty('mainoverlayDK.active', false)
    setBlendMode('mainoverlayDK', 'add')
    addLuaSprite('mainoverlayDK', true)

    makeLuaSprite('defeatDKoverlay', 'defeat/iluminao omaga', 900, 350)
    setProperty('defeatDKoverlay.alpha', 0.001)
    setProperty('defeatDKoverlay.active', false)
    setBlendMode('defeatDKoverlay', 'add')
    addLuaSprite('defeatDKoverlay', true)

    makeLuaSprite('cargoDarkFG', nil, -1000, -1000)
    makeGraphic('cargoDarkFG', screenWidth*3, screenHeight*3, '000000')
    setScrollFactor('cargoDarkFG', 0, 0)
    addLuaSprite('cargoDarkFG', true)

    setProperty('camHUD.visible', false)

    callScript('scripts/momChar', 'newChar', {
        nil,
        'blackdk',
        30,
        -30,
        nil,
        nil
    })
end

function lerp(from,to,i)
	return from+(to-from)*i
end

function boundTo(value, min, max)
	return math.max(min, math.min(max, value))
end

function onUpdate(elapsed)
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
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' or getProperty('mom.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' or getProperty('mom.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' or getProperty('mom.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' or getProperty('mom.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' or getProperty('mom.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' or getProperty('mom.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' or getProperty('mom.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' or getProperty('mom.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
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
    
    if curBeat >= 356 and curBeat < 420 then
		setProperty('defaultCamZoom',1.1)
        xx2 = 2750;
        yy2 = 1150;  
	end
    if curBeat == 420 then
		setProperty('defaultCamZoom',0.8)
        xx2 = 2300;
        yy2 = 1050;  
	end
    if curBeat >= 552 and curBeat < 556 then
		setProperty('defaultCamZoom',1.2)
        xx = 1650;
        yy = 1180;  
	end
    if curBeat == 556 then
        xx = 2000;
        yy = 1050;  
	end
    if curBeat == 916 then
        runHaxeCode([[
            FlxTween.num(getVar('curZoom'), 0.4, 20,{ease: FlxEase.linear, onUpdate: function(num) {
                setVar('curZoom', num.value);
            }});
        ]])
    end
    if showDlowDK then
        setProperty('cargoAirsip.alpha', lerp(getProperty('cargoAirsip.alpha'), 0.45, boundTo(elapsed * 0.1, 0, 1)))
    end
    if getSongPosition() >= 0 and getSongPosition() < 1200 then
        setProperty('cargoDarkFG.alpha', getProperty('cargoDarkFG.alpha')-(0.005))
        setProperty('curZoom', lerp(getProperty('curZoom'), 1, boundTo(elapsed * 3, 0, 1)))
    end
    if cargoReadyKill then
        setProperty('cargoDarkFG.alpha', getProperty('cargoDarkFG.alpha')+(0.015))
        setProperty('curZoom', lerp(getProperty('curZoom'), 1, boundTo(elapsed * 3, 0, 1)))
    end
    if cargoDarken then
        setProperty('cargoDark.alpha', lerp(getProperty('cargoDark.alpha'), 1, boundTo(elapsed * 1.4, 0, 1)))
        setProperty('dad.alpha', lerp(getProperty('dad.alpha'), 0.001, boundTo(elapsed * 1.4, 0, 1)))
        setProperty('mainoverlayDK.alpha', lerp(getProperty('mainoverlayDK.alpha'), 0.001, boundTo(elapsed * 1.4, 0, 1)))
        setProperty('lightoverlayDK.alpha', lerp(getProperty('lightoverlayDK.alpha'), 0.001, boundTo(elapsed * 1.4, 0, 1)))
    end
end

function onEvent(eventName, value1, value2)
    if eventName == 'Double Kill Events' then
        local v1 = string.lower(value1)
        debugPrint(v1)
        if v1 == 'darken' then
            cargoDarken = true
            cameraFlash('game', '000000', 0.55, true)
        elseif v1 == 'airship' then
            showDlowDK = true
        elseif v1 == 'brighten' then
            cargoDarken = false
            showDlowDK = false
            setProperty('cargoAirsip.alpha', 0.001)
            setProperty('cargoDark.alpha', 0.001)
            setProperty('dad.alpha', 1)
            setProperty('mom.alpha', 1)
            setProperty('lightoverlayDK.alpha', 0.51)
            setProperty('mainoverlayDK.alpha', 0.6)
        elseif v1 == 'gonnakill' then
            cargoReadyKill = true
        elseif v1 == 'readykill' then
            setObjectOrder('cargoDark', getObjectOrder('dadGroup')-0.1)
            triggerEvent('Change Character', '0', 'bf-defeat-normal')
            setProperty('defeatDKoverlay.alpha', 1)
            setProperty('lightoverlayDK.alpha', 0)
            setProperty('mainoverlayDK.alpha', 0)
            setProperty('cargoDarkFG.alpha', 0)
            setProperty('cargoDark.alpha', 1)
            cargoReadyKill = false
            setProperty('dad.alpha', 0)
            setProperty('newTimeBarBG.alpha', 0)
            setProperty('newTimeBar.alpha', 0)
            setProperty('newTimeBarFG.alpha', 0)
            setProperty('newTimeTxt.alpha', 0)
            setProperty('iconP1.alpha', 0)
            setProperty('iconP2.alpha', 0)

            setProperty('scoreTxt.color', getColorFromHex('FF0000'))
            setProperty('botplayTxt.color', getColorFromHex('FF0000'))
    
            setProperty('healthGain', 0)
            setProperty('healthLoss', 0)
            setProperty('healthBar.visible', false)
            setProperty('healthBarBG.visible', false)
            setProperty('healthBarBG.active', false)

            cameraFlash('hud', '000000', 2.75, true)
        elseif v1 == 'kill' then
            cameraFlash('game', 'FF0000', 2.75, true)
            setProperty('mom.alpha', 0)
            setProperty('boyfriend.alpha', 0)
            setProperty('camHUD.visible', false)
            setProperty('defeatDKoverlay.alpha', 0)
        end
    end
end