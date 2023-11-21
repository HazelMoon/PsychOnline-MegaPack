function onCreate()
    makeAnimatedLuaSprite('NM-Bendy-Jumpscare','NightmareSongs/NightmareJumpscares03',0,-490)
    setProperty('NM-Bendy-Jumpscare.alpha',0)
    addAnimationByPrefix('NM-Bendy-Jumpscare','Boo','Emmi instance',24,false)
    scaleObject('NM-Bendy-Jumpscare',0.7,0.7)
    setObjectCamera('NM-Bendy-Jumpscare','other')
    addLuaSprite('NM-Bendy-Jumpscare',true)

    makeAnimatedLuaSprite('Static','NightmareSongs/static',0,0)
    scaleObject('Static',1.2,1.2)
    addAnimationByPrefix('Static','StaticAnim','static',30,true)
    setObjectCamera('Static','other')
end

function onUpdate()
    if curStep == 3965 then
        characterPlayAnim('dad','Bye',true)
        setProperty('dad.specialAnim',true)
    end
    if curStep > 3965 then 
        if getProperty('dad.animation.curAnim.name') == 'Bye' and getProperty('dad.animation.curAnim.finished') == true then
            setProperty('dad.visible',false)
        end
    end
    if curStep > 3980 and getProperty('NM-Bendy-Jumpscare.animation.curAnim.finished') == true then
        removeLuaSprite('NM-Bendy-Jumpscare',true)
        addLuaSprite('Static',true)
    end
end

function onStepHit()
    if curStep == 3980 then
        playSound('bendy/BendyGameOver')
        setProperty('NM-Bendy-Jumpscare.alpha',1)
        objectPlayAnimation('NM-Bendy-Jumpscare','Boo',true)
    end
end