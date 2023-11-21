local BfStopAnim = false
local StopAnimName = ''

local BFBendyAttack = false

local CameraEffect = false

local PiperX = false
local StrikerX = false
local PiperSpawn = 100
local StrikerSpawn = 200
local PiperAttack = 0
local StrikerAttack = 0
local PiperAttackTimeMax = 400
local StrikerAttackTimeMax = 400

local PiperOffsetX = 0
local StrikerOffsetX = 0

local PiperOffsetY = 0
local StrikerOffsetY = 0

local PiperBFX = 500
local StrikerBFX = -300


local PiperAttacking = false
local Dodge1 = 0

local StrikerAttacking = false
local Dodge2 = 0

local PiperHP = 3
local StrikerHP = 3

local foundedSong = false
local AttackEnable = false

local piperTexture = 'bendy/third/Piper'
local strikerTexture = 'bendy/third/Striker'

local SplashDamage = 0
function onCreatePost()
    if difficulty ~= 0 then
        if songName == 'Last-Reel' then
            PiperOffsetY = 70
            StrikerOffsetY = 80

            PiperOffsetX = 1220
            StrikerOffsetX = -750

            AttackEnable = true
        elseif songName == 'Despair' then
            piperTexture = 'bendy/third/PiperDespair'
            strikerTexture = 'bendy/third/StrikerDespair'
            PiperOffsetY = 70
            StrikerOffsetY = 80

            PiperBFX = 550
            StrikerBFX = -200

            PiperOffsetX = 2000
            StrikerOffsetX = 0

        end
        if songName == 'Last-Reel' or songName == 'Despair' then
            makeAnimatedLuaSprite('Piper',piperTexture,screenWidth + PiperOffsetX,getProperty('boyfriend.y') + PiperOffsetY)
            addAnimationByPrefix('Piper','Walking','pip walk instance 1',24,true)
            addAnimationByPrefix('Piper','Idle','Piperr instance 1',24,false)
            addAnimationByPrefix('Piper','Hurt','Piper gets Hit instance 1',24,false)
            addAnimationByPrefix('Piper','Dead','Piper ded instance 1',24,false)
            addAnimationByPrefix('Piper','Attack','PeepAttack instance 1',24,false)
            addAnimationByPrefix('Piper','Pre-Attack','PipAttack instance 1',24,false)
            scaleObject('Piper',1.8,1.8)
            
            makeAnimatedLuaSprite('Striker',strikerTexture,0 + StrikerOffsetX,getProperty('boyfriend.y') + StrikerOffsetY)
            addAnimationByPrefix('Striker','Walking','Str walk instance 1',24,true)
            addAnimationByPrefix('Striker','Hurt','Sticker  instance 1',24,false)
            addAnimationByPrefix('Striker','Dead','I ded instance 1',24,false)
            addAnimationByPrefix('Striker','Pre-Attack','PunchAttack_container instance 1',24,false)
            addAnimationByPrefix('Striker','Attack','regeg instance 1',24,false)
            addAnimationByPrefix('Striker','Idle','strrr instance 1',24,false)
            scaleObject('Striker',1.8,1.8)

            makeAnimatedLuaSprite('AttackButton','IC_Buttons',-6,245)
            addAnimationByPrefix('AttackButton','Static','Attack instance 1',24,true)
            addAnimationByPrefix('AttackButton','NA','AttackNA instance 1',30,false)
            objectPlayAnimation('AttackButton','Static',true)
            setObjectCamera('AttackButton','hud')
            addLuaSprite('AttackButton',false)
            scaleObject('AttackButton',0.5,0.5)
            setProperty('AttackButton.offset.x',0)
            setProperty('AttackButton.offset.y',0)
            setProperty('AttackButton.alpha',0.5)
            
            foundedSong = true
            for bendySplash = 1,4 do
                precacheImage('bendy/Damage0'..bendySplash)
            end
        end
    end
end
function disableNotes(mustPress,disable)
    for notesLength = 0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes', notesLength,'mustPress') == mustPress then
            setPropertyFromGroup('notes', notesLength, 'noAnimation',disable)
        end
    end
end
function dodgeInk()
    disableNotes(true,true)
    characterPlayAnim('boyfriend', 'dodge', true)
    setProperty('boyfriend.specialAnim',true)
    StopAnimName = 'dodge'
    BfStopAnim = true
end
function hurtInk()
    addInk()
    characterPlayAnim('boyfriend','hurt',true)
    setProperty('boyfriend.specialAnim',true)
end
function attackInk(enemy)
    local anim = 'attack'
    if enemy == 'striker' then
        disableNotes(true,true)
        if (StrikerX == true) then
            StrikerAttacking = false
            Dodge2 = 0
            StrikerAttack = StrikerAttack - 100
            StrikerPlayAnim('Hurt')
            StrikerHP = StrikerHP - 1

        end
    elseif enemy == 'piper' then
        anim = 'attack2'

        if (PiperX == true) then
            PiperAttacking = false
            Dodge1 = 0

            PiperAttack = PiperAttack - 100
            PiperHP = PiperHP - 1

            PiperPlayAnim('Hurt')
            playSound('bendy/butcherSounds/Hurt0' ..math.random(1,2), 50)
        end
    end
    disableNotes(true,true)
    characterPlayAnim('boyfriend',anim,true)
    setProperty('boyfriend.specialAnim',true)
    BfStopAnim = true
    BFBendyAttack = true
    StopAnimName = anim
    playSound('bendy/butcherSounds/Hurt0' ..math.random(1,2))
end
local fps = 0
function onUpdate(el)
    if foundedSong then
        if AttackEnable == true then
            fps = fps + el
            if fps >= 1/120 then
                if (PiperSpawn > 0) then
                    PiperSpawn = PiperSpawn - 1
                end
                if (StrikerSpawn > 0) then
                    StrikerSpawn = StrikerSpawn - 1
                end

                if (PiperSpawn == 0) then
                    setProperty('Piper.x', screenWidth + PiperOffsetX)
                    setProperty('Piper.y', getProperty('boyfriend.y') + PiperOffsetY)
                    addLuaSprite('Piper', false)
                    setObjectOrder('Piper',getObjectOrder('boyfriendGroup') + 1)
                    PiperHP = 3
                    PiperX = false
                    PiperSpawn = -1
                end
    
                if (StrikerSpawn == 0) then
                    addLuaSprite('Striker', false)
                    setObjectOrder('Striker',getObjectOrder('boyfriendGroup') + 1)
                    setProperty('Striker.x', 0 + StrikerOffsetX)
                    setProperty('Striker.y', getProperty('boyfriend.y') + StrikerOffsetY)
                    StrikerHP = 3
                    StrikerX = false
                    StrikerSpawn = -1
                end
                if PiperHP > 0 and PiperSpawn == -1 then
                    if not PiperX then
                        if getProperty('Piper.x') > getProperty('boyfriend.x') + PiperBFX then
                            PiperPlayAnim('Walking')
                            setProperty('Piper.x',getProperty('Piper.x') - 1)
                        elseif getProperty('Piper.x') <= getProperty('boyfriend.x') + PiperBFX then
                            PiperX = true
                            setProperty('Piper.x',getProperty('boyfriend.x') + PiperBFX)
                            PiperPlayAnim('Idle')
                            PiperAttack = PiperAttackTimeMax
                        end
                    end
                end
                if StrikerHP > 0 and StrikerSpawn == -1 then
                    if not StrikerX then
                        if getProperty('Striker.x') < getProperty('boyfriend.x') + StrikerBFX  then
                            StrikerPlayAnim('Walking')
                            setProperty('Striker.x',getProperty('Striker.x') + 3)
                        elseif getProperty('Striker.x') >= getProperty('boyfriend.x') + StrikerBFX then
                            StrikerX = true
                            setProperty('Striker.x',getProperty('boyfriend.x') + StrikerBFX)
                            StrikerPlayAnim('Idle')
                            StrikerAttack = StrikerAttackTimeMax
                        end
                    end
                end

                if (PiperHP > 0 and PiperX == true) then
                    if (PiperAttack < PiperAttackTimeMax) then
                        PiperAttack = PiperAttack + 1
                        PiperAttacking = false
                    elseif (PiperAttack >= PiperAttackTimeMax and PiperAttacking == false) then
                        Dodge1 = 2
                        PiperPlayAnim('Pre-Attack')
                        PiperAttacking = true
                    end
                end

                
                if (StrikerHP > 0 and StrikerX == true) then
                    if (StrikerAttack < StrikerAttackTimeMax) then
                        StrikerAttack = StrikerAttack + 1
                        StrikerAttacking = false
                    elseif (StrikerAttack >= StrikerAttackTimeMax and not StrikerAttacking) then
                        Dodge2 = 2
                        StrikerPlayAnim('Pre-Attack')
                        StrikerAttacking = true
                    end
                end
                
                if BfStopAnim then
                    disableNotes(true,true)
                    if getProperty('boyfriend.animation.curAnim.name') ~= StopAnimName or getProperty('boyfriend.animation.curAnim.name') == StopAnimName and getProperty('boyfriend.animation.curAnim.finished') == true then
                        StopAnimName = ''
                        BFBendyAttack = false
                        disableNotes(true,false)
                        BfStopAnim = false
                    end
                end
                fps = 0
            end
            if PiperHP == 0 then
                playSound('bendy/butcherSounds/Dead')
                PiperPlayAnim('Dead')
                PiperX = false
                PiperHP = -1
            end

            if StrikerHP == 0 then
                playSound('bendy/butcherSounds/Dead')
                StrikerPlayAnim('Dead')
                StrikerX = false
                StrikerHP = -1
            end

            if (getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getProperty('AttackButton.animation.curAnim.name') == 'Static' and BFBendyAttack == false) then

                if (keyPressed('left') or not keyPressed('right') and not keyPressed('left') and (PiperX == false and StrikerX == true))  then
                    objectPlayAnimation('AttackButton','NA',false)
                    setProperty('AttackButton.y',getProperty('AttackButton.y') - 35)
                    attackInk('striker')

                elseif (keyPressed('right') or not keyPressed('right') and not keyPressed('left') and (StrikerX == false and PiperX == true)) then
                    objectPlayAnimation('AttackButton','NA',false)
                    setProperty('AttackButton.y',getProperty('AttackButton.y') - 35)
                    attackInk('piper')
                end
            end

            if keyJustPressed('space') and Dodge1 == 2 or Dodge1 == 2 and botPlay then
                Dodge1 = 1
            end

            if keyJustPressed('space') and Dodge2 == 2 or Dodge2 == 2 and botPlay then
                Dodge2 = 1
            end
            --CameraEffect
            if getProperty('Piper.animation.curAnim.name') == 'Pre-Attack' or getProperty('Striker.animation.curAnim.name') == 'Pre-Attack' then

                doTweenZoom('AttackZoom', 'camGame', '0.8', '1.5', 'QuintOut')
                cameraSetTarget('bf')
                CameraEffect = true
            else
                if CameraEffect then
                    CameraEffect = false
                    doTweenZoom('AttackZoom', 'camGame', getProperty('defaultCamZoom'), '1.5', 'QuintOut')
                    if not mustHitSection and not gfSection then
                        cameraSetTarget('dad')
                    elseif gfSection then
                        cameraSetTarget('gf')
                    end
                end
            end
            --Attack Button Animation
            if getProperty('AttackButton.animation.curAnim.finished') == true then
                objectPlayAnimation('AttackButton','Static',true)
                setProperty('AttackButton.y',getProperty('AttackButton.y') + 35)
            end
        end
        if getProperty('Piper.animation.curAnim.finished') == true then
            local piperAnim = getProperty('Piper.animation.curAnim.name')
            if piperAnim == 'Dead' then
                removeLuaSprite('Piper', false)
                if (AttackEnable and PiperSpawn == -1) then
                    PiperSpawn = math.random(600,800)
                end
            elseif piperAnim == 'Attack' then
                PiperAttacking = false
                PiperPlayAnim('Idle')
            elseif piperAnim == 'Hurt' then
                PiperPlayAnim('Idle')
            elseif (piperAnim == 'Pre-Attack') then
                PiperAttack = 0
                PiperPlayAnim('Attack')
                if (Dodge1 == 2) then
                    hurtInk()

                elseif (Dodge1 == 1) then
                    dodgeInk()
                end
                Dodge1 = 0
            end
        end
        if getProperty('Striker.animation.curAnim.finished') == true then
            local strikerAnim = getProperty('Striker.animation.curAnim.name')
            if strikerAnim == 'Dead' then
                removeLuaSprite('Striker', false)
                if (AttackEnable and StrikerSpawn == -1) then
                    StrikerSpawn = math.random(600,800)
                end
            elseif strikerAnim == 'Attack' then
                StrikerAttacking = false
                StrikerPlayAnim('Idle')
     
            elseif strikerAnim == 'Hurt' then
                StrikerPlayAnim('Idle')
            elseif strikerAnim == 'Pre-Attack' then
                StrikerAttack = 0
                StrikerPlayAnim('Attack')
                if (Dodge2 == 2) then
                    hurtInk()
                elseif (Dodge2 == 1) then
                    dodgeInk()
                end
                Dodge2 = 0
            end
        end
    end
end
function goodNoteHit(id, noteData, noteType, isSustainNote)
    if foundedSong == true and noteType == 'BendySplashNote' then
        addInk()
    end
end
function enableAttack(enable)
    if AttackEnable ~= enable then
        StrikerAttacking = false
        StrikerAttack = 0

        PiperAttack = 0
        PiperAttacking = false
        if enable then
            PiperHP = 3
            PiperX = false
            PiperSpawn = 150
                
            StrikerSpawn = 100
            StrikerHP = 3
            StrikerX = false
        else
            PiperDie()
            StrikerDie()
        end
    end
    AttackEnable = enable
end
function onTimerCompleted(tag)
	if tag == 'SplashDestroy' and foundedSong == true then
		doTweenAlpha('byeSplash','SplashScreen',0,2,'sineIn')
	end
end
function onTweenCompleted(tag)
	if tag == 'byeSplash' then
		removeLuaSprite('SplashScreen',true)
		SplashDamage = 0
	end
end
function onStepHit()
    if foundedSong == true then
        if songName == 'Last-Reel' then
            if AttackEnable and curStep >= 1664 then
                enableAttack(false)
            end
        elseif songName == 'Despair' then
            if curStep == 1355 or curStep == 2064 or curStep == 3215 then
                enableAttack(true)
            elseif curStep == 1680 or curStep == 3023 or curStep == 3912 then
                enableAttack(false)
            end
        end
    end
end
function onBeatHit()
    if foundedSong and (curBeat % 2 == 0) then
        if PiperHP > 0 and getProperty('Piper.animation.curAnim.name') == 'Idle' then
            PiperPlayAnim('Idle')
        end
        if StrikerHP > 0 and getProperty('Striker.animation.curAnim.name') == 'Idle' then
            StrikerPlayAnim('Idle')
        end
    end
end
function addInk()
    SplashDamage = SplashDamage + 1
    debugPrint(SplashDamage)
    if SplashDamage >= 5 then
        setProperty('health',-1)
        return
    end
    playSound('bendy/inked')
    cancelTween('byeSplash')
    makeLuaSprite('SplashScreen','bendy/Damage0'..SplashDamage,0,0)
    scaleObject('SplashScreen',0.7,0.7)
    setObjectCamera('SplashScreen','hud')
    setProperty('SplashScreen.alpha',1)
    addLuaSprite('SplashScreen',true)
    runTimer('SplashDestroy',3)

end
function PiperPlayAnim(anim)
    local offsetX = 0
    local offsetY = 0
    if anim == 'Idle' then
        offsetY = 40
    elseif anim == 'Walking' then
        offsetX = 100
        offsetY = 40
    elseif anim == 'Attack' then
        offsetX = 350
        offsetY = 250
    elseif anim == 'Pre-Attack' then
        offsetX = 70
        offsetY = 90
    elseif anim == 'Hurt' then
        offsetX = 120
        offsetY  = 200
    elseif anim == 'Dead' then
        offsetX = 120
        offsetY = 180
    end
    objectPlayAnimation('Piper',anim,false)
    setProperty('Piper.offset.x',offsetX)
    setProperty('Piper.offset.y',offsetY)
end
function PiperDie()
    PiperPlayAnim('Dead')
    PiperHP = -1
    PiperAttack = 0
    PiperAttacking = false
    PiperSpawn = 0
end
function StrikerDie()
    StrikerPlayAnim('Dead')
    StrikerHP = -1
    StrikerAttack = 0
    StrikerAttacking = false
    StrikerSpawn = 0
end
function StrikerPlayAnim(anim)
    local offsetX = 0
    local offsetY = 0
    if anim == 'Idle' then
        offsetY = 40
    elseif anim == 'Walking' then
        offsetY = 40
    elseif anim == 'Attack' then
        offsetY = 40
    elseif anim == 'Pre-Attack' then
        offsetX = 20
        offsetY = 47
    elseif anim == 'Hurt' then
        offsetX = 150
        offsetY = 120
    elseif anim == 'Dead' then
        offsetX = 250
        offsetY = 120
    end
    objectPlayAnimation('Striker',anim,false)
    setProperty('Striker.offset.x',offsetX)
    setProperty('Striker.offset.y',offsetY)
end