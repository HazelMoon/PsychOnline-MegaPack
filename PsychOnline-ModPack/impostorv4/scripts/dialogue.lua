local hasDialog = false
local stopCountdown = true
local sprGroups = {}
local diaSong = ''
local dialogExists = false
local videoStart = {
    ['sussus-moogus'] = 'polus1',
    ['sabotage'] = 'polus2',
    ['meltdown'] = 'polus3'
}
local hasVideo = false
local doneInit = false
local mouseVisible = false

function onCreate()
    if not seenCutscene then
        diaSong = string.lower(songName)
        diaSong2 = string.gsub(diaSong, '-', ' ')
        if videoStart[diaSong] then
            hasVideo = videoStart[diaSong]
        elseif videoStart[diaSong2] then
            hasVideo = videoStart[diaSong2]
        end
        startInit()
    end
end

local doneVideo = false
function onStartCountdown()
    if hasVideo then
        startVideo(hasVideo)
        hasVideo = false
        return Function_Stop
    end
    doneVideo = true
    if dialogExists then
        if stopCountdown or hasDialog then
            if not doneInit then
                startInit()
            end
            return Function_Stop
        end
        if not skipCountdown then
            soundFadeOut('', 0.5, 0)
        end
        -- setPropertyFromClass('flixel.FlxG', 'mouse.visible', mouseVisible)
        return Function_Continue
    end
    return Function_Continue
end

local dialogue = {}
local lineIndex = 0
local oldChar = {portraitLeft = '', portraitRight = '', portraitMid = ''}
local curDisplay = ''
local curChar = ''
local curEmote = 'neutral'
local dispLength = 0
local dispIndex = 0
local textTimer = 0
local speaker = 'portraitLeft'
local boxChar = ''
local curIcon = ''
local curSound = ''

