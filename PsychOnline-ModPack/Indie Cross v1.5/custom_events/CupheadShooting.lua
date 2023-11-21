local CupheadShotting = false;
local BfAttacking = false

local attack = 0;
local DisableBfNotes = false;

local ShottingStyle = 0

local CardCrapY = 520
local cardPercent = 0

local PeaShootCounter = 1
local PeaShotHurt = 0
local PeaOffsetX = 400
local PeaOffsetY = 210
local ChaserOffsetX = 390
local ChaserOffsetY = 350

local dadOffsetY = 0

local ChaserShotNumber = 0
local ChaserShotHurt = 0
local ChaserShotSound = 0

local BulletTimer = 0
local StartTimer = false

local changeHealthNotes = 0

local bulletsLength = 3
local bulletsTexture = 'cup/bull/Cupheadshoot'

local CupheadShotAnimations = {"pewLEFT","pewDOWN","pewUP","pewRIGHT"}
local frameRate = 0
function onCreate()
    precacheImage('cup/cardfull')
    makeAnimatedLuaSprite('Cardcrap', 'cup/Cardcrap',1000,CardCrapY + 100);
    addAnimationByPrefix('Cardcrap','Flipped','Card but flipped instance 1',1,true)
    addAnimationByPrefix('Cardcrap','Filled','Card Filled instance 1',24,false);
    addAnimationByPrefix('Cardcrap','Parry','PARRY Card Pop out  instance 1',24,false);
    addAnimationByPrefix('Cardcrap','Normal','Card Normal Pop out instance 1',24,false);
    addAnimationByPrefix('Cardcrap','Used','Card Used instance 1',24,false);
    setObjectCamera('Cardcrap','hud')
    cardPlayAnim('Flipped',false)
    
    makeLuaSprite('CardcrapGraphic','cup/cardfull',getProperty('Cardcrap.x'),getProperty('Cardcrap.y'))
    setObjectCamera('CardcrapGraphic','hud')
    setProperty('CardcrapGraphic.alpha',0.001)
    addLuaSprite('CardcrapGraphic',true)
    --setObjectOrder('CardcrapGraphic',getObjectOrder('Cardcrap'))

    if downscroll then
        CardCrapY = 0
    end
    setProperty('Cardcrap.y',CardCrapY)
    addLuaSprite('Cardcrap',true)
    objectPlayAnimation('Cardcrap','Flipped',false)
    if getProperty('dad.curCharacter') ~= 'Nightmare-Cuphead' then
        --Load Green Shot
        makeAnimatedLuaSprite('FlashShot','cup/bull/Cupheadshoot',getProperty('dad.x') + PeaOffsetX - 80,getProperty('dad.y') + PeaOffsetY + 180)
        addAnimationByPrefix('FlashShot','Flash','BulletFlashFX instance 1',24,false);

    else
        bulletsTexture = 'cup/bull/NMcupheadBull'
        bulletsLength = 5
    end
    -- cuphead blue shot
    for BulletsLength = 1, bulletsLength do
        makeAnimatedLuaSprite('Peashoot' ..BulletsLength, bulletsTexture, getProperty('dad.x') + PeaOffsetX, getProperty('boyfriend.y') - PeaOffsetY - (25 * (BulletsLength - 1)));
    
        for bulletsAnimations = 1,bulletsLength do
            addAnimationByPrefix('Peashoot' ..BulletsLength, 'H-Tween'..bulletsAnimations, 'Shot0'..bulletsAnimations..' instance 1', 25, false);
        end
    end
    for greenBullets = 0, 7 do
        makeAnimatedLuaSprite('GreenShit' ..greenBullets, 'cup/bull/GreenShit', getProperty('dad.x') + 360, getProperty('dad.y') + 60);
        for greenAnimations = 1,3 do
            addAnimationByPrefix('GreenShit'..greenBullets,'ChaserShot'..greenAnimations, 'GreenShit0'..greenAnimations, 24,false);
        end
        setBlendMode('GreenShit' ..greenBullets,'add')
    end
    precacheImage('cup/Cardcrap')
    precacheImage('cup/bull/Cupheadshoot')
    precacheImage('cup/bull/GreenShit')
    precacheImage('cup/bull/NMcupheadBull')
end
function onCreatePost()
    dadOffsetY = getProperty('dad.positionArray[1]')
