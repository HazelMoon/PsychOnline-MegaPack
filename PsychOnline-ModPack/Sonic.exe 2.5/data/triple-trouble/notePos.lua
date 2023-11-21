local curState = 0
function onStepHit()
    if not middlescroll then
        if (curStep >= 1296 and curStep < 2832) and curState == 0 then
            changeNotePos(1,luaSpriteExists('RingStrum'))
            
        elseif curState == 1 and curStep >= 2832 then
            changeNotePos(0,luaSpriteExists('RingStrum'))
        end
    end
end
function changeNotePos(state,ring)
    curState = state
    if state == 1 then
        for strums = 0,4 do
            setPropertyFromGroup('opponentStrums', strums,'x',732 + (112 * strums))
            if ring then
                if strums < 2 then
                    setPropertyFromGroup('playerStrums', strums,'x',92 + (112 * strums) - 56)
                else
                    setPropertyFromGroup('playerStrums', strums,'x',92 + (112 * strums) + 56)
                end
            else
                setPropertyFromGroup('playerStrums', strums,'x',92 + (112 * strums))
            end
        end
    elseif state == 0 then
        for strums = 0,4 do
            setPropertyFromGroup('opponentStrums', strums,'x',92 + (112 * strums))
            if ring then
                if strums < 2 then
                    setPropertyFromGroup('playerStrums', strums,'x',732 + (112 * strums) - 56)
                else
                    setPropertyFromGroup('playerStrums', strums,'x',732 + (112 * strums) + 56)
                end
            else
                setPropertyFromGroup('playerStrums', strums,'x',732 + (112 * strums))
            end
        end
    end
    if ring then
        setProperty('RingStrum.x',getPropertyFromGroup('playerStrums',1,'x') + 112)
    end
end