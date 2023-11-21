local RandomSound = 0
local AttackEnable = true


local stopDadAnim = false
local stopBfAnim = false

local dadOrder = 0

function onCreate()
   makeAnimatedLuaSprite('AttackButton','IC_Buttons',-6,245)
   scaleObject('AttackButton',0.5,0.5)
   addAnimationByPrefix('AttackButton','normal','Attack instance 1',24,true)
   addAnimationByPrefix('AttackButton','NA','AttackNA instance 1',24,false)
   setObjectCamera('AttackButton','hud')
   addLuaSprite('AttackButton',false)
   setProperty('AttackButton.alpha',0.5)
   
   setProperty('AttackButton.offset.x',0)
   setProperty('AttackButton.offset.y',0)
end
function disableNotes(mustPress,disable)
    for notesLength = 0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes', notesLength, 'mustPress') == mustPress then
            setPropertyFromGroup('notes', notesLength, 'noAnimation', disable)
        end
    end
end
function attackSans()
    disableNotes(true,true)
    characterPlayAnim('boyfriend','attack',false)
    setProperty('boyfriend.specialAnim',true)
    stopBfAnim = true
    playSound('IC/Throw'..RandomSound)
    runTimer('SansDodge',0.3)
    animAttackButton('NA')
    AttackEnable = false
end
function onUpdate()
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SHIFT') and AttackEnable == true then
        attackSans()
    end
    if stopBfAnim == true then
        local bfAnim = getProperty('boyfriend.animation.curAnim.name')
        if getProperty('boyfriend.animation.curAnim.finished') and bfAnim == 'attack' or bfAnim ~= 'attack' then
            disableNotes(true,false)
            stopBfAnim = false
        end
    end
    if stopDadAnim == true then
        local dadAnim = getProperty('dad.animation.curAnim.name')
        if getProperty('dad.animation.curAnim.finished') and dadAnim  == 'dodge' or dadAnim ~= 'dodge' then
            disableNotes(false,false)
            DadStopAnim = false
            setObjectOrder('dadGroup',dadOrder)
        end
    end

    if getProperty('AttackButton.animation.curAnim.finished') == true and getProperty('AttackButton.animation.curAnim.name') == 'NA' then
        animAttackButton('normal')
        AttackEnable = true
    end
end

function onTimerCompleted(tag)
    if tag == 'eyeSound' then
        playSound('sans/eye')
    
    elseif tag == 'SansDodge' then
        disableNotes(false,true)
        dadOrder = getObjectOrder('dadGroup')
        setProperty('health',getProperty('health') + 0.25)
        playSound('sans/dodge')
        stopDadAnim = true
        if getObjectOrder('dadGroup') < getObjectOrder('boyfriendGroup') then
            setObjectOrder('dadGroup',getObjectOrder('boyfriendGroup') + 1)
        end
        characterPlayAnim('dad','dodge',true)
        setProperty('dad.specialAnim',true)
        cameraShake('game','0.01','0.5')
    end
end
function onCountdownTick(counter)
    if counter == 1 and not seenCutscene and isStoryMode then
        attackSans()
    end
end
function animAttackButton(anim)
    local offsetX = 0
    local offsetY = 0
    if anim == 'NA' then
        offsetX = -2
        offsetY = 14
    end
    objectPlayAnimation('AttackButton',anim,false)
    setProperty('AttackButton.offset.x',offsetX)
    setProperty('AttackButton.offset.y',offsetY)
end
function onStepHit()
    if curStep >=  379 and curStep < 896 or curStep >= 1146 and curStep < 1408 then
        setProperty('AttackButton.animation.curAnim.frameRate',0)
        AttackEnable = false
        doTweenAlpha('ByeAttackButton','AttackButton',0,1,'linear')
    elseif curStep ==  896 or curStep == 1408 then
        AttackEnable = true
        animAttackButton('normal')
        doTweenAlpha('HeyAttackButton','AttackButton',0.5,1,'linear')
    end
end