end
function onEvent(name,value1,value2)
    if (name == 'CupheadShooting') then
        if (string.lower(value2) ~= 'false') then
            CupheadShotting = true
            changeHealthNotes = 2
            if tonumber(value1) ~= 1 then
                StartTimer = true
                BulletTimer = 10
    
                ShottingStyle = 0
            else
                ShottingStyle = 1
            end
        else
            CupheadShotting = false
            ShottingStyle = 0
        end
        if botplay and ShottingStyle ~= 1 then
            attackCup()
        end
    elseif name == 'Change Character' then
        dadOffsetY = getProperty('dad.positionArray[1]')
    end
end
function onUpdate(el)
    frameRate = frameRate + el
    if (frameRate >= 1 / 60) then
        if (CupheadShotting == true and StartTimer == true and ShottingStyle == 0) then
            if (BulletTimer > 0) then
                BulletTimer = BulletTimer - 1

            elseif (BulletTimer <= 0) then
                BulletTimer = 5
                PeaShootCounter = PeaShootCounter + 1
                if tonumber(dadOffsetY) == nil then
                    dadOffsetY = 0
                end
                characterPlayAnim('dad','shotting', true)
                setProperty('dad.specialAnim', true);
                addLuaSprite('Peashoot' ..PeaShootCounter-1, true)
                setProperty('Peashoot'..(PeaShootCounter-1)..'.x',getProperty('dad.x') + PeaOffsetX)
                setProperty('Peashoot'..(PeaShootCounter-1)..'.y',getProperty('dad.y') - dadOffsetY + PeaOffsetY - (25 * (PeaShootCounter - 1)))
                objectPlayAnimation('Peashoot' ..PeaShootCounter-1, 'H-Tween' ..(math.random(1,bulletsLength)), true)
                playSound('Cup/pea'..(math.random(0, 5)))
                if (getProperty('dad.curCharacter') ~= 'Nightmare-Cuphead') then
                    addLuaSprite('FlashShot', true)
                    setProperty('FlashShot.x',getProperty('dad.x') + PeaOffsetX - 80)
                    setProperty('FlashShot.y',getProperty('dad.y') + PeaOffsetY + 180)
                    objectPlayAnimation('FlashShot', 'Flash', true)
                end
            end
        end
        frameRate = 0
    end
    if changeHealthNotes == 2 then
        for notesLength = 0,getProperty('notes.length')-1 do
            if getPropertyFromGroup('notes', notesLength, 'noteType') == '' and getPropertyFromGroup('notes', notesLength, 'hitHealth') > 0 then
                setPropertyFromGroup('notes', notesLength, 'hitHealth',getPropertyFromGroup('notes', notesLength, 'hitHealth') - 0.023);
            end
        end
    elseif changeHealthNotes == 1 then
        for notesLength = 0,getProperty('notes.length')-1 do
            if getPropertyFromGroup('notes', notesLength, 'noteType') == '' and getPropertyFromGroup('notes', notesLength, 'hitHealth') > -0.023 then
                setPropertyFromGroup('notes', notesLength, 'hitHealth',getPropertyFromGroup('notes', notesLength, 'hitHealth') + 0.023);
            end
        end
        changeHealthNotes = 0
    end

    if DisableBfNotes then
        disableNotes(true,true)
        local bfAnim = getProperty('boyfriend.animation.curAnim.name')
        if (getProperty('boyfriend.animation.curAnim.finished') and bfAnim == 'attack' or bfAnim ~= 'attack') then
            disableNotes(true,false)
            DisableBfNotes = false
            BfAttacking = false
        end
    end

    if ChaserShotNumber > 7 then
        ChaserShotNumber = 0
    end

    if ChaserShotSound > 3 then
        ChaserShotSound = 0
    end

    if (PeaShootCounter > bulletsLength) then
        PeaShootCounter = 1
    end

    for ChaserShotCount = 1,7 do
        if getProperty('GreenShit'..ChaserShotCount..'.animation.curAnim.finished') == true then
            removeLuaSprite('GreenShit'..ChaserShotCount,false)
        end
        while (getProperty('GreenShit'..ChaserShotCount..'.animation.curAnim.curFrame') == 10 and ChaserShotHurt ~= ChaserShotCount and getProperty('health') > 0.05) do
            setProperty('health', getProperty('health')-0.023)
            ChaserShotHurt = ChaserShotCount
        end
    end

    if getProperty('dad.curCharacter') ~= 'Nightmare-Cuphead' then
        if getProperty('FlashShot.animation.curAnim.finished') == true then
            removeLuaSprite('FlashShot',false)
        end
    end

    for PeaShotC = 1, bulletsLength do
        if (getProperty('Peashoot'..PeaShotC..'.animation.curAnim.finished')) then
            removeLuaSprite('Peashoot'..PeaShotC, false)
        end
        while (getProperty('Peashoot'..PeaShotC..'.animation.curAnim.curFrame') == 6 and PeaShotHurt ~= PeaShotC) do
            setProperty('health', getProperty('health') - 0.06)
            PeaShotHurt = PeaShotC
        end
    end
    local cardAnim = getProperty('Cardcrap.animation.curAnim.name')
    if (getProperty('Cardcrap.animation.curAnim.finished') == true) then
        if (cardAnim  == 'Used') then
            cardPlayAnim('Flipped',true)
            cardPercent = 0
        elseif (cardAnim == 'Parry') then
            cardPlayAnim('Filled',false)
        end
    end
    if cardPercent < 1 then
        setProperty('Cardcrap.alpha',0)
        setProperty('CardcrapGraphic.y',getProperty('Cardcrap.y') + 147 - (147 * cardPercent))
    else
        setProperty('CardcrapGraphic.alpha',0)
        setProperty('Cardcrap.alpha',1)
    end
    if attack == 1 then
        if BfAttacking == false then
            if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SHIFT') or CupheadShotting and ShottingStyle == 0 and botPlay then -- If press Shift, BF will attack
                attackCup()
            end
        end
    end
end
function attackCup()
    cardPlayAnim('Used',false)
    DisableBfNotes = true
    disableNotes(true,true)
    characterPlayAnim('boyfriend','attack',false)
    setProperty('boyfriend.specialAnim',true)
    runTimer('CupheadHurt',0.3)
    playSound('IC/Throw'..(math.random(1,3)))
    attack = 0
    BfAttacking = true
end
function cardPlayAnim(anim,force)
    local offsetX = 0
    local offsetY = 0
    if anim == 'Parry' then
        offsetX = 6
        offsetY = 25
    end
    setProperty('Cardcrap.offset.x',offsetX)
    setProperty('Cardcrap.offset.y',offsetY)
    objectPlayAnimation('Cardcrap',anim,force)
end
function disableNotes(mustPress,disable)
    for notesLength = 0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes', notesLength, 'mustPress') == mustPress then
            setPropertyFromGroup('notes', notesLength, 'noAnimation', disable)
        end
    end
end
function addAttack()
    attack = 1
    cardPercent = 1
    setProperty('Cardcrap.y', CardCrapY)
end
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Parry Note' then
		-- put something here if you want
        addAttack()
        cardPlayAnim('Parry',false)
	else
        if getProperty('Cardcrap.animation.curAnim.name') == 'Flipped' then
            if cardPercent < 1 then
                cardPercent = cardPercent + 0.01
                    loadGraphic('CardcrapGraphic','cup/cardfull',97,144*cardPercent)
                    setProperty('CardcrapGraphic.alpha',1)
            elseif cardPercent >= 1 then
                addAttack()
                cardPlayAnim('Normal',false)
            end
        end
	end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
    if not isSustainNote and CupheadShotting == true then
        if ShottingStyle == 1 then
            characterPlayAnim('dad',CupheadShotAnimations[noteData + 1],true)
            setProperty('dad.specialAnim',true)
            addLuaSprite('GreenShit'..ChaserShotNumber,true)
            setProperty('GreenShit'..ChaserShotNumber..'.x',getProperty('dad.x') + ChaserOffsetX)
            setProperty('GreenShit'..ChaserShotNumber..'.y',getProperty('dad.y') + ChaserOffsetY)
            objectPlayAnimation('GreenShit'..ChaserShotNumber,'ChaserShot'..(math.random(1,3)), false)
            playSound('cup/chaser'..ChaserShotSound)
            ChaserShotNumber  = ChaserShotNumber + 1
            ChaserShotSound  = ChaserShotSound + 1
        else
            CupheadShotting = false;
            changeHealthNotes = 1
        end
    end
end

function onTimerCompleted(tag)
    if tag == 'CupheadHurt' then
        setProperty('health',getProperty('health') + 1)
        if CupheadShotting == true or getProperty('dad.curCharacter') == 'cuphead-pissed' then
            if changeHealthNotes == 2 then
                changeHealthNotes = 1
            end

            if getProperty('dad.curCharacter') ~= 'Nightmare-Cuphead' then

                characterPlayAnim('dad','hurt',true)
                setProperty('dad.specialAnim',true);
                playSound('cup/CupHurt')

            else
                characterPlayAnim('dad','dodge',true)
                setProperty('dad.specialAnim',true);
                playSound('cup/CupDodge')
            end
            CupheadShotting = false
        elseif CupheadShotting == false or getProperty('dad.curCharacter') == 'Nightmare-Cuphead' then

            characterPlayAnim('dad','dodge',true)
            setProperty('dad.specialAnim',true);
            playSound('cup/CupDodge')
        end
    end
end
