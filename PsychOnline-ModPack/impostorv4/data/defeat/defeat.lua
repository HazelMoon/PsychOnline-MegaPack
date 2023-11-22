local missLimitCount = 5
local choosingMiss = true
local timerThingy = 0

local realScroll = false
local realStrum = true

local kaderEngine = false
local mouseVisible = false

function onDestroy()
    setPropertyFromClass('backend.ClientPrefs', 'middleScroll', realScroll)
end

local mouseX = 0
local mouseY = 0

function onCreate()
    setGlobalFromScript('scripts/impostorUI', 'missLimited', true)

    realScroll = getPropertyFromClass('ClientPrefs', 'middleScroll')
    setPropertyFromClass('backend.ClientPrefs', 'middleScroll', true)

    for i = 0, getProperty('opponentStrums.length')-1 do
        setPropertyFromGroup('opponentStrums', i, 'visible', false);
    end

    choosingMiss = not seenCutscene
    
    if choosingMiss then
        mouseX = getMouseX('other')
        mouseY = getMouseY('other')
        mouseVisible = getPropertyFromClass('flixel.FlxG', 'mouse.visible')
        setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)

        makeLuaSprite('hide', '', 0, 0)
        makeGraphic('hide', 2000, 2000, '000000')
        addLuaSprite('hide', true)
        setObjectCamera('hide', 'camOther')
        setProperty('hide.alpha', 1)

        makeLuaSprite('missCursor', 'defeat/missAmountArrow', 215, 400);
        addLuaSprite('missCursor', true);
        setObjectCamera('missCursor', 'camOther')

        makeLuaText('missTxt', '5/5 COMBO BREAKS', screenWidth, 0, screenHeight/2-225)
        setTextFont('missTxt', 'vcr.ttf')
        setTextSize('missTxt', 100)
        setTextColor('missTxt', '0xFF0000')
        setTextBorder('missTxt', 3, '0x000000')
        screenCenter('missTxt', 'x')
        addLuaText('missTxt')
        setObjectCamera('missTxt', 'camOther')

        local imageID = 0
        local y = 0
        for i = 1, 6 do
            imageID = 2-math.floor(((i-1)/2))
            if imageID == 2 then
                y = 425 + 40
            elseif imageID == 1 then
                y = 425 + 65
            end
            makeLuaSprite('dummypostor'..i, 'defeat/dummypostor'..imageID, i*150+65, y);
            addLuaSprite('dummypostor'..i, true);
            setObjectCamera('dummypostor'..i, 'camOther')
        end
    else
        setGlobalFromScript('scripts/impostorUI', 'missLimitCount', getPropertyFromClass('flixel.FlxG','save.data.defeatMiss') - 1)
    end
end

function onCreatePost()
    setRating()
    setProperty('scoreTxt.color', getColorFromHex('FF0000'))
    setProperty('botplayTxt.color', getColorFromHex('FF0000'))
	setProperty('timeBG.visible', false)
	setProperty('timeBar.visible', false)
	setProperty('timeTxt.visible', false)
	setProperty('timeBG.y', 32767)
	setProperty('timeBar.y', 32767)
	setProperty('timeTxt.y', 32767)
	setProperty('timeBG.active', false)
	setProperty('timeBar.active', false)
	setProperty('timeTxt.active', false)
    setPropertyFromClass('backend.ClientPrefs', 'middleScroll', realScroll)
end

function onStartCountdown()
	if choosingMiss then
		return Function_Stop;
	end
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', mouseVisible)
	return Function_Continue;
end

local z = ''
function onStepHit()
    if defeatEvents[tostring(curStep)] ~= nil then
        thing()
    end
end

function thing()
    for i, z in ipairs(defeatEvents[tostring(curStep)]) do
        triggerEvent(z[1], z[2], z[3])
    end
    defeatEvents[tostring(curStep)] = nil
end

