local attack = 0
local AttackEnable = true
local BfStopAnim = false
local DadStopAnim = false
local dadOrder = 0
function onCreatePost()
    makeAnimatedLuaSprite('AttackButton','IC_Buttons',-6,245)
    scaleObject('AttackButton',0.5,0.5)
    addAnimationByPrefix('AttackButton','normal','Attack instance 1',0,true)
    addAnimationByPrefix('AttackButton','NA','AttackNA instance 1',24,false)
    setObjectCamera('AttackButton','hud')
    setProperty('AttackButton.offset.x',0)
    setProperty('AttackButton.offset.y',0)
    setProperty('AttackButton.alpha',0.5)
    addLuaSprite('AttackButton',false)

    precacheImage('sans/battle')
    makeLuaSprite('SansBattle','sans/battle',0,-800)
    addCharacterToList('UT-bf-chara','boyfriend')
    addCharacterToList('UT-sans','dad')
end

local allowEndSong = false
function onEndSong()
    if not allowEndSong and not seenCutscene and isStoryMode then
        if attack < 3 then
            loadSong('final-stretch',difficulty)
            return Function_Stop;
        elseif attack >= 3 then
            loadSong('burning-in-hell',difficulty)
            return Function_Stop;
        end
    end
end
function disableNotes(disable,mustPress)
    for notesLength = 0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes', notesLength, 'mustPress') == mustPress then
            setPropertyFromGroup('notes', notesLength, 'noAnimation', disable)
        end
    end
end
function onUpdate()
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SHIFT') and AttackEnable == true then
        BfStopAnim = true
        disableNotes(true,true)
        characterPlayAnim('boyfriend','attack',true)
        setProperty('boyfriend.specialAnim',true)
        playSound('IC/Throw'..(math.random(1,3)))
        runTimer('SansDodge',0.3)
        objectPlayAnimation('AttackButton','NA',false)
        setProperty('AttackButton.offset.x',-2)
        setProperty('AttackButton.offset.y',14)
        attack = attack + 1
        AttackEnable = false
    end
    if BfStopAnim == true then
        disableNotes(true,true)
        if getProperty('boyfriend.animation.curAnim.finished') and getProperty('boyfriend.animation.curAnim.name') == 'attack' or getProperty('boyfriend.animation.curAnim.name') ~= 'attack' then
            disableNotes(false,true)
            BfStopAnim = false
        end
    end
    if DadStopAnim == true then
        disableNotes(true,false)
        if getProperty('dad.animation.curAnim.finished') and getProperty('dad.animation.curAnim.name') == 'dodge' or getProperty('dad.animation.curAnim.name') ~= 'dodge' then
            disableNotes(false,false)
            setObjectOrder('dadGroup',dadOrder)
            DadStopAnim = false
        end
    end

    if getProperty('AttackButton.animation.curAnim.finished') == true and getProperty('AttackButton.animation.curAnim.name') == 'NA' and curStep < 781 then
        objectPlayAnimation('AttackButton','normal',true)
        setProperty('AttackButton.offset.x',0)
        setProperty('AttackButton.offset.y',0)
        AttackEnable = true
    end
    if attack < 3 then
        if curStep >= 782 then
            for noteLength = 0,getProperty('notes.length')-1 do
                if getPropertyFromGroup('notes',noteLength,'noteType') == 'BlueBoneNote' then
                    removeFromGroup('notes',noteLength,true)
                elseif getPropertyFromGroup('notes',noteLength,'noteType') == 'OrangeBoneNote' then
                    setPropertyFromGroup('notes',noteLength,'noteType','')
                    setPropertyFromGroup('notes',noteLength,'texture','')
                end
            end
            AttackEnable = false
        end
    else
        if curStep >= 776 and curStep < 782 then
            cameraSetTarget('dad')
        end
    end
end
function onStepHit()
    if attack >= 3 then
        if curStep == 776 then
            triggerEvent('Play Animation','snap','dad')
            runTimer('eyeSound',0.1)
        elseif curStep == 782 then
            removeLuaSprite('SansBG',true)
            addLuaSprite('SansBattle',false)
            triggerEvent('Change Character','dad','UT-sans')
            triggerEvent('Change Character','bf','UT-bf')
            triggerEvent('Add Camera Zoom',0.35,0.35)
            setProperty('defaultCamZoom',0.4)
            setProperty('dadGroup.x',getProperty('dadGroup.x') + 520)
            setProperty('dadGroup.y',getProperty('dadGroup.y') - 600)
            setProperty('boyfriendGroup.x',getProperty('boyfriendGroup.x') - 480)
            setProperty('boyfriendGroup.y',getProperty('boyfriendGroup.y') - 40)
            removeLuaSprite('AttackButton',true)
            removeLuaSprite('DodgeButton',true)
        end
    end
    if curStep > 781 and AttackEnable == true then
        AttackEnable = false
        doTweenAlpha('ByeAttackButton','AttackButton',0,1,'linear')
        doTweenAlpha('ByeDodgeButton','DodgeButton',0,1,'linear')
    end
end
function onTimerCompleted(tag)
    if tag == 'eyeSound' then
        playSound('sans/eye')
    elseif tag == 'SansDodge' then
        dadOrder = getObjectOrder('dadGroup')
        setProperty('health',getProperty('health') + 0.25)
        playSound('sans/dodge')
        DadStopAnim = true
        disableNotes(false,true)
        setObjectOrder('dadGroup',getObjectOrder('boyfriendGroup') + 1)
        characterPlayAnim('dad','dodge',true)
        setProperty('dad.specialAnim',true)
        cameraShake('game','0.01','0.5')
    end
end