-- [[made by laztrix. please credit if this gonna being used for a public mod]] --

function onCountdownStarted()
    TaskSong()
end

function TaskSong() 
    fSize = 24
    if checkFileExists('data/'..songPath..'/info.txt') then
        curtaskText = getTextFromFile('data/'..songPath..'/info.txt',false)
        dotask = true
    else
        dotask = false
    end

    if dotask then
        makeLuaText('tasktext',string.gsub(curtaskText, "\r", ""),0,-screenWidth / 2,200) -- windows newline fix
        setTextSize('tasktext',fSize)
        setTextAlignment('tasktext','LEFT')
        setTextFont('tasktext','arial.ttf')
        setTextBorder('tasktext', 1, '000000')
        addLuaText('tasktext')
        setObjectCamera('tasktext','camOther')

        tasksize = getTextWidth('tasktext')

        makeLuaSprite('taskbg', nil, - tasksize - 50, 190)
        makeGraphic('taskbg', math.floor(tasksize + fSize) + 10, 80, 'FFFFFF')
        addLuaSprite('taskbg')
        setProperty('taskbg.alpha',0.4)
        setObjectCamera('taskbg','camOther')

        doTweenX('yourtaskbg','taskbg',fSize/-2,1,'quintInOut')
        doTweenX('yourtasktext','tasktext',10,1,'quintInOut')
    end
end

function onTimerCompleted(t)
    if t == 'holdtask' then
        doTweenX('yourtaskbgend','taskbg',-screenWidth / 2,1,'quintInOut')
        doTweenX('yourtasktext','tasktext',-screenWidth / 2,1,'quintInOut')
    end
end

function onTweenCompleted(t)
    if t == 'yourtaskbg' then
        runTimer('holdtask',2)
    end
end
-- [[made by laztrix. please credit if this gonna being used for a public mod]] --
