function onCreate()
    makeLuaSprite('cyclesSky','LordXStage/sky',-610,-0)
    addLuaSprite('cyclesSky')
    setProperty('cyclesSky.alpha',0.5)
    scaleObject('cyclesSky',0.5,0.5)
    setScrollFactor('cyclesSky',0.9,0.9)

    makeLuaSprite('cyclesMontain','LordXStage/hills1',-530,-0)
    scaleObject('cyclesMontain',0.55,0.55)
    addLuaSprite('cyclesMontain')
    setScrollFactor('cyclesMontain',0.95,0.95)

    makeLuaSprite('cyclesGround','LordXStage/floor',-530,10)
    scaleObject('cyclesGround',0.55,0.55)
    addLuaSprite('cyclesGround')

    makeAnimatedLuaSprite('cyclesNotKnux','LordXStage/NotKnuckles_Assets',100,50)
    addAnimationByPrefix('cyclesNotKnux','hands','Notknuckles',24,true)
    scaleObject('cyclesNotKnux',0.55,0.55)
    addLuaSprite('cyclesNotKnux')
    if not lowQuality then
        makeAnimatedLuaSprite('cyclesTree2','LordXStage/WeirdAssFlower_Assets',-450,220)
        addAnimationByPrefix('cyclesTree2','tree','flower',24,true)
        scaleObject('cyclesTree2',0.8,0.8)
        addLuaSprite('cyclesTree2')

        makeLuaSprite('cyclesPlant','LordXStage/smallflower',-735,-40)
        scaleObject('cyclesPlant',0.6,0.6)
        addLuaSprite('cyclesPlant')

        makeLuaSprite('cyclesPlant2','LordXStage/smallflower2',-735,-40)
        scaleObject('cyclesPlant2',0.6,0.6)
        addLuaSprite('cyclesPlant2')

        
        makeLuaSprite('cyclesTree1','LordXStage/tree',-550,-200)
        scaleObject('cyclesTree1',0.65,0.65)
        addLuaSprite('cyclesTree1')
    end
end
function onStepHit()
    if songName == 'fate' then
        if curStep == 2016 then
            setProperty('cyclesSky.visible',false)
            setProperty('cyclesMontain.visible',false)
            setProperty('cyclesGround.visible',false)
            setProperty('cyclesNotKnux.visible',false)
            setProperty('dad.visible',false)
            if not lowQuality then
                for plants = 1,2 do
                    setProperty('cyclesPlant'..plants..'.visible',false)
                    setProperty('cyclesTree'..plants..'.visible',false)
                end
            end
        end
        if curStep == 2448 then
            setProperty('cyclesSky.visible',true)
            setProperty('cyclesMontain.visible',true)
            setProperty('cyclesGround.visible',true)
            setProperty('cyclesNotKnux.visible',true)
            setProperty('dad.visible',true)
            if not lowQuality then
                for plants = 1,2 do
                    setProperty('cyclesPlant'..plants..'.visible',true)
                    setProperty('cyclesTree'..plants..'.visible',true)
                end
            end
        end
    end
end