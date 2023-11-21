local changedImage = false
--local disableImage = false

local textCreated = false
local circleCreated = false

local counterPos = {{300,230},{300,230},{300,230},{300,230}} -- first value: Three image pos X and Y. Second value: Ready? image x and y. Third value: Set image x and y. Fourth value: GO! image x and y.
local counterScale = {{1,1},{1,1},{1,1},{1,1}}


--[[
    Introducions:
    To change value in the counterPos or counterScale, just need to know that:

        tablePos: 1 = Three
        tablePos: 2 = Two/Ready?
        tablePos: 3 = One/Set?
        tablePos: 4 = Go!

    like this:
    changeCountPos(changeAll:bollean,posX:number,posY:number,tablePos)
    changeCountScale(changeAll:bollean,scaleX:number,scaleY:number,tablePos)

    changeALl = change all values in the array.

    if you want to disable the count down song, just put "-silence" in the first function in changeCountDown(), like that:
        changeCountDown('-silence','',false,false,false,false,1,1,0,0)
--]]
function onCreate()
    local songNameCount = string.lower(songName)
    local circleName = songNameCount
    local circleSongName = songNameCount
    local type = nil
    if songNameCount  == 'cycles-encore' or songNameCount == 'cycles-old' then
        circleName = 'cycles'
        circleSongName = 'cycles'

    elseif songNameCount == 'fate' then
        circleName = 'cycles'
        circleSongName = 'fate'

    elseif songNameCount  == 'execution' then
        circleName = 'execution'
        circleSongName = 'execution'

    elseif songNameCount  == 'too-slow-encore' then
        circleName = 'too-slow'
        circleSongName = 'too-slow'

    elseif songNameCount  == 'endless-encore' then
        circleName = 'endless'
        circleSongName = 'endless'

    elseif songNameCount == 'endeavors' then
        circleName = 'endless'
        
    elseif songNameCount == 'hollow' then
        circleName = 'endless'

    elseif songNameCount == 'you-cant-run-encore' or songNameCount == 'you-cant-run-encore-new' then
        circleName = 'you-cant-run'
        circleSongName = 'you-cant-run'

    elseif songNameCount == 'black-sun' or songName == 'manual-blast' then
        circleName = 'faker'
        circleSongName = 'faker'

    elseif string.find(songNameCount,'fatality',0,true) ~= nil or songNameCount == 'unresponsive' then
        changeCounterPos(true,450,250,1)
        changeCounterScale(true,3,3,1)
        changeCountDown('-Fatal','StartScreens/fatal_',true,true,true,false,false)
        return
    elseif songNameCount == 'sunshine' or songNameCount == 'sunshine-encore' then
        changeCounterPos(false,260,200,2)
        changeCounterPos(false,250,90,4)
        changeCounterScale(false,1.3,1.3,4)
        changeCountDown('-Tails','StartScreens/tails_',true,true,true,false,true)
        return
    elseif string.match(songNameCount,'soulless') == 'soulless' then
        changeCountDown('-silence','',true,false,true,false,true)
        return
    elseif string.match(songNameCount,'milk') == 'milk' then
        circleName = 'milk'
        circleSongName = nil
        type = 'milk'
    elseif songNameCount == 'forced' then
        circleName = 'mania'
    end
    startSonicCount(circleName,circleSongName,type)
end
function startSonicCount(name,text,style)
    setProperty('introSoundsSuffix','-silence')
    --runTimer('circleIntroTween',stepCrochet/12)
    --runTimer('blackIntroBye',stepCrochet/12)
    makeLuaSprite('blackScreenSonicCount','',0,0)
    setObjectCamera('blackScreenSonicCount','other')
    makeGraphic('blackScreenSonicCount',screenWidth,screenHeight,'000000')
    addLuaSprite('blackScreenSonicCount',false)
    if name ~= nil then
        name = string.gsub(name,' ','-')--This will replace the space with a trace
        makeLuaSprite('startCircle','StartScreens/Circle-'..name,800,00)
        setObjectCamera('startCircle','other')
        addLuaSprite('startCircle',true)
        circleCreated = true
    end
    if text ~= nil then
        text = string.gsub(text,' ','-')
        makeLuaSprite('startText','StartScreens/Text-'..text,-800,00)
        setObjectCamera('startText','other')
        addLuaSprite('startText',true)
        textCreated = true
    end
    if style == 'milk' then
        runTimer('tweenMajin',0.2)
        setProperty('startCircle.x',0)
        setProperty('startCircle.scale.x',0)
        setProperty('startText.x',0)
        setProperty('startText.scale.x',0)
    else
        runTimer('circleTween',0.1)
    end
    runTimer('byeCircles',stepCrochet/62)
