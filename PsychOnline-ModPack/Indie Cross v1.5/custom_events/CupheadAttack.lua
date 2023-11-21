local Dodge = 0;
local BigShotCurrent = 0
local BigShotDestroyed = 0
local BigShotTexture = 'cup/bull/Cuphead Hadoken'
local BigShotCreated = true
local DisableBFNotes = false
local InstaKillPeaBigShot = false
local DodgeTimerCupAttack = 0

local currentEvent = -1--To make the event play once

local cupAlertCreated = false

local cupAlertOfsX = 157
local cupAlertOfsY = -304
local dadAttackAnim = 'attack'

local frameRate = 0

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
    detectAttack(true)
end
function detectAttack(precache)
    local dad = getProperty('dad.curCharacter')
    if dad ~= 'cuphead-pissed' and dad ~= 'Nightmare-Cuphead' then
        dadAttackAnim = 'attack'
    else
        dadAttackAnim = 'big shot'
        if dad ~= 'Nightmare-Cuphead' then
            BigShotTexture = 'cup/bull/Cuphead Hadoken'
        else
            BigShotTexture = 'cup/bull/NMcupheadAttacks'
        end
        if precache then
            precacheImage(BigShotTexture)
        end
    end
end
function onEvent(name,v1,v2)
    if name == "CupheadAttack" then
        if v2 ~= '' then
            InstaKillPeaBigShot = true
        else
            InstaKillPeaBigShot = false
        end
        BigShotCurrent = BigShotCurrent + 1
        makeAnimatedLuaSprite('BigShotCuphead'..BigShotCurrent, BigShotTexture,getProperty('dad.x') - 200,getProperty('boyfriend.y') - 100);
        addAnimationByPrefix('BigShotCuphead'..BigShotCurrent ,'Burst','BurstFX instance 1',24,true);
        if BigShotTexture ~= 'cup/bull/NMcupheadAttacks' then
            addAnimationByPrefix('BigShotCuphead'..BigShotCurrent,'Hadolen','Hadolen instance 1',24,false);
        end
        setBlendMode('BigShotCuphead'..BigShotCurrent,'add')
        addLuaSprite('BigShotCuphead'..BigShotCurrent,true)
        objectPlayAnimation('BigShotCuphead'..BigShotCurrent,'Burst')
        playSound('cup/CupShoot')
        runTimer('dodgeCupAttack'..BigShotCurrent,math.abs(DodgeTimerCupAttack))
        BigShotCreated = true
        currentEvent = -1
    elseif name == 'Change Character' then
        if string.lower(v1) == 'dad' or v1 == '1' then
            detectAttack(false)
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
function onUpdate(el)
    DodgeTimerCupAttack = (getProperty('boyfriend.x') - getProperty('dad.x')) / 10000
    if BigShotCreated == true then
        frameRate = frameRate + el
        if (frameRate >= 1 / 60) then
            frameRate = 0
            if BigShotDestroyed < BigShotCurrent then
                for bigShotLength = BigShotDestroyed + 1,BigShotCurrent do
                    if getProperty('BigShotCuphead'..bigShotLength..'.x') ~= 'BigShotCuphead'..bigShotLength..'.x' then--Detect if the Hadoken exists
                        if getProperty('BigShotCuphead'..bigShotLength..'.animation.curAnim.name') ~= 'Hadolen' then
                            setProperty('BigShotCuphead'..bigShotLength..'.x',getProperty('BigShotCuphead'..bigShotLength..'.x') + 70)
                        else
                            setProperty('BigShotCuphead'..bigShotLength..'.offset.y',400)
                            if getProperty('BigShotCuphead'..bigShotLength..'.animation.curAnim.finished') == true then
                                removeLuaSprite('BigShotCuphead'..bigShotLength,true)
                                BigShotDestroyed = BigShotDestroyed + 1
                                if BigShotDestroyed == BigShotCurrent then
                                    BigShotCreated = false
                                end
                            end
                        end
                        local bigShotX = getProperty('BigShotCuphead'..bigShotLength..'.x')
                        local bfXOffset = getProperty('boyfriend.positionArray[0]')
                        if bfXOffset == nil then--The "positionArray" function doesn't work in version 0.5.-, this will fix if the player has a version lower than 0.6.+
                            bfXOffset = 0
                        end
                        local bfX = getProperty('boyfriend.x') - bfXOffset
                        if bigShotX > (bfX + (screenWidth * (1 + (1 - getProperty('defaultCamZoom')))) + getProperty('BigShotCuphead'..bigShotLength..'.width')) then
                            BigShotDestroyed = BigShotDestroyed + 1
                            removeLuaSprite('BigShotCuphead'..BigShotCurrent,true)
                        end
                    end
                end
            end
        end
    end
    for eventNotes = 0,getProperty('eventNotes.length')-1 do
        if (getPropertyFromGroup('eventNotes',eventNotes,'strumTime') - getSongPosition()) < 600 and getPropertyFromGroup('eventNotes',eventNotes,'event') == 'CupheadAttack' and currentEvent < eventNotes then
            if getPropertyFromGroup('eventNotes',eventNotes,'value1') == '' then
                if not cupAlertCreated then
                    if not downscroll then
                        makeAnimatedLuaSprite('CupAlert','cup/mozo',500,340)
                    else
                        makeAnimatedLuaSprite('CupAlert','cup/gay',500,110)
                    end
                    addAnimationByPrefix('CupAlert','Alert','YTJT instance 1',24,false)
                    setObjectCamera('CupAlert','hud')
                    cupAlertCreated = true
                    addLuaSprite('CupAlert',true)
                end
                playSound('Cup/fuckyoumoro')
                objectPlayAnimation('CupAlert','Alert',true)
                Dodge = 2
            else
                Dodge = 3
            end
            runTimer('CupheadPreAttack',0.25)
            currentEvent = eventNotes
        end
    end
    if Dodge == 2 and keyJustPressed('space') and not botPlay or Dodge == 2 and botPlay then
        Dodge = 1
    end
    if DisableDadNotes then
        disableNotes(false,true)
        if (getProperty('dad.animation.curAnim.name') ~= dadAttackAnim or getProperty('dad.animation.curAnim.name') == dadAttackAnim and getProperty('dad.animation.curAnim.finished') == true) then
            disableNotes(false,false)
            DisableDadNotes = false
        end
    end
    if DisableBFNotes then
        disableNotes(true,true)
        if (getProperty('boyfriend.animation.curAnim.name') ~= 'dodge' or getProperty('boyfriend.animation.curAnim.name') == 'dodge' and getProperty('boyfriend.animation.curAnim.finished') == true) then
            disableNotes(true,false)
            DisableBFNotes = false
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
end

