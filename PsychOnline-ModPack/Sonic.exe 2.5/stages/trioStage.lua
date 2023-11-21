local stageArray = {
    {'glitch',-600,-500,false,1,1},
    {'BackBush',-600,-400,false,1,1},
    {'TTTrees',-600,-500,false,0.8,0.8},
    {'TopBushes',-600,-400,false,1,1},
    {'FGTree1',-800,-500,true,1.1,1},
    {'FGTree2',-350,-500,true,1.1,1}
}
local xenoArray = {
    {'glitch',-390,-400,false,0,1,'TitleMenuSSBG instance 1',24,true},
    {'BackTrees',-600,-500,false,0.8,0.8},{'Grass',-600,-600,false,1,1},
    {'FGTree1',-800,-500,true,1.1,1},
    {'FGTree2',-350,-500,true,1.1,1}
}
local curState = 0
function onCreate()
    for stageLength = 1,#stageArray do
        makeLuaSprite('Trio'..stageArray[stageLength][1],'Phase3/Normal/'..stageArray[stageLength][1],stageArray[stageLength][2],stageArray[stageLength][3])
        setScrollFactor('Trio'..stageArray[stageLength][1],stageArray[stageLength][5],stageArray[stageLength][6])
        addLuaSprite('Trio'..stageArray[stageLength][1],stageArray[stageLength][4])
    end
    --[[makeLuaSprite('TrioBG','Phase3/Normal/BackBush',-600,-500)
    scaleObject('TrioBG',1.2,1.2)
    makeLuaSprite('TrioTTTrees','Phase3/Normal/TTTrees',-600,-500)

    scaleObject('TrioTTTrees',1.2,1.2)
    makeLuaSprite('TrioTree','Phase3/Normal/FGTree1',-720,-500)

    makeLuaSprite('TrioTree2','Phase3/Normal/FGTree2',-400,-500)
    
    makeLuaSprite('TrioGround','Phase3/Normal/TopBushes',-600,-600)
    scaleObject('TrioGround',1.2,1.2)
    setScrollFactor('TrioBack',0.9,0.9)
    setScrollFactor('TrioTree',1.1,1)
    setScrollFactor('TrioTTTrees',0.8,0.8)
    setScrollFactor('TrioTree2',1.1,1)
    ]]--
 
    if songName == 'triple-trouble' then
        for xenoLength = 1,#xenoArray do
            if xenoArray[xenoLength][7] ~= nil then
                makeAnimatedLuaSprite('Xeno'..xenoArray[xenoLength][1],'Phase3/xeno/'..xenoArray[xenoLength][1],xenoArray[xenoLength][2],xenoArray[xenoLength][3])
                setScrollFactor('Xeno'..xenoArray[xenoLength][1],xenoArray[xenoLength][5],xenoArray[xenoLength][6])
                scaleObject('Xeno'..xenoArray[xenoLength][1],1.2,1.2)
                addAnimationByPrefix('Xeno'..xenoArray[xenoLength][1],'idle',xenoArray[xenoLength][7],xenoArray[xenoLength][8],xenoArray[xenoLength][9])
            else
                makeLuaSprite('Xeno'..xenoArray[xenoLength][1],'Phase3/xeno/'..xenoArray[xenoLength][1],xenoArray[xenoLength][2],xenoArray[xenoLength][3])
                setScrollFactor('Xeno'..xenoArray[xenoLength][1],xenoArray[xenoLength][5],xenoArray[xenoLength][6])
                scaleObject('Xeno'..xenoArray[xenoLength][1],1.2,1.2)
            end
            precacheImage('Phase3/xeno/'..xenoArray[xenoLength][1])
        end
        scaleObject('Xenoglitch',4.7,4.7)
        setProperty('Xenoglitch.antialiasing',false)
    end
end
function changeState(state) --0 = normal, 1 = xeno, 2 = xeno flipped
    if curState ~= state then
        if curState == 0 then
            for stageLength = 1,#stageArray do
                removeLuaSprite('Trio'..stageArray[stageLength][1],false)
            end
        elseif curState == 1 or curState == 2 then
            for xenoLength = 1,#xenoArray do
                removeLuaSprite('Xeno'..xenoArray[xenoLength][1],false)
            end
        end
        if state == 0 then
            setProperty('defaultCamZoom',0.7)
            for stageLength = 1,#stageArray do
                addLuaSprite('Trio'..stageArray[stageLength][1],stageArray[stageLength][4])
            end
        elseif state == 1 or state == 2 then
            setProperty('defaultCamZoom',0.9)
            for xenoLength = 1,#xenoArray do
                addLuaSprite('Xeno'..xenoArray[xenoLength][1],xenoArray[xenoLength][4])
            end
            setProperty('XenoGrass.flipX',false)
            if state == 2 then
                setProperty('XenoGrass.flipX',true)
            end
        end
        curState = state
    end
end
function onStepHit()
    if songName == 'triple-trouble' then
        if curStep >= 1040 and curStep < 1296 or curStep >= 4112 then
            changeState(1)
        elseif curStep >= 1296 and curStep < 2320 or curStep >= 2832 and curStep < 4112 then
            changeState(0)
        elseif curStep >= 2320 and curStep < 2832 then
            changeState(2)
        end
    end
end