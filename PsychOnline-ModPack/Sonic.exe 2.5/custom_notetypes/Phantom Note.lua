local phantomTime = {}
function onCreate()
    for i = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i,'noteType') == 'Phantom Note' then
            setPropertyFromGroup('unspawnNotes', i,'texture','PHANTOMNOTE_assets')
            setPropertyFromGroup('unspawnNotes', i,'ignoreNote',true)
            updateHitboxFromGroup('unspawnNotes',i)
        end
    end
end
function onBeatHit()
    if #phantomTime > 0 then
        for phantomLenght = 1,#phantomTime do
            if phantomTime[phantomLenght] == nil then
                return
            end
            local phantom = phantomTime[phantomLenght]
            if  phantom  > 0 then
                setProperty('health',getProperty('health') - 0.023)
                phantomTime[phantomLenght] = phantom - 0.01
            elseif phantom <= 0 then
                table.remove(phantomTime,phantomLenght)
            end
        end
    end
end
function goodNoteHit(id,data,noteType,sustain)
    if noteType == 'Phantom Note' then
        table.insert(phantomTime,0.5)
    end
end