local heldKey = 0
local highInc = 120
local rangeInc = 60
local mouseHold = 0
local exiting = false
local found = true
function onUpdate(elapsed)
    if choosingMiss and not exiting then
        found = true
        local mouseOldX = mouseX
        local mouseOldY = mouseY
        mouseX = getMouseX('other')
        mouseY = getMouseY('other')
        if ((mouseX ~= mouseOldX or mouseY ~= mouseOldY) and getPropertyFromClass('flixel.FlxG', 'mouse.pressed')) or
        getPropertyFromClass('flixel.FlxG', 'mouse.justPressed') then
            local dummyY = getMidpointY('dummypostor1')
            local dummyHusb = dummyY + highInc
            dummyY = dummyY - highInc
            for i = 1, 6 do
                local dummyX = getMidpointX('dummypostor'..i)
                local dummyWife = dummyX + rangeInc
                local newMissCount = 6 - i
                dummyX = dummyX - rangeInc
                if mouseX > dummyX and mouseX < dummyWife and
                    mouseY > dummyY and mouseY < dummyHusb and
                    missLimitCount ~= newMissCount then
                    missLimitCount = newMissCount
                    if newMissCount < missLimitCount then
                        playSound('panelAppear', 0.5)
                    else
                        playSound('panelDisappear', 0.5)
                    end
                    found = false
                    break
                end
            end
        end
        if found then
            if keyPressed('up') then
                missLimitCount = getRandomInt(1, 6) - 1
                playSound('panelDisappear', 0.125)
                playSound('panelAppear', 0.125)
                found = false
            elseif keyJustPressed('left') or (keyPressed('left') and heldKey > 0.5) then
                missLimitCount = missLimitCount + 1
                if missLimitCount > 5 then
                    missLimitCount = 0
                end
                playSound('panelDisappear', 0.5)
                found = false
            elseif keyJustPressed('right') or (keyPressed('right') and heldKey > 0.5) then
                missLimitCount = missLimitCount - 1
                if missLimitCount < 0 then
                    missLimitCount = 5
                end
                playSound('panelAppear', 0.5)
                found = false
            end

            if keyPressed('left') or keyPressed('right') then
                if heldKey > 0.5 then
                    heldKey = heldKey - 0.0625
                end
                heldKey = heldKey + elapsed
            else
                heldKey = 0
            end
        end
        if not found then
            setProperty('missCursor.x', (6-missLimitCount)*150+65)
            setTextString('missTxt', missLimitCount..'/5 COMBO BREAKS')
        end

        if not exiting and (keyJustPressed('accept') or
        (getPropertyFromClass('flixel.FlxG', 'mouse.justPressed') and
        mouseHold > 0)) then
            runHaxeCode([[PlayState.seenCutscene = true;]])
            setPropertyFromClass('flixel.FlxG','save.data.defeatMiss', missLimitCount + 1)
            setGlobalFromScript('scripts/impostorUI', 'missLimitCount', missLimitCount)
            callScript('scripts/impostorUI', 'setRating')
            playSound('amongKill', 0.5)
            removeLuaText('missTxt')
            removeLuaSprite('missCursor')
            for i = 1, 6 do
                removeLuaSprite('dummypostor'..i)
            end
            choosingMiss = false
        elseif not exiting and keyJustPressed('back') then
            exiting = true
            setPropertyFromClass('flixel.FlxG','save.data.endedProper', false)
            runHaxeCode([[PlayState.seenCutscene = false;]])
            exitSong()
        end

        if not getPropertyFromClass('flixel.FlxG', 'mouse.justPressed') then
            if mouseHold > 0 then
                mouseHold = mouseHold - elapsed
            else
                mouseHold = 0
            end
        else
            mouseHold = 0.2
        end
    else
        if timerThingy < 1.5 then
            timerThingy = timerThingy + elapsed
        else
            doTweenAlpha('hideHide', 'hide', 0, 0.25)
            startCountdown()
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'hideHide' then
        removeLuaSprite('hide')
    end
end

function onEvent(eventName, value1, value2)
    if eventName == 'Defeat Retro' then
        kaderEngine = not kaderEngine

        if kaderEngine then
            playAnim('bg', 'freeze', true)
        else
            playAnim('bg', 'bop', true)
        end
        callScript('scripts/impostorUI', 'kaderToggle')
    end
end