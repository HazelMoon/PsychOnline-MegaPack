function onCreate()
    addLuaScript('custom_events/TooSlowFlashinShit')
end
function onCreatePost()
    makeLuaSprite('SonicJumpscare0','simplejump',0,0)
    setObjectCamera('SonicJumpscare0','other')
    scaleObject('SonicJumpscare0',0.7,0.7)

    makeLuaSprite('SonicJumpscare1','JUMPSCARES/Tails',0,0)
    setObjectCamera('SonicJumpscare1','other')
    makeLuaSprite('SonicJumpscare2','JUMPSCARES/Knuckles',0,0)
    setObjectCamera('SonicJumpscare2','other')
    makeLuaSprite('SonicJumpscare3','JUMPSCARES/Eggman',0,0)
    setObjectCamera('SonicJumpscare3','other')
end
function onEvent(name,v1)
    if name == 'SonicJumpscare' then
        addLuaSprite('SonicJumpscare'..v1,true)
        triggerEvent('TooSlowFlashinShit','','')
        cameraShake('game',0.04,0.6)
        setProperty('SonicJumpscare'..v1..'.alpha',1)
        runTimer('destroyJumpscare'..v1,0.1)
        if tonumber(v1) == 0 then
            playSound('sppok')
        elseif tonumber(v1) == 1 then
            playSound('P3Jumps/TailsScreamLOL',0.1)
        elseif tonumber(v1) == 2 then
            playSound('P3Jumps/KnucklesScreamLOL',0.15)
        elseif tonumber(v1) == 3 then
            playSound('P3Jumps/EggmanScreamLOL',0.1)
        end
        if tonumber(v1) ~= 0 then
            doTweenX('HelloJumpscareX'..v1,'SonicJumpscare'..v1..'.scale',1.1,0.1,'linear')
            doTweenY('HelloJumpscareY'..v1,'SonicJumpscare'..v1..'.scale',1.1,0.1,'linear')
        end
    end
end
function onTimerCompleted(tag)
    if string.find(tag,'destroyJumpscare',0,true) ~= nil and tag ~= 'destroyJumpscare0' then
        for JUMPSCARES = 1,3 do
            if tag == 'destroyJumpscare'..JUMPSCARES then
                doTweenAlpha('ByeJumpscareAlpha'..JUMPSCARES,'SonicJumpscare'..JUMPSCARES,0,0.1,'linear')
                doTweenX('ByeJumpscareX'..JUMPSCARES,'SonicJumpscare'..JUMPSCARES..'.scale',1,0.1,'linear')
                doTweenY('ByeJumpscareY'..JUMPSCARES,'SonicJumpscare'..JUMPSCARES..'.scale',1,0.1,'linear')
            end
        end
    elseif tag == 'destroyJumpscare0' then
        removeLuaSprite('SonicJumpscare0',false)
    end
end
function onTweenCompleted(tag)
    if string.find(tag,'ByeJumpscareAlpha',0,true) ~= nil then
        for JUMPSCARES = 1,3 do
            if tag == 'ByeJumpscareAlpha'..JUMPSCARES then
                removeLuaSprite('SonicJumpscare'..JUMPSCARES,false)
            end
        end
    end
end