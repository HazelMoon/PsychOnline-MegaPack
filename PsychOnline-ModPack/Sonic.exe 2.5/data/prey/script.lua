local curIntroState = 0
function onCreate()
    makeAnimatedLuaSprite('MechaIThink','characters/Furnace_sheet',-600,850)
    setProperty('MechaIThink.antialiasing',false)
    addAnimationByPrefix('MechaIThink','idle','Furnace idle',24,true)
    scaleObject('MechaIThink',6,6)


    makeLuaSprite('MechaIThink2','furnace_gotcha',2200,430)
    precacheImage('furnace_gotcha')
    setProperty('MechaIThink2.flipX',true)
    setProperty('MechaIThink2.antialiasing',false)
    scaleObject('MechaIThink2',6,6)


    setProperty('camHUD.alpha',0.01)
end
function onCreatePost()
    setProperty('boyfriend.alpha',0)
    setProperty('dad.alpha',0)
end
function onSongStart()
   if curStep > 250 then
        setProperty('camGame.alpha',1)
        setProperty('camHUD.alpha',1)
    end
    if curStep < 128 then
        setProperty('dad.x',-400)
    elseif curStep >= 128 then
        setProperty('boyfriend.alpha',1)
        setProperty('dad.alpha',1)
        if curBeat < 377 then
            setProperty('dad.x',100)
        elseif curBeat < 394 then
            setProperty('dad.x',-500)
            setProperty('dad.y',-200)
        else
            setProperty('dadGroup.x',1100)
            setProperty('dadGroup.y',-200)
        end
    end
end
function onBeatHit()
    if curStep < 128 and curBeat % 8 == 0 then
        curIntroState = 0
        setProperty('boyfriend.alpha',0.25 * math.floor(curBeat/8))
        triggerEvent('Add Camera Zoom','','0')
    end
end
function onStepHit()
    if curStep >= 128 and curIntroState == 0 then
        setProperty('camZooming',true)
        setProperty('boyfriend.alpha',1)
        curIntroState = 1
    elseif curStep == 143 then
        setProperty('camZooming',false)
    elseif curStep >= 248 and curIntroState < 2 then
        setProperty('dad.alpha',1)
        if curStep < 1546 then
            doTweenX('backMecha','dad',100,1,'quartOut')
        end
        curIntroState = 2
    elseif curIntroState < 3 and curStep >= 250 then
        curIntroState = 3
        doTweenAlpha('backCamHUD','camHUD',1,0.5,'quartOut')
    elseif curStep >= 1508 and curStep < 1540 and curIntroState < 4 then
        curIntroState = 4
        doTweenX('MechaX','dad',-500,2.5,'quartInOut')
        doTweenAngle('MechaAngle','dad',-180,3.5,'quartInOut')
    elseif curStep >= 1540 and curIntroState < 5 then
        curIntroState = 5
        setProperty('dadGroup.x',-550)
        setProperty('dadGroup.y',-200)
    elseif curStep >= 1546 and curStep < 1550 and curIntroState < 6 then
        curIntroState = 6
        setProperty('vocals.volume',1)
    elseif curStep >= 1575 and curIntroState < 7 then
        curIntroState = 7
        setProperty('dadGroup.x',1100)
        setProperty('dad.x',-500)
        doTweenX('EggHead','dad',1100,2,'quartOut')
    elseif curStep >= 1800 and curIntroState < 8 then
        if getProperty('boyfriend.curCharacter') == 'bf-running-sonic' then
            triggerEvent('Change Character','bf','bf-sonic-peelout')
        end
        curIntroState = 8

    elseif curStep >= 2448 and curStep < 3000 and curIntroState < 9 then
        curIntroState = 9
        addLuaSprite('MechaIThink',false)
        doTweenX('rightMecha','MechaIThink',2200,5,'linear')

    elseif curStep >= 3328 and curIntroState < 10 then
        curIntroState = 10
        doTweenX('EggHead','dad',-500,2.5,'quartIn')

    elseif curStep >= 3335 and curStep < 3340 and curIntroState < 11 then
        setProperty('vocals.volume',1)
        curIntroState = 11
    elseif curStep >= 3363 and curIntroState < 12 then
        curIntroState = 12
        addLuaSprite('MechaIThink2',true)
        setObjectOrder('MechaIThink2',getObjectOrder('boyfriendGroup'))
    elseif curStep >= 3367 and curIntroState < 13 then
        curIntroState = 13
        setProperty('camGame.visible',false)
        setProperty('camHUD.visible',false)
        --cameraFlash('other','FF0000',2,true)
        
    end
end
--[[function onEvent(name,v1,v2)
    if name == 'Change Character' then
        if v2 == 'starved-pixel' and v1 == 'dad' then
            setProperty('dad.x',-500)
            setProperty('dad.y',-200)
        end
    end
end]]--

function onUpdate(el)
    if curStep >= 3364 and getProperty('MechaIThink2.x') > getProperty('boyfriend.x') then
        setProperty('MechaIThink2.x',getProperty('MechaIThink2.x') - (5000 * el))
    end
end
function onTweenCompleted(tag)
    if tag == 'rightMecha' then
        removeLuaSprite('MechaIThink',true)
    end
end