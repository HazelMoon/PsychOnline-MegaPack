local enableDadShake = false
local enableBfShake = false
local forceStopShake = false
local charactersShake =
{
    'Nightmare-Cuphead',
    'Nightmare-Sans',
    'Nightmare-Bendy',
    'bendy-run',
    'bendy-run-dark'
}
local dadfounded = false
--local bfFounded = false

--local bfShakeintensity = 0.005
--local bfShakeDuration = 0.1

local dadShakeintensity = 0.005
local dadShakeDuration = 0.05
function onCreatePost()
    detectCharacter()
end
function opponentNoteHit(id,data,type,sus)
    if forceStopShake == false and getPropertyFromGroup('notes',id,'hitHealth') > 0 then
        if enableDadShake == true then
            cameraShake('camGame',dadShakeintensity,dadShakeDuration)
            cameraShake('camHUD',dadShakeintensity,dadShakeDuration)
        end
    end
end
function detectCharacter()
    for dadLength = 1,#charactersShake do
        if getProperty('dad.curCharacter') == charactersShake[dadLength] then
            dadfounded = true
            enableDadShake = true
        end
        if dadLength == #charactersShake and getProperty('dad.curCharacter') ~= charactersShake[dadLength] and dadfounded == false then
            enableDadShake = false
        end
    end
end
function onEvent(name,v1,v2)
    if name == 'Change Character' then
        if enableDadShake == true then
            dadfounded = false
            enableDadShake = false
            detectCharacter()
        end
    end
end