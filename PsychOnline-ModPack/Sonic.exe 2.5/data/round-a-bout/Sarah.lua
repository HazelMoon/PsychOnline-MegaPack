local curAnim = ''
function onCreate()
    makeAnimatedLuaSprite('SarahCharacter','characters/Sarah',-80,-280)
    setProperty('SarahCharacter.alpha',0.001)
    scaleObject('SarahCharacter',1.2,1.2)
    addAnimationByPrefix('SarahCharacter','idle','Sarah_IDLE',24,false)
    addAnimationByPrefix('SarahCharacter','singLEFT','Sarah_LEFT',24,false)
    addAnimationByPrefix('SarahCharacter','singDOWN','Sarah_DOWN',24,false)
    addAnimationByPrefix('SarahCharacter','singUP','Sarah_UP',24,false)
    addAnimationByPrefix('SarahCharacter','singRIGHT','Sarah_RIGHT',24,false)
    addLuaSprite('SarahCharacter',false)
    SaraPlayAnim('idle',true)
end

function opponentNoteHit(note,dir,type,sus)
    SaraPlayAnim(getProperty('singAnimations['..dir..']'),true)
end
function onUpdate()
    if getProperty('dad.animation.curAnim.name') == 'idle' and curAnim ~= 'idle' then
        SaraPlayAnim('idle',true)
    end
end
function onStepHit()
    if curStep == 764 then
        doTweenAlpha('helloSarah','SarahCharacter',0.7,0.5,'linear')
    end
end
function SaraPlayAnim(anim,force)
    local offsetX = 0
    local offsetY = 0
    if anim == 'idle' then
        offsetX = 190
        offsetY = -100
    elseif anim == 'singLEFT' then
        offsetX = -60
        offsetY = -195
    elseif anim == 'singDOWN' then
        offsetX = -40
        offsetY = -118
    elseif anim == 'singUP' then
        offsetX = -208
        offsetY = -70
    elseif anim == 'singRIGHT' then
        offsetX = -40
        offsetY = -214
    end
    setProperty('SarahCharacter.offset.x',offsetX)
    setProperty('SarahCharacter.offset.y',offsetY)
    objectPlayAnimation('SarahCharacter',anim,force)
    curAnim = anim
end
function onBeatHit()
    if curBeat % 2 == 0 then
        if curAnim == 'idle' then
            SaraPlayAnim('idle',false)
        end
    end
end
