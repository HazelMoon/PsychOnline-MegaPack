local ChangedCharacter = false

local enableChange = true

local lastTexture = ''

local dadCharacter = ''
local bfCharacter = ''
local gfCharacter = ''

local precachedbf = ''
local precachedgf = ''
local precacheddad = ''

local curDadCharacter = nil
local curBFCharacter = nil
local curGFCharacter = nil

local changeNotes = 0

local curZoom = 0

local bfX = 0
local bfY = 0

local dadX = 0
local dadY = 0

local gfX = 0
local gfY = 0
function onCreate()
    for eventNotes = 0,getProperty('eventNotes.length')-1 do
        if getPropertyFromGroup('eventNotes',eventNotes,'event') == 'Genesis' then
            if getPropertyFromGroup('eventNotes',eventNotes,'value2') ~= '' then
                local value2 = getPropertyFromGroup('eventNotes',eventNotes,'value2')
                local comma1 = 0
                local comma2 = 0
                local comma3 = 0
                local comma4 = 0
                local dad = ''
                local bf = ''
                local gf = ''
                comma1,comma2 = string.find(value2,',',0,true)
                if comma1 ~= nil then
                    comma3,comma4 = string.find(value2,',',comma2 + 1)
                    dad = string.sub(value2,0,comma1 - 1)
                    if comma2 ~= nil then
                        bf = string.sub(value2,comma1 + 1,comma2 - 1)
                        if comma3 ~= nil then
                            gf = string.sub(value2,comma2 + 1,comma3 - 1)
                        else
                            gf = string.sub(value2,comma2 + 1)
                        end
                    else
                        bf = string.sub(value2,comma1 + 1)
                    end
                    if bfCharacter ~= bf and bf ~= nil and bf ~= '' and bf ~= '.' then
                        bfCharacter = bf
                        precacheCharacters(true,false,false)
                    end
                    if dadCharacter ~= dad and dad ~= nil and dad ~= '' and dad ~= '.' then
                        dadCharacter = dad
                        precacheCharacters(false,false,true)
                    end
                    if gfCharacter ~= gf and gf ~= nil and gf ~= '' and gf ~= '.' then
                        gfCharacter = gf
                        precacheCharacters(false,true,false)
                    end
                end
            end
        end
    end
end
function onCreatePost()
    precacheImage('run/GreenHill')
    precacheImage('StaticPixel')
    makeLuaSprite('greenHill','run/GreenHill',-350,-650)
    setProperty('greenHill.antialiasing',false)
    scaleObject('greenHill',8.2,8.2)
    addLuaScript('custom_events/static')
end
function precacheCharacters(bf,gf,dad)
    if bf == true then
        addCharacterToList(bfCharacter,'boyfriend')
        precachedbf = bfCharacter
    end
    if gf == true and enableGF == true then
        addCharacterToList(gfCharacter,'gf')
        precachedgf = gfCharacter
    end
    if dad == true then
        addCharacterToList(dadCharacter,'dad')
        precacheddad = dadCharacter
    end
end
function onUpdate()
    if precachedbf ~= bfCharacter then
        if getProperty('boyfriend.curCharacter') == 'encore-bf' or getProperty('boyfriend.curCharacter') == 'bf-encore' then
            bfCharacter = 'bfpickel-encore'
        end
        precacheCharacters(true,false,false)
    end
    if precacheddad ~= dadCharacter then
        precacheCharacters(false,false,true)
    end
    if precachedgf ~= gfCharacter and enableGF == true then
        precacheCharacters(false,true,false)
    end
    if changeNotes == 2 then
        for notesLength = 0,getProperty('notes.length')-1 do
            if getPropertyFromGroup('notes',notesLength,'texture') == '' then
                setPropertyFromGroup('notes',notesLength,'texture','PIXELNOTE_assets')
                setPropertyFromGroup('notes',notesLength,'antialiasing',false)
            end
        end
    elseif changeNotes == 1 then
        for notesLength = 0,getProperty('notes.length')-1 do
            if getPropertyFromGroup('notes',notesLength,'texture') == 'PIXELNOTE_assets' then
                setPropertyFromGroup('notes',notesLength,'texture','')
                setPropertyFromGroup('notes',notesLength,'antialiasing',getPropertyFromClass('backend.ClientPrefs','data.antialiasing'))
            end
        end
        changeNotes = 0
    end
    if ChangedCharacter == false then
        bfX = getProperty('boyfriend.x')
        bfY = getProperty('boyfriend.y')
        dadX = getProperty('dad.x')
        dadY = getProperty('dad.y')
        curDadCharacter = getProperty('dad.curCharacter')
        curBFCharacter = getProperty('boyfriend.curCharacter')
        curZoom = getProperty('defaultCamZoom')
        if enableGF == 'true' then
            gfX = getProperty('gf.x')
            gfY = getProperty('gf.y')
            curGFCharacter = getProperty('gf.curCharacter')
        end
    end