end
function onTimerCompleted(tag)
    if tag == 'circleTween' then
        if circleCreated == true then
            doTweenX('circleX','startCircle',0,0.6,'quartOut')
        end
        if textCreated == true then
            doTweenX('textX','startText',0,0.6,'quartOut')
        end
        --doTweenX('circleX','startCircle',0,0.7,'linear')
        --doTweenX('textX','startText',0,0.7,'linear')
    elseif tag == 'tweenMajin' then
        if circleCreated == true then
            doTweenX('circleX','startCircle.scale',1,0.4,'bounceOut')
        end
        if textCreated == true then
            doTweenX('textX','startText.scale',1,0.4,'bounceOut')
        end
        playSound('flatBONK')
        --doTweenX('circleX','startCircle',0,0.7,'linear')
        --doTweenX('textX','startText',0,0.7,'linear')
    end
    if tag == 'byeCircles' then
        --doTweenX('circleX','startCircle',-900,0.7,'quartOut')
        --doTweenX('textX','startText',1200,0.7,'quartOut')
        doTweenAlpha('blackScreenDestroy','blackScreenSonicCount',0,0.5,'linear')
        runTimer('tweenCircleDestroy',0.5)
    end
    if tag == 'tweenCircleDestroy' then
        doTweenAlpha('circleDestroy','startCircle',0,0.5,'linear')
        doTweenAlpha('textDestroy','startText',0,0.5,'linear')
    end
end
function onCountdownTick(counter)
    if counter > 0 then
        if counter == 1 then
            setProperty('countdownReady.visible',false)
        elseif counter == 2 then
            setProperty('countdownSet.visible',false)

        elseif counter == 3 then
            setProperty('countdownGo.visible',false)
        end
        if changedImage then
            local imageID = 3 - counter
            if not luaSpriteExists('customIntro3') and imageID == 3 then
                return
            end
            local posX = counterPos[imageID + 1][1] - (screenWidth - getProperty('camGame.width'))/2
            setProperty('customIntro'..imageID..'.x',posX)
            addLuaSprite('customIntro'..imageID,true)
            doTweenAlpha('byeCustomIntro'..imageID,'customIntro'..imageID,0,stepCrochet/ 200,'linear')
            if counter > 1 then
                removeLuaSprite('customIntro'..(imageID + 1),true)
            end
        end
        --if disableImage then
        --end
    end
end
function changeCountDown(songCountName,image,changeSong,changeImage,disableCountDownImage,haveThreeImage,antialiasing)
    --disableImage = disableCountDownImage
    if changeSong == true then
        setProperty('introSoundsSuffix',songCountName)
    end
    if changeImage == true then
        changedImage = true
        for countDown = 1,3 do
            if not haveThreeImage and countDown >= 3 then
                break
            end
            local posX = counterPos[countDown][1] - (screenWidth - getProperty('camGame.width'))
            makeLuaSprite('customIntro'..countDown,image..countDown,posX,counterPos[countDown][2])
            setObjectCamera('customIntro'..countDown,'hud')
            scaleObject('customIntro'..countDown,counterScale[countDown][1],counterScale[countDown ][2])
            setProperty('customIntro'..countDown..'.antialiasing',antialiasing)
        end
        makeLuaSprite('customIntro0',image..'go',counterPos[4][1] - (screenWidth - getProperty('camGame.width')),counterPos[4][2])
        setObjectCamera('customIntro0','hud')
        scaleObject('customIntro0',counterScale[4][1],counterScale[4][2])
        setProperty('customIntro0.antialiasing',antialiasing)
    end
end
function onTweenCompleted(tag)
    if tag == 'circleDestroy' then
        if circleCreated == true then
            removeLuaSprite('startCircle',true)
        end
        if textCreated == true then
            removeLuaSprite('startText',true)
        end
        removeLuaSprite('blackScreenSonicCount',true)
    end
    if tag == 'byeCustomIntro3' then
        removeLuaSprite('customIntro3',true)
    end
end
function changeCounterPos(changeAll,posX,posY,tablePos)
    if changeAll == true then
        for counterLength = 1,#counterPos do
            table.remove(counterPos,counterLength)
            table.insert(counterPos,counterLength,{posX,posY})
        end

    else
        table.remove(counterPos,tablePos)
        table.insert(counterPos,tablePos,{posX,posY})
    end
end
function changeCounterScale(changeAll,scaleX,scaleY,tablePos)
    if changeAll == true then
        for scaleLength = 1,#counterScale do
            table.remove(counterScale,scaleLength)
            table.insert(counterScale,tablePos,{scaleX,scaleY})
        end

    else
        table.remove(counterScale,tablePos)
        table.insert(counterScale,tablePos,{scaleX,scaleY})
    end
end