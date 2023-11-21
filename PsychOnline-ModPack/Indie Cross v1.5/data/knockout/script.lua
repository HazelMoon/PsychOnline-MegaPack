local ending = false
local curHadoken = 0
function onCreate()
    makeAnimatedLuaSprite('MugMan','cup/Mugman Fucking dies',2000,1300)
    addAnimationByPrefix('MugMan','Walking','Mugman instance 1',24,false)
    addAnimationByPrefix('MugMan','Dead','MUGMANDEAD YES instance 1',24,false)

    makeAnimatedLuaSprite('KnockOutText','cup/knock',125,200)
    addAnimationByPrefix('KnockOutText','Knock','A KNOCKOUT!',28,false)
    setObjectCamera('KnockOutText','hud')
    scaleObject('KnockOutText',0.9,0.9)
end

function onUpdate()
    if getProperty('KnockOutText.animation.curAnim.finished') and not ending then
        doTweenAlpha('KnockBye','KnockOutText',0,1,'LinearOut')
        ending = true
    end
end
function onEvent(name)
    if name == 'CupheadAttack' then
        curHadoken = curHadoken + 1
    end
end
function onStepHit()
    if curStep == 1150 then
        addLuaSprite('MugMan',true)
    end
    if curStep == 1174 then
        objectPlayAnimation('MugMan','Dead',false)
        playSound('Cup/CupHurt')
        playSound('Cup/knockout')
        addLuaSprite('KnockOutText',true)
        objectPlayAnimation('BigShotCuphead'..curHadoken,'Hadolen',false)
        setProperty('BigShotCuphead'..curHadoken..'.x',getProperty('MugMan.x') - 200)
        setProperty('BigShotCuphead'..curHadoken..'.offset.y',500)
    end
end
function onTweenCompleted(tag)
    if tag == 'KnockBye' then
        removeLuaSprite('KnockOutText',true)
        close()
    end
end