end
function onEvent(name,v1,v2)
    if name == 'Genesis' then
        local enableGenesis = 'true'
        local commaV1 = 0
        local commaV2 = 0
        commaV1,commaV2 = string.find(string.lower(v1),',',0,true)
        if commaV1 ~= nil then
            enableGenesis = string.sub(string.lower(v1),0,commaV1 - 1)
        else
            enableGenesis = v1
        end
        if enableGenesis ~= 'false' and enableGenesis ~= '0' then
            local comma1 = 0
            local comma2 = 0
            local comma3 = 0
            local comma4 = 0
            local comma5 = 0
            local comma6 = 0
            comma1,comma2 = string.find(v2,',',0,true)
            for strumLineNotes = 0,7 do
                if lastTexture == '' then
                    lastTexture = getPropertyFromGroup('strumLineNotes',strumLineNotes,'texture')
                end
                setPropertyFromGroup('strumLineNotes',strumLineNotes,'texture','PixelNOTE_assets')
            end
            if comma1 ~= nil then
                dadCharacter = string.sub(v2,0,comma1 - 1)
                comma3,comma4 = string.find(v2,',',comma2 + 1,true)
                if comma3 ~= nil then
                    comma5,comma6 = string.find(v2,',',comma4 + 1,true)
                    bfCharacter = string.sub(v2,comma2 + 1,comma3 - 1)
                    if enableGF == 'true' then
                        if comma5 ~= nil then
                            gfCharacter = string.sub(v2,comma4 + 1,comma5 - 1)
                        else
                            gfCharacter = string.sub(v2,comma4 + 1)
                        end
                    end
                else
                    bfCharacter = string.sub(v2,comma2 + 1)
                end
            end
            if songName == 'you-cant-run-encore' then
                dadCharacter = 'pixelrunsonic-new'
            end
            if bfCharacter ~= '' and bfCharacter ~= nil then
                triggerEvent('Change Character','bf',bfCharacter)
            end
            if dadCharacter ~= '' and dadCharacter ~= nil then
                triggerEvent('Change Character','dad',dadCharacter)
            end
            setProperty('defaultCamZoom',1)
            setProperty('greenHill.x',getProperty('boyfriend.x') - 1400)
            setProperty('greenHill.y',getProperty('boyfriend.y') - 850)
            addLuaSprite('greenHill')
            setProperty('boyfriend.x',getProperty('greenHill.x') + 1100 +  getProperty('boyfriend.positionArray[0]'))
            setProperty('boyfriend.y',getProperty('greenHill.y') + 250 + getProperty('boyfriend.positionArray[1]'))

            setProperty('dad.x',getProperty('greenHill.x') + 450 + getProperty('dad.positionArray[0]'))
            setProperty('dad.y',getProperty('greenHill.y') + 250 +  getProperty('dad.positionArray[1]'))
            triggerEvent('static','true','')
            runTimer('changeNotesSonic',0.2)
            ChangedCharacter = true
            changeNotes = 2
            if enableGF == 'true' then
                if gfCharacter ~= '' and gfCharacter ~= nil then
                    triggerEvent('Change Character','gf',gfCharacter)
                end
                setProperty('gf.x',getProperty('greenHill.x') + 700 + getProperty('gf.positionArray[0]'))
                setProperty('gf.y',getProperty('greenHill.y') + 300 + getProperty('gf.positionArray[1]'))
            end
        else
            for strumLineNotes = 0,7 do
                setPropertyFromGroup('strumLineNotes',strumLineNotes,'texture',lastTexture)
            end
            lastTexture = ''
            changeNotes = 1
            triggerEvent('static','false','')
            removeLuaSprite('greenHill',false)
            setProperty('defaultCamZoom',curZoom)
            triggerEvent('Change Character','bf',curBFCharacter)
            triggerEvent('Change Character','dad',curDadCharacter)
            if enableGF == 'true' then
                triggerEvent('Change Character','gf',curGFCharacter)
                setProperty('gf.x',gfX)
                setProperty('gf.y',gfY)
            end
            setProperty('boyfriend.x',bfX)
            setProperty('boyfriend.y',bfY)
            setProperty('dad.x',dadX)
            setProperty('dad.y',dadY)
        end
    end
end
function onTimerCompleted(tag)
    if tag == 'backCharacter' then
        ChangedCharacter = false
    end
end