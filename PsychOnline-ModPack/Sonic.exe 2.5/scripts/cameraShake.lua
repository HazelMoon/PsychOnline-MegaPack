local dadenabled = false
local dadCharacters = {'ycr','ycr-mad','scorched','FakerExe'}
function opponentNoteHit()
    if dadenabled then
        cameraShake('camGame',0.005,0.1)
        cameraShake('camHUD',0.003,0.1)
    end
end
function detectCharacter()
    for dadLength = 1,#dadCharacters do
        if getProperty('dad.curCharacter') == dadCharacters[dadLength] then
            dadenabled = true
        end
    end
end
function onEvent(name,v1,v2)
    if name == 'Change Character' then
        detectCharacter()
    end
end