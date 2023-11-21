local ringCounter = 0
local oldCombo = 0
local oldRating = 'N/A'
local oldAccuracy = 0
function onCreate()
    makeLuaSprite('RingCounterImage','Counter',1100,600)
    setObjectCamera('RingCounterImage','hud')
    addLuaSprite('RingCounterImage',true)

    makeLuaText('RingCounterText',ringCounter,100,getProperty('RingCounterImage.x') + 74,getProperty('RingCounterImage.y') - 6)
    setObjectCamera('RingCounterText','hud')
    setTextAlignment('RingCounterText','left')
    setTextColor('RingCounterText','FFCC33')
    setTextSize('RingCounterText',60)
    setTextBorder('RingCounterText',3,'CC6600')
    setTextFont('RingCounterText','EurostileTBla.ttf')
    addLuaText('RingCounterText',true)
    for i = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i,'noteType') == 'RingNote' then
            setPropertyFromGroup('unspawnNotes', i,'texture','RingNote')
            setPropertyFromGroup('unspawnNotes', i,'noAnimation',true)
            setPropertyFromGroup('unspawnNotes', i,'ignoreNote',true)
            updateHitboxFromGroup('unspawnNotes',i)
            --disabled because it will bug the rating.
            --setPropertyFromGroup('unspawnNotes', i,'ratingDisabled',true)
            setPropertyFromGroup('unspawnNotes', i,'rgbShader.enabled',false)
        end
    end
end
function ringCount(count)
    ringCounter = count
    setTextString('RingCounterText',count)
end
function goodNoteHit(id,data,noteType,sus)
    if noteType == 'RingNote' then
        playSound('Ring')
        ringCount(ringCounter + 1)
    end
    if ringCounter > 0 then
        oldCombo = getProperty('combo')
        oldAccuracy = getProperty('ratingPercent')
        oldRating = getProperty('ratingFC')
        if getPropertyFromGroup('notes',id,'hitHealth') < 0 then
            setProperty('health',getProperty('health') + math.abs(getPropertyFromGroup('notes',id,'hitHealth')))
            ringCount(ringCounter - 1)
        end
    end
end

function noteMiss(id,data,noteType,sus)
    if ringCounter > 0 then
        ringCount(ringCounter - 1)

        setProperty('combo',oldCombo)
        setProperty('ratingFC',oldRating)
        setProperty('ratingPercent',oldAccuracy)
        if getPropertyFromGroup('notes',id,'hitHealth') > 0 then
            setProperty('health',getProperty('health') + getPropertyFromGroup('notes',id,'hitHealth'))
        end
        setProperty('totalNotesHit',getProperty('totalNotesHit') + 1)
        setProperty('songMisses',getProperty('songMisses') - 1)
        setProperty('vocals.volume', 1)
    end
end