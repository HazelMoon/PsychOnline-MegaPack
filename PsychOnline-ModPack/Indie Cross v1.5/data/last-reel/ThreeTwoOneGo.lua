function onCreate()
    makeLuaSprite('ReadyBendy','bendy/ready',400,300)
    scaleObject('ReadyBendy',0.7,0.7)
    setObjectCamera('ReadyBendy','other')
    addLuaSprite('ReadyBendy',true)
    removeLuaSprite('ReadyBendy',false)


    makeLuaSprite('SetBendy','bendy/set',470,310)
    scaleObject('SetBendy',0.7,0.7)
    setObjectCamera('SetBendy','other')
    addLuaSprite('SetBendy',true)
    removeLuaSprite('SetBendy',false)

    makeLuaSprite('GoBendy','bendy/go',500,310)
    scaleObject('GoBendy',0.7,0.7)
    setObjectCamera('GoBendy','other')
    addLuaSprite('GoBendy',true)
    removeLuaSprite('GoBendy',false)
end

function onStepHit()
    if curStep == 1780 then
       addLuaSprite('ReadyBendy',true)
       setProperty('ReadyBendy.alpha',1)
    end
    if curStep == 1784 then
        addLuaSprite('SetBendy',true)
        setProperty('SetBendy.alpha',1)
    end
    if curStep == 1788 then
        addLuaSprite('GoBendy',true)
        setProperty('GoBendy.alpha',1)
    end
end
function onUpdate()
    setProperty('ReadyBendy.alpha',getProperty('ReadyBendy.alpha') - 0.05)
    setProperty('SetBendy.alpha',getProperty('SetBendy.alpha') - 0.05)
    setProperty('GoBendy.alpha',getProperty('GoBendy.alpha') - 0.05)
end
