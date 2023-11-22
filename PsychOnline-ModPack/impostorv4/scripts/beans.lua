local noEndSong = true
local gainBeans = 0
local canLerp = false
local lerpScore = 0

local videoEnd = {
    ['meltdown'] = 'meltdown_afterscene'
}
local hasVideo = false
local hadVideo = true
local stopped = false
local ending = false
local firstStop = true
local stop = true

function onEndSong()
    if firstStop then
        firstStop = false
        return Function_Stop
    else
        ending = true
        beanStuff()
        if stop then
            return Function_Stop
        else
            return Function_Continue
        end
    end
end

function beanStuff()
    if hasVideo then
        -- debugPrint('A1')
        startVideo(hasVideo)
        hasVideo = false
        -- debugPrint('A2')
    elseif noEndSong then
        -- debugPrint('B1')
        noEndSong = false
        gainBeans = score
        if isStoryMode then
            if getProperty('storyPlaylist.length' <= 0) then
                gainBeans = gainBeans + getProperty('campaignScore')
            else
                gainBeans = 0
            end
        end
        gainBeans = round(gainBeans / 600)
        if gainBeans ~= 0 and getDataFromSave('misc', 'endedProper') and not inChartEditor then
            beans()
        else
            stop = false
        end
        -- debugPrint('B2')
    else
        -- debugPrint('C')
        stop = false
    end
end

function onCreate()
    local diaSong = string.lower(songName)
    local diaSong2 = string.gsub(diaSong, '-', ' ')
    if videoEnd[diaSong] then
        hasVideo = videoEnd[diaSong]
    elseif videoEnd[diaSong2] then
        hasVideo = videoEnd[diaSong2]
    end
    initSaveData('amogus', 'vsimpostorpsych')
    initSaveData('misc')
    setDataFromSave('misc', 'endedProper', true)
end

function beans()
    setDataFromSave('amogus', 'beans', getDataFromSave('amogus', 'beans', 0) + gainBeans)
    flushSaveData('amogus')

    lerpScore = gainBeans

    makeLuaSprite('popupBG', '', screenWidth - 300, 0)
    makeGraphic('popupBG', 300, 100, '0xF8FF0000')
    setScrollFactor('popupBG', 0, 0)
    setProperty('popupBG.visible', false)
    setObjectCamera('popupBG', 'other')
    addLuaSprite('popupBG')

    makeLuaSprite('bean', 'shop/bean', 0, 0)
    setProperty('bean.x', getMidpointX('popupBG')-90)
    setScrollFactor('bean', 0, 0)
    setProperty('bean.antialiasing', true)
    setObjectCamera('bean', 'other')
    addLuaSprite('bean')

    makeLuaText('theText', tostring(lerpScore), 0, getProperty('popupBG.x') + 90, getProperty('popupBG.y') - 15)
    setTextFont('theText', 'ariblk.ttf')
    setTextSize('theText', 35)
    setTextAlignment('theText', 'left')
    setProperty('theText.x', getMidpointX('popupBG')-10)
    setTextColor('theText', '0xFFFFFFFF')
    setTextBorder('theText', 3, '000000')
    setScrollFactor('theText', 0, 0)
    setProperty('theText.antialiasing', true)
    setObjectCamera('theText', 'other')
    addLuaText('theText')

    doTweenY('beanTween', 'bean', getMidpointY('popupBG')-(getProperty('bean.height')/2), 0.35, 'circout')
    doTweenY('textTween', 'theText', getMidpointY('popupBG')-(getProperty('theText.height')/2), 0.35, 'circout')

    setProperty('bean.alpha', 0)
    setProperty('theText.alpha', 0)
    doTweenAlpha('beanAlph1', 'bean', 1, 0.5, 'linear')
    doTweenAlpha('textAlph1', 'theText', 1, 0.5, 'linear')

    runTimer('beanStart', 0.9)
end

function onTweenCompleted(tag)
    if tag == 'beanAlph1' then
        runTimer('beanAlph2', 2.5)
    elseif tag == 'beansFinish' then
        endSong()
        endSong()
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'beanStart' then
        -- LOOK I TRIED DOING SHADER STUFF BUT IT JUST WASNT WORTH IT
        setProperty('bean.useColorTransform', true)
        setProperty('bean.colorTransform.redOffset', 255)
        setProperty('bean.colorTransform.greenOffset', 255)
        setProperty('bean.colorTransform.blueOffset', 255)
        setProperty('theText.useColorTransform', true)
        setProperty('theText.colorTransform.redOffset', 255)
        setProperty('theText.colorTransform.greenOffset', 255)
        setProperty('theText.colorTransform.blueOffset', 255)
        canLerp = true
        playSound('getbeans')
    elseif tag == 'beanAlph2' then
        doTweenAlpha('beansFinish', 'bean', 0, 0.5, 'linear')
        doTweenAlpha('textAlph2', 'theText', 0, 0.5, 'linear')
    end
end

function onUpdate(elapsed)
    -- setProperty('songScore', 10000000)
    if not stopped and not firstStop then
        stopped = true
        endSong()
    end
    if stop ~= firstStop and keyJustPressed('accept') then end
    -- debugPrint(stop, firstStop) 
    if not firstStop and not stop and not getProperty('transitioning') then
        endSong() -- tryna prevent softlock
    end
    -- if keyJustPressed('back') then
    --     restartSong(true)
    -- end
    if canLerp then
        lerpScore = math.floor(lerp(lerpScore, 0, boundTo(elapsed * 4, 0, 1) / 1.5))
        if math.abs(0 - lerpScore) < 10 then lerpScore = 0 end
        setProperty('bean.x', getMidpointX('popupBG')-90)
        setProperty('bean.y', getMidpointY('popupBG')-(getProperty('bean.height')/2))
        setProperty('theText.x', getMidpointX('popupBG')-10)
        setProperty('theText.y', getMidpointY('popupBG')-(getProperty('theText.height')/2))
        setTextString('theText', tostring(lerpScore))

        local powerdown = 690 * elapsed
        if getProperty('bean.colorTransform.redOffset') > 1 then
            setProperty('bean.colorTransform.redOffset', getProperty('bean.colorTransform.redOffset') - powerdown)
            setProperty('bean.colorTransform.greenOffset', getProperty('bean.colorTransform.redOffset') - powerdown)
            setProperty('bean.colorTransform.blueOffset', getProperty('bean.colorTransform.redOffset') - powerdown)
            setProperty('theText.colorTransform.redOffset', getProperty('bean.colorTransform.redOffset') - powerdown)
            setProperty('theText.colorTransform.greenOffset', getProperty('bean.colorTransform.redOffset') - powerdown)
            setProperty('theText.colorTransform.blueOffset', getProperty('bean.colorTransform.redOffset') - powerdown)
        else
            setProperty('bean.colorTransform.redOffset', 1)
            setProperty('bean.colorTransform.greenOffset', 1)
            setProperty('bean.colorTransform.blueOffset', 1)
            setProperty('theText.colorTransform.redOffset', 1)
            setProperty('theText.colorTransform.greenOffset', 1)
            setProperty('theText.colorTransform.blueOffset', 1)
        end
    end
end

function round(x)
	local r = math.floor(x)
    if x - r <= 0.5 then x = math.ceil(x) else x = r end
	return x
end

function boundTo(value, min, max)
	-- debugPrint(math.max(min, math.min(max, value)))
	return math.max(min, math.min(max, value))
end

function lerp(from,to,i)
	return from+(to-from)*i
end

function onPause()
    if stop ~= firstStop then
        return Function_Stop
    end
end