function nextLine(skip, nosound)
    if dispIndex >= dispLength - 1 or skip then
        lineIndex = lineIndex + 1
        -- debugPrint(lineIndex, ' ', #dialogue)
        if lineIndex > #dialogue then
            if hasDialog then
                hasDialog = false
                dispIndex = dispLength + 1
                setTextString('swagDialogue', curDisplay)
                tweenValue('boxer!!', boxGroup.y, boxGroup.y+500, 0.25, 'circIn')
                doTweenAlpha('bgFadeOut', 'bgFade', 0, 0.25, 'circIn')
                doTweenAlpha('alphaHud', 'camHUD', 1, 0.25, 'circIn')
                playSound('panelDisappear', 0.5)
            end
            return
        end

        if lineIndex >= 2 then
            setProperty('bubble2.visible', true)

            -- debugPrint('|',curIcon,'|')
            -- if not checkFileExists('images/icons/icon-'..curIcon) then curIcon = 'bf' end
            makeLuaSprite('OiconYea', 'icons/icon-'..curIcon, 234, getMidpointY('portraitBubble')+57.3)
            setProperty('OiconYea._frame.frame.width', getProperty('OiconYea._frame.frame.width') * 0.5)
            scaleObject('OiconYea', 0.8, 0.8)
            setObjectCamera('OiconYea', 'other')
            add('OiconYea')
        end
        if not nosound then
            playSound('clickText', 0.8)
        end
        textTimer = 0
        dispIndex = 0
        setTextString('OldDropText', boxChar)
        setTextString('swagDialogue', '')
        setTextString('OldDText', curDisplay)
        oldChar[speaker] = curChar
        curDisplay = dialogue[lineIndex]['line']
        curChar = dialogue[lineIndex]['char']
        dispLength = string.len(curDisplay)
        Dinnit()
    else
        dispIndex = dispLength - 1
        textTimer = 0.06
    end
end

-- splits string `s` at positions `...`
function stringSplitAt(s, ...)
    local args = {...}
    local output = s
    for _, pos in ipairs(args) do
        if pos then
            output = string.sub(output, 1, pos - 1) .. '`' .. string.sub(output, pos + 1, s:len())
        end
    end
    return stringSplit(output, '`')
end

function startInit()
    if checkFileExists('data/'..songPath..'/dialogue.txt') then
        hasDialog = true
        dialogExists = true
        setProperty('camHUD.alpha', 0)
        runHaxeCode([[PlayState.seenCutscene = true;]])
        makeLuaSprite('bgBlock', nil, -100, -100)
        makeGraphic('bgBlock', screenWidth * 2, screenHeight * 2, '000000')
        setObjectCamera('bgBlock', 'other')
        add('bgBlock', false)
        if not hasVideo then
            runTimer('byeBlock', 0.1)
        end

        precacheImage('dialogueV4/bf')
        precacheImage('dialogueV4/gf')
        precacheImage('dialogueV4/bubble')
        precacheImage('dialogueV4/dialogueBox')
    else
        stopCountdown = false
    end
end

function initDialogue()
    makeLuaSprite('bgFade', nil, -200, -200)
    makeGraphic('bgFade', screenWidth * 1.3, screenHeight * 1.3, 'FFFFFF')
    setObjectCamera('bgFade', 'other')
    setProperty('bgFade.alpha', 0)
    add('bgFade', false)

    doTweenAlpha('bgFadeIn', 'bgFade', 0.35, 0.8, 'circIn')

    dialogue = stringSplit(stringTrim(string.gsub(getTextFromFile('data/'..songPath..'/dialogue.txt'), '\r', '')), '\n')
    local foundWhere = 0
    local foundWhere2 = 0
    local curLine = {}
    for index, line in ipairs(dialogue) do
        if index < #dialogue + 1 then
            line = stringTrim(line)
            line = string.sub(line, 2, line:len())
            foundWhere = string.find(line, ':', 2)
            foundWhere2 = string.find(line, ':', foundWhere + 1)
            if string.sub(line, foundWhere2, foundWhere2) ~= ':' then foundWhere2 = false end
            curLine = stringSplitAt(line, foundWhere, foundWhere2)
            dialogue[index] = {char = curLine[1], feel = curLine[2], line = curLine[#curLine]}
            if #curLine < 3 then
                dialogue[index]['line'] = ''
            end
        end
    end
    -- debugPrint(dialogue)

    makeSprGroup('boxGroup', 0, 0)

    makeSpr('portraitLeft', 'dialogueV4/red', 196.85, 251.35)
    setObjectCamera('portraitLeft', 'other')
    setProperty('portraitLeft.alpha', 0)
    add('portraitLeft')
    add('boxGroup', 'portraitLeft')

    makeSpr('portraitRight', 'dialogueV4/boyfriend', 964.75, 216.3)
    setObjectCamera('portraitRight', 'other')
    setProperty('portraitRight.alpha', 0)
    add('portraitRight')
    add('boxGroup', 'portraitRight')

    makeSpr('portraitMid', 'dialogueV4/gf', 0, 198.15)
    setObjectCamera('portraitMid', 'other')
    screenCenter('portraitMid', 'x')
    setProperty('portraitMid.alpha', 0)
    add('portraitMid')
    add('boxGroup', 'portraitMid')

    makeSpr('box', 'dialogueV4/dialogueBox', 0, 431.45, {
        {'bf',      'dialog frame', '0'},
        {'gf',      'dialog frame', '1'},
        {'red',     'dialog frame', '2'},
        {'gc',      'dialog frame', '3'},
        {'gi',      'dialog frame', '3'},
        {'y',       'dialog frame', '4'},
        {'wi',      'dialog frame', '5'},
        {'maroon',  'dialog frame', '7'},
        {'gray',    'dialog frame', '8'},
        {'pink',    'dialog frame', '9'},
        {'pi',      'dialog frame', '9'},
        {'war',     'dialog frame', '10'},
        {'jelq',    'dialog frame', '11'}
    })
    setObjectCamera('box', 'other')
    screenCenter('box', 'x')
    add('box')
    add('boxGroup', 'box')

    makeSpr('portraitBubble', 'dialogueV4/bubble', 0, 495.55, false)
    setObjectCamera('portraitBubble', 'other')
    screenCenter('portraitBubble', 'x')
    setProperty('portraitBubble.x', getProperty('portraitBubble.x') + 18.5)
    add('portraitBubble')
    add('boxGroup', 'portraitBubble')

    makeSpr('bubble2', 'dialogueV4/bubble', 0, 616.35, false)
    setObjectCamera('bubble2', 'other')
    screenCenter('bubble2', 'x')
    setProperty('bubble2.x', getProperty('bubble2.x') + 18.5)
    setProperty('bubble2.visible', false)
    add('bubble2')
    add('boxGroup', 'bubble2')

    makeLuaText('OldDropText', '', screenWidth * 0.54, 350, 613.65)
    setTextAlignment('OldDropText', 'left')
    setTextFont('OldDropText', 'liberbold.ttf')
    setTextSize('OldDropText', 30)
    setTextBorder('OldDropText', 3, '000000')
    setObjectCamera('OldDropText', 'other')
    addLuaText('OldDropText')
    add('boxGroup', 'OldDropText')

    makeLuaText('dropText', 'im such a cute uwu catboy owo', screenWidth * 0.54, 350, 493.7)
    setTextAlignment('dropText', 'left')
    setTextFont('dropText', 'liberbold.ttf')
    setTextSize('dropText', 30)
    setTextBorder('dropText', 3, '000000')
    setObjectCamera('dropText', 'other')
    addLuaText('dropText')
    add('boxGroup', 'dropText')

    makeLuaText('OldDText', '', screenWidth * 0.54, 350, 650.05)
    setTextAlignment('OldDText', 'left')
    setTextFont('OldDText', 'liber.ttf')
    setTextSize('OldDText', 26)
    setTextColor('OldDText', '000000')
    setTextBorder('OldDText', 0)
    setObjectCamera('OldDText', 'other')
    addLuaText('OldDText')
    add('boxGroup', 'OldDText')

    makeLuaText('swagDialogue', 'im such a cute uwu catboy owo', screenWidth * 0.54, 350, 529.95)
    setTextAlignment('swagDialogue', 'left')
    setTextFont('swagDialogue', 'liber.ttf')
    setTextSize('swagDialogue', 26)
    setTextColor('swagDialogue', '000000')
    setTextBorder('swagDialogue', 0)
    setObjectCamera('swagDialogue', 'other')
    addLuaText('swagDialogue')
    add('boxGroup', 'swagDialogue')

    add('boxGroup', 'iconYea')
    add('boxGroup', 'OiconYea')

    doneInit = true
    nextLine(true, true)

    if checkFileExists('music/dialogue/'..diaSong..'.ogg') then
        playMusic('dialogue/'..diaSong, 0, true)
        soundFadeIn('', 1, 0, 0.8)
    elseif checkFileExists('music/dialogue/'..diaSong2..'.ogg') then
        playMusic('dialogue/'..diaSong2, 0, true)
        soundFadeIn('', 1, 0, 0.8)
    else
        -- playMusic('offsetSong', 0, true)
    end
end

function makeSprGroup(tag, x, y)
    x = x or 0
    y = y or 0
    table.insert(sprGroups, 1, tag)
    _G[tag] = {['x'] = x, ['y'] = y, members = {}, oldx = y, oldy = y}
end

-- for both spr groups and just adding to stage
-- group acts as sprite and spr acts like front if adding to stage
function add(group, spr)
    spr = spr or true
    if spr == true or spr == false then
        addLuaSprite(group, spr)
    else
        table.insert(_G[group].members, 1, spr)
    end
end

function removeGroup(group, destroy)
    destroy = destroy or true
    for _, i in ipairs(_G[group].members) do
        removeLuaSprite(i, destroy)
        removeLuaText(i, destroy)
    end
    if destroy then
        _G[group] = nil
    end
end

-- use semicolon with other spr stuff
-- anims is an array that goes as follows:
-- anims = {{animName:String, animPrefix:String, ?animIndices:String = '', ?framerate:Float = 24, ?loop:Bool = false}}
-- if making static sprite, set anims to false
function makeSpr(tag, img, x, y, anims)
    if anims == nil then anims = {} end
    x = x or getProperty(tag..'.x') or 0
    y = y or getProperty(tag..'.y') or 0
    if anims == false then
        makeLuaSprite(tag, img, x, y)
    else
        makeAnimatedLuaSprite(tag, img, x, y)
        animSpr(tag, anims)
    end
end

-- anims is an array that goes as follows:
-- anims = {{animName:String, animPrefix:String, ?animIndices:String = '', ?framerate:Float = 24, ?loop:Bool = false}}
function animSpr(tag, anims)
    for _, curAnim in ipairs(anims) do
        for i = #curAnim, 5 do
            table.insert(curAnim, #curAnim + 1, false)
        end

        if not curAnim[3] then curAnim[3] = '' end
        if not curAnim[4] then curAnim[4] = 24 end

        if curAnim[5] then
            addAnimationByIndicesLoop(tag, curAnim[1], curAnim[2], curAnim[3], curAnim[4])
        else
            addAnimationByIndices(tag, curAnim[1], curAnim[2], curAnim[3], curAnim[4])
        end
    end
end

local valTweens = {}
function tweenValue(tag, start, endd, duration, ease)
    -- why is this not a thing in psych already
    valTweens[tag] = start
    makeLuaSprite(tag, nil, start, 0)
    doTweenX(tag, tag, endd, duration, ease)
end

function onTweenCompleted(tag)
    if valTweens[tag] then
        valTweens[tag] = nil
    end
    if tag == 'boxer!!' then
        stopCountdown = false
        removeGroup('boxGroup')
        startCountdown()
        -- close() BREAKS SHIT APPARENTLY
    end
    if tag == 'bgFadeOut' then
        remove('bgFade')
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'byeBlock' then
        local blockAlpha = getProperty('bgBlock.alpha') - 0.15
        setProperty('bgBlock.alpha', blockAlpha)
        -- debugPrint(blockAlpha)
        if blockAlpha > 0 then
            runTimer('byeBlock', 0.1)
        else
            -- debugPrint('bro')
            removeLuaSprite('bgBlock')
            initDialogue()
        end
    end
end

local curGroup = {}
local mouseHold = 0
function onUpdatePost(elapsed)
    if stopCountdown and doneInit and doneVideo then
        for tag, _ in pairs(valTweens) do
            valTweens[tag] = getProperty(tag..'.x')
            if tag == 'boxer!!' then
                boxGroup.y = valTweens[tag]
            end
        end
        if dispIndex <= dispLength then
            -- some regulation system not present in the official mod.
            -- balances delay between short and long text... kinda. pretty subtle
            local delay = 0.05 * ((dispLength - 0.6) / (dispLength * 1.45 - 3))
            if textTimer > delay then
                textTimer = 0
                setTextString('swagDialogue', string.sub(curDisplay, 0, dispIndex))
                stopSound('dialogScroll')
                if dispIndex ~= dispLength then
                    playSound('dialogue/'..curSound..'D', 0.6, 'dialogScroll')
                end
                playAnim(speaker, curEmote, false)
                dispIndex = dispIndex + 1
            end
            textTimer = textTimer + elapsed
        else
            if getProperty(speaker..'.animation.curAnim.finished') then
                playAnim(speaker, curEmote..'done')
            end
        end
        if hasDialog then
            if keyJustPressed('back') or mouseHold >= 1.25 then
                cancelTween('bgFadeIn')
                -- lineIndex = #dialogue - 2
                for _ = lineIndex, #dialogue + 1 do
                    nextLine(true, true)
                end
                cancelTween('alphaTweenportraitRight')
                cancelTween('alphaTweenportraitLeft')
                cancelTween('alphaTweenportraitMid')
                cancelTween('xTweenportraitRight')
                cancelTween('xTweenportraitLeft')
                cancelTween('yTweenGF')
                if getProperty('portraitRight.alpha') > 0 then setProperty('portraitRight.alpha', 1) end
                if getProperty('portraitLeft.alpha') > 0 then setProperty('portraitLeft.alpha', 1) end
                if getProperty('portraitMid.alpha') > 0 then setProperty('portraitMid.alpha', 1) end
                setProperty('portraitRight.x', 864.75 + boxGroup.oldx)
                setProperty('portraitLeft.x', 246.85 + boxGroup.oldx)
                setProperty('portraitMid.y', 148.15 + boxGroup.oldy)
            end
            if keyJustPressed('accept') or (getPropertyFromClass('flixel.FlxG', 'mouse.justReleased') and mouseHold < 0.25) then nextLine() end
        end
        -- debugPrint(getPropertyFromClass('flixel.FlxG', 'mouse.justPressed'))
        if getPropertyFromClass('flixel.FlxG', 'mouse.pressed') then -- mobile support. i can prolly check for build target but whatever
            mouseHold = mouseHold + elapsed
        else
            mouseHold = 0
        end
        for i, tag in ipairs(sprGroups) do
            curGroup = _G[tag]
            if curGroup == null then
                sprGroups[i] = nil
                goto continue
            end
            for _, spr in ipairs(curGroup.members) do
                setProperty(spr..'.x', getProperty(spr..'.x') - curGroup.oldx + curGroup.x)
                setProperty(spr..'.y', getProperty(spr..'.y') - curGroup.oldy + curGroup.y)
            end
            _G[tag].oldx = curGroup.x
            _G[tag].oldy = curGroup.y
            ::continue::
        end
    end
end

local charImg = ''
function Dinnit()

    -- this gotta be the worst code in history 2 - the sequel
    playAnim('box', curChar, true)

    speaker = 'portraitLeft'
    boxChar = 'Red'
    curIcon = curChar
    curSound = 'red'
    charImg = 'red'

    if curChar == 'red' then
        if diaSong == 'meltdown' then
            curIcon = 'impostor2'
        else
            curIcon = 'impostor'
        end

        charImg = 'red'
    elseif curChar == 'gc' then
        if diaSong == 'lights-down' then
            curIcon = 'impostor3'
        else
            curIcon = 'crewmate'
        end
        boxChar = 'Green'
        charImg = 'green'
    elseif curChar == 'y' then
        curIcon = 'yellow'
        boxChar = 'Yellow'
        charImg = 'yellow'
    elseif curChar == 'wi' then
        curIcon = 'white'
        boxChar = 'White'
        charImg = 'white'
    elseif curChar == 'gi' then
        curIcon = 'impostor3'
        boxChar = 'Green'
        charImg = 'green'
    elseif curChar == 'maroon' then
        boxChar = 'Maroon'
        charImg = 'maroon'
    elseif curChar == 'pink' then
        boxChar = 'Pink'
        charImg = 'pink'
    elseif curChar == 'pi' then
        curIcon = 'pink'
        boxChar = 'Pink'
        charImg = 'pretendpink'
    elseif curChar == 'gray' or curChar == 'grey' then
        curIcon = 'gray' -- SO ARE YOU BRITISH OR AMERICAN
        boxChar = 'Grey'
        charImg = 'grey'
        curChar = 'grey'
        playAnim('box', 'gray', true)
    elseif curChar == 'gf' then
        curSound = 'gf'
        speaker = 'portraitMid'
        boxChar = 'Girlfriend'
    else
        curSound = 'bf'
        speaker = 'portraitRight'
        charImg = 'boyfriend'
        boxChar = 'Boyfriend'
    end

    makeLuaSprite('iconYea', 'icons/icon-'..curIcon, 234, getMidpointY('portraitBubble')-63.5)
    setProperty('iconYea._frame.frame.width', getProperty('iconYea._frame.frame.width') * 0.5)
    scaleObject('iconYea', 0.8, 0.8)
    setObjectCamera('iconYea', 'other')
    add('iconYea')

    setTextString('dropText', boxChar)
    loadOffsets(speaker, curChar)
end

local anims = {}
function loadOffsets(man, char)
    if oldChar[man] ~= char then
        anims[char] = {neutral = true}
        if man ~= 'portraitMid' then
            removeLuaSprite(man, false)
            loadGraphic(man, 'dialogueV4/'..charImg)
            loadFrames(man, 'dialogueV4/'..charImg)
            -- makeSpr(man, 'dialogueV4/'..charImg)
            setObjectCamera(man, 'other')
            add(man)
            setObjectOrder(man, 1)
            setObjectOrder('bgFade', 1)
            if man == 'portraitRight' then
                setProperty('portraitRight.x', 964.75)
                doTweenX('xTween'..man, man, 864.75, 0.5, 'quadInOut')
            else
                setProperty('portraitLeft.x', 196.85)
                doTweenX('xTween'..man, man, 246.85, 0.5, 'quadInOut')
            end
        else
            doTweenY('yTweenGF', man, 148.15, 0.5, 'quadInOut')
        end
        setProperty(man..'.alpha', 0.000001)
        doTweenAlpha('alphaTween'..man, man, 1, 0.5, 'quadInOut')
        if checkFileExists('images/dialogueV4/data/'..char..'.txt') then
            local offsetData = stringTrim(getTextFromFile('images/dialogueV4/data/'..char..'.txt'))
            if string.match(offsetData, '\n') then
                offsetData = stringSplit(offsetData, '\n')
            else
                offsetData = {offsetData}
            end
            local firstData = {}
            for i, v in ipairs(offsetData) do
                local noMoreParsingPLEASE = stringSplit(v, ',')
                if noMoreParsingPLEASE[3] == 'true' then noMoreParsingPLEASE[3] = true
                elseif noMoreParsingPLEASE[3] == 'false' then noMoreParsingPLEASE[3] = false
                end
                if i == 1 then
                    firstData = noMoreParsingPLEASE
                end
                anims[char][noMoreParsingPLEASE[1]] = true
                addAnimationByPrefix(man, noMoreParsingPLEASE[1], noMoreParsingPLEASE[2], 24, noMoreParsingPLEASE[3])
                addOffset(man, noMoreParsingPLEASE[1], noMoreParsingPLEASE[4], noMoreParsingPLEASE[5])
                addAnimationByIndicesLoop(man, noMoreParsingPLEASE[1]..'done', noMoreParsingPLEASE[2], '1')
                addOffset(man, noMoreParsingPLEASE[1]..'done', noMoreParsingPLEASE[4], noMoreParsingPLEASE[5])
            end
            if anims[char]['neutral'] == nil then
                addAnimationByPrefix(man, 'neutral', firstData[2], 24, firstData[3])
                addOffset(man, 'neutral', firstData[4], firstData[5])
                addAnimationByIndicesLoop(man, 'neutraldone', firstData[2], '1')
                addOffset(man, 'neutraldone', firstData[4], firstData[5])
            end
        end
    end

    curEmote = dialogue[lineIndex]['feel']
    -- debugPrint('o',curEmote)

    if anims[char][curEmote] == nil then
        for k, _ in pairs(anims[char]) do
            -- debugPrint(k)
            curEmote = v
            break
        end
    end

    -- debugPrint('n',curEmote)
    playAnim(man, curEmote, true)
end