function onTimerCompleted(tag)
    if tag == 'CupheadPreAttack' then
        playSound('Cup/CupPre_shoot')
        DisableDadNotes = true
        disableNotes(false,true)
        characterPlayAnim('dad', dadAttackAnim, false);
        setProperty('dad.specialAnim', true);
        if Dodge == 3 then
            Dodge = 2
        end
    end

    if string.match(tag,'dodgeCupAttack') == 'dodgeCupAttack' then
        if Dodge == 1 then
            DisableBFNotes = true
            disableNotes(true,true)
            characterPlayAnim('boyfriend','dodge',false)
            setProperty('boyfriend.specialAnim',true)
            playSound('cup/CupDodge',1)
            Dodge = 0
        elseif Dodge == 2 then
            characterPlayAnim('boyfriend','hurt',false);
            setProperty('boyfriend.specialAnim',true);
    
            if getProperty('health') - 1.4 > 0 and not InstaKillPeaBigShot then
             setProperty('health',getProperty('health') - 1.4)
    
            elseif getProperty('health') - 1.4 <= 0 or InstaKillPeaBigShot then
             runTimer('GameOver',0.3);
            end
    
            if BigShotTexture ~= 'cup/bull/NMcupheadAttacks' then
                objectPlayAnimation('BigShotCuphead'..BigShotCurrent,'Hadolen',false)
                setProperty('BigShotCuphead'..BigShotCurrent..'offset.y',500)
            end
        end
    end

    if tag == 'GameOver' then
        setProperty('health', -0.1);
    end
end
