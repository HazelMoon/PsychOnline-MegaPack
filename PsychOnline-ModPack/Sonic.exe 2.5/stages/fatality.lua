local curState = 0
function onCreate()
    makeAnimatedLuaSprite('fatalityBg1','fatal/launchbase',-1200,-900)
    addAnimationByPrefix('fatalityBg1','moviment','idle',14,true)
    setProperty('fatalityBg1.antialiasing',false)
    scaleObject('fatalityBg1',5.7,5.7)

    makeAnimatedLuaSprite('fatalityBg2','fatal/domain',-1200,-900)
    addAnimationByPrefix('fatalityBg2','moviment','idle',14,false)
    setProperty('fatalityBg2.antialiasing',false)
    scaleObject('fatalityBg2',5.7,5.7)

    makeAnimatedLuaSprite('fatalityBg2-5','fatal/domain2',-1200,-900)
    addAnimationByPrefix('fatalityBg2-5','moviment','idle',14,false)
    setProperty('fatalityBg2-5.antialiasing',false)
    scaleObject('fatalityBg2-5',5.7,5.7)

    makeAnimatedLuaSprite('fatalityBg3','fatal/truefatalstage',-1200,-900)
    addAnimationByPrefix('fatalityBg3','moviment','idle',14,true)
    setProperty('fatalityBg3.antialiasing',false)
    scaleObject('fatalityBg3',5.7,5.7)

    addLuaSprite('fatalityBg1')
end
function onBeatHit()
    objectPlayAnimation('fatalityBg2','moviment',false)
    objectPlayAnimation('fatalityBg2-5','moviment',false)
end
function changeState(state)
    if curState ~= state then
        setProperty('boyfriendGroup.x',1440)
        if curState == 0 then
            removeLuaSprite('fatalityBg1')
        elseif curState == 1 then
            removeLuaSprite('fatalityBg2')
            removeLuaSprite('fatalityBg2-5')
        elseif state ~= 2 then
            removeLuaSprite('fatalityBg3')
        end
        if state == 0 then
            addLuaSprite('fatalityBg1',false)
        elseif state == 1 then
            addLuaSprite('fatalityBg2',false)
            addLuaSprite('fatalityBg2-5',false)
        elseif state == 2 then
            addLuaSprite('fatalityBg3',false)
            setProperty('boyfriendGroup.x',820)
        end
        curState = state
    end
end
function onStepHit()
    if songName == 'Fatality' then
        if curStep >= 256 and curStep < 1984 and curState ~= 1 then
            changeState(1)
        elseif curStep >= 1984 and curState ~= 2 then
            changeState(2)
        end
    end

end