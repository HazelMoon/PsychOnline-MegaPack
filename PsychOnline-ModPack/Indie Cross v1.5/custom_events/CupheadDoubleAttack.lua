local Dodge = 0
local DisableBFNotes = false
local DisableDadNotes = false
local DodgeTimerCupDoubleAttack = 0
local InstaKillRoundabout = false

local currentDouble = 0
local doubleDestroyed = -1
local doubleOffsetY = 0
local doubleTexture = 'cup/bull/NMcupheadAttacks'
local doubleScaleX = 1.3
local doubleScaleY = 1.3

local currentEvent = -1

local cupAlertCreated = false
local cupAlertOfsX = 157
local cupAlertOfsY = -304

local attackAnim = 'attack'
function onCreate()
    if not downscroll then
        makeAnimatedLuaSprite('CupAlert','cup/mozo',500,340)
    else
        makeAnimatedLuaSprite('CupAlert','cup/gay',500,110)
        cupAlertOfsY = 27
    end
    addAnimationByPrefix('CupAlert','Alert','YTJT instance 1',24,false)
    setObjectCamera('CupAlert','hud')
    addLuaSprite('CupAlert',true)
    setProperty('CupAlert.alpha',0.001)
end
function onCreatePost()
    detectRoundAttack(true)
end
function onEvent(name,value1,value2)
    if name == "CupheadDoubleAttack" then
        makeAnimatedLuaSprite('Roundabout'..currentDouble, doubleTexture,getProperty('dad.x') + 370,getProperty('boyfriend.y'));
        addAnimationByPrefix('Roundabout'..currentDouble,'idle','Roundabout instance 1',24,true);
        scaleObject('Roundabout'..currentDouble,doubleScaleX,doubleScaleY)
        setProperty('Roundabout'..currentDouble..'.offset.y', doubleOffsetY)
        addLuaSprite('Roundabout'..currentDouble,true)
        setObjectOrder('Roundabout'..currentDouble,getObjectOrder('boyfriendGroup') - 1)
        doTweenX('RoundaboutX'..currentDouble,'Roundabout'..currentDouble,getProperty('boyfriend.x') + 500, 0.9, 'QuadOut');
        setBlendMode('Roundabout'..currentDouble,'add')
        runTimer('dodgeDoubleAttack'..currentDouble,math.abs(DodgeTimerCupDoubleAttack))
        playSound('cup/CupShoot')
        currentDouble = currentDouble + 1
 
        if value2 ~= '' then
            InstaKillRoundabout = true
        else
            InstaKillRoundabout = false
        end
        currentEvent = -1
    elseif name == 'Change Character' then
        if string.lower(value1) == 'dad' or value1 == '1' then
            detectRoundAttack(false)
        end
    end
end
function disableNotes(mustPress,disable)
    for notesLength = 0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes', notesLength, 'mustPress') == mustPress then
            setPropertyFromGroup('notes', notesLength, 'noAnimation', disable)
        end
    end
end
function onTweenCompleted(tag)
    if string.find(tag, 'Roundabout') ~= nil then
        for round = doubleDestroyed,currentDouble do
            if tag == 'RoundaboutX'..round then
                doTweenX('RoundaboutXBye'..round,'Roundabout'..round,getProperty('boyfriend.x') - (1280 * (2 + math.abs(1 - getProperty('defaultCamZoom')))), 1.5, 'QuadIn');
                setObjectOrder('Roundabout'..round,getObjectOrder('boyfriendGroup') + 1)
                doTweenX('RoundaboutScaleX'..round,'Roundabout'..round..'.scale',getProperty('Roundabout'..round..'.scale.x') + 0.15,1,'QuadIn')
                doTweenY('RoundaboutScaleY'..round,'Roundabout'..round..'.scale',getProperty('Roundabout'..round..'.scale.y') + 0.15,1,'QuadIn')
                runTimer('RoundaboutDestroy',2)
                Dodge = 2
                runTimer('dodgeDoubleAttack'..round,0.4)
                setObjectOrder('Roundabout'..round,getObjectOrder('boyfriendGroup') + 1)
            elseif tag == 'RoundaboutXBye'..round then
                removeLuaSprite('Roundabout'..doubleLength,true)
                doubleDestroyed = doubleDestroyed + 1
            end
        end
    end
end
function detectRoundAttack(precache)
    if getProperty('dad.curCharacter') ~= 'cuphead-pissed' and getProperty('dad.curCharacter') ~= 'Nightmare-Cuphead' then
        attackAnim = 'attack'
    else
        attackAnim = 'big shot'
        if getProperty('dad.curCharacter') ~= 'Nightmare-Cuphead' then
            doubleTexture = 'cup/bull/Roundabout'
            doubleScaleX = 1.3
            doubleScaleY = 1.3
            doubleOffsetY = 0
        else
            doubleTexture = 'cup/bull/NMcupheadAttacks'
            doubleScaleX = 0.8
            doubleScaleY = 0.7
            doubleOffsetY = 100
        end
        if precache then
            precacheImage(doubleTexture)
        end
    end
end
function onUpdate()
    DodgeTimerCupDoubleAttack = (getProperty('boyfriendGroup.x') - getProperty('dadGroup.x')) / 30000
    for eventNotes = 0,getProperty('eventNotes.length')-1 do
        if (getPropertyFromGroup('eventNotes',eventNotes,'strumTime') - getSongPosition()) < 600 and getPropertyFromGroup('eventNotes',eventNotes,'event') == 'CupheadDoubleAttack' and currentEvent < eventNotes then
            runTimer('CupheadDoubleAttack',0.6)
            playSound('Cup/CupPre_shoot')
            local value1 = string.lower(getPropertyFromGroup('eventNotes',eventNotes,'value1'))
            if value1 ~= 'false' then
                if not cupAlertCreated then
                    if not downscroll then
                        makeAnimatedLuaSprite('CupAlert','cup/mozo',500,340)
                    else
                        makeAnimatedLuaSprite('CupAlert','cup/gay',500,110)
                    end
                    addAnimationByPrefix('CupAlert','Alert','YTJT instance 1',24,false)
                    setObjectCamera('CupAlert','hud')
                    addLuaSprite('CupAlert',true)
                    playSound('Cup/fuckyoumoro')
                    cupAlertCreated = true
                end
                objectPlayAnimation('CupAlert','Alert',true)
            else
                Dodge = 3
            end
            if Dodge == 0 then
                Dodge = 2
            end
            runTimer('CupheadPreAttack',0.25)
            currentEvent = eventNotes
        end
    end
    if cupAlertCreated == true then
        setProperty('CupAlert.x',getProperty('healthBar.x') + cupAlertOfsX)
        setProperty('CupAlert.y',getProperty('healthBar.y') + cupAlertOfsY)
        setProperty('CupAlert.angle',getProperty('healthBar.angle'))
        if getProperty('CupAlert.animation.curAnim.finished') then
            removeLuaSprite('CupAlert',true)
            cupAlertCreated = false
        end
    end
    if DisableDadNotes then
        disableNotes(false,true)
        if getProperty('dad.animation.curAnim.name') ~= attackAnim  or getProperty('dad.animation.curAnim.name') == attackAnim and getProperty('dad.animation.curAnim.finished') == true then
            disableNotes(false,false)
            DisableDadNotes = false
        end
    end
    if DisableBFNotes then
        disableNotes(true,true)
        if getProperty('boyfriend.animation.curAnim.finished') and getProperty('boyfriend.animation.curAnim.name') == 'dodge' or getProperty('boyfriend.animation.curAnim.name') ~= 'dodge' then
            disableNotes(true,false)
            DisableBFNotes = false
        end
    end

    if Dodge == 2 and (keyJustPressed('space') and not botPlay or botPlay) then
        Dodge = 1
    end
end
function bfDodge()
    disableNotes(true,true)
    characterPlayAnim('boyfriend','dodge',true)
    setProperty('boyfriend.specialAnim',true)
    DisableBFNotes = true
    playSound('cup/CupDodge',1)
end
function bfHurt()
    characterPlayAnim('boyfriend','hurt',false)
    setProperty('boyfriend.specialAnim',true)
    if getProperty('health') - 1.2 > 0 and not InstaKillRoundabout then
        setProperty('health',getProperty('health') - 1.2)
    elseif getProperty('health') - 1.2 <= 0 or InstaKillRoundabout then
        runTimer('GameOver',0.3)
    end
end
function onTimerCompleted(tag)
    if tag == 'CupheadPreAttack' then
        characterPlayAnim('dad', attackAnim, false);
        setProperty('dad.specialAnim', true);
        DisableDadNotes = 2
        if Dodge == 3 then
            Dodge = 2
        end
    end
    
    if string.find(tag,'dodgeDoubleAttack',0,true) ~= nil then
        for doubleLength = doubleDestroyed,currentDouble do
            if tag == 'dodgeDoubleAttack'..doubleLength then
                if Dodge == 1 then
                    bfDodge()
                elseif Dodge == 2 then
                    bfHurt()
                    objectPlayAnimation('BigShotCuphead','Burst',false)
                end
            end
        end
    end
    if tag == 'Dodge' then
        if Dodge == 1 then
            bfDodge()

		elseif Dodge == 2 then
            bfHurt()
        end
    end

end
