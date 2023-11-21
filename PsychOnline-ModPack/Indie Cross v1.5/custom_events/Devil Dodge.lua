local InstaKillDevil = false
function onCreate()
    DodgeDevil = 0;
    DodgeDevilCreated = 0
    SmallDevilSpeedX = 0

    makeAnimatedLuaSprite('SmallDevil','cup/BonusSongs/That Annoying Bitch',0,getProperty('boyfriend.y') - 50)
    addAnimationByPrefix('SmallDevil','Running','BoiRun instance 1',24,true)
end

function onEvent(name,value1,value2)

    if name == 'Devil Dodge' then
        addLuaSprite('SmallDevil',true)
        if mustHitSection then
            setProperty('SmallDevil.x',screenWidth + getProperty('SmallDevil.width') * 2.5)
            setProperty('SmallDevil.flipX',true)
            SmallDevilSpeedX = -30
        else
            setProperty('SmallDevil.x',0 - getProperty('SmallDevil.width') * 2)
            setProperty('SmallDevil.flipX',false)
            SmallDevilSpeedX = 30
        end
        DodgeDevil = 2
        if value2 ~= '' then
            InstaKillDevil = true
        else
            InstaKillDevil = false
        end
    end
end

function onUpdate(elapsed)

    
    setProperty('SmallDevil.x',getProperty('SmallDevil.x') + SmallDevilSpeedX)



        if getProperty('SmallDevil.x') > getProperty('boyfriend.x') - getProperty('boyfriend.width')/4 and getProperty('SmallDevil.x') < getProperty('boyfriend.x') + getProperty('boyfriend.width') /5 then

            if DodgeDevil == 2 and not botPlay then

                if DodgeDevilCreated == 0 then
                    if InstaKillDevil then
                        setProperty('health',0)
                    else
                        setProperty('health',getProperty('health') - 1)
                    end
                    cameraShake('game',0.035,0.15)
                    playSound('cup/CupHurt')
                    DodgeDevil = 0
                    characterPlayAnim('boyfriend','hurt',true)
                    setProperty('boyfriend.specialAnim',true)
                else
                    DodgeDevil = 0
                end
            end
        end
    

    if keyJustPressed('space') and DodgeDevilCreated == 0 or DodgeButtonPress and DodgeDevilCreated == 0 or getProperty('SmallDevil.x') > getProperty('boyfriend.x') - getProperty('boyfriend.width')/4 and getProperty('SmallDevil.x') < getProperty('boyfriend.x') + getProperty('boyfriend.width') /5 and botPlay and DodgeDevilCreated == 0 then
     DodgeDevilCreated = 1
     characterPlayAnim('boyfriend','dodge',false)
     setProperty('boyfriend.specialAnim',true)
    end

    if DodgeDevilCreated == 1 then
        for i = 0,getProperty('notes.length')-1 do
            if getPropertyFromGroup('notes', i, 'mustPress') == true then
                setPropertyFromGroup('notes', i, 'noAnimation', true)
            end
        end
    end

    if getProperty('boyfriend.animation.curAnim.finished') and getProperty('boyfriend.animation.curAnim.name') == 'dodge' and DodgeDevilCreated == 1 or getProperty('boyfriend.animation.curAnim.name') ~= 'dodge' and DodgeDevilCreated == 1 then
        for i = 0,getProperty('notes.length')-1 do
            if getPropertyFromGroup('notes', i, 'mustPress') == true then
                setPropertyFromGroup('notes', i, 'noAnimation', false)
            end
        end
        DodgeDevilCreated = 0
    end

    if getProperty('SmallDevil.x') > screenWidth + getProperty('SmallDevil.width') * 2 and SmallDevilSpeedX > 0 or getProperty('SmallDevil.x') < 0 - getProperty('SmallDevil.width') * 2 and SmallDevilSpeedX < 0 then
        removeLuaSprite('SmallDevil',false)
        SmallDevilSpeedX = 0
    end
end



