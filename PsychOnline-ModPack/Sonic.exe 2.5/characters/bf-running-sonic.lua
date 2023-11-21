local jumpPlayed = false
local dashPlayed = false
function onCreatePost()
    precachePreycutscene()
end
function precachePreycutscene()
    for eventNotes = 0,getProperty('eventNotes.length')-1 do
        if getPropertyFromGroup('eventNotes',eventNotes,'event') == 'Play Animation' and getPropertyFromGroup('eventNotes',eventNotes,'value1') == 'first dialogue' then
            addCharacterToList('bf-sonic-peelout','boyfriend')
            precacheSound('SonicJump')
            precacheSound('SonicDash')
            return
        end
    end
    close(true)
end
function onUpdate()
    if getProperty('boyfriend.curCharacter') == 'bf-running-sonic' and getProperty('boyfriend.animation.curAnim.name') == 'first dialogue' then
        local curFrame = getProperty('boyfriend.animation.curAnim.curFrame')
        if getProperty('boyfriend.animation.curAnim.finished') == true then
            triggerEvent('Change Character','bf','bf-sonic-peelout')
        end
        if curFrame == 482 and jumpPlayed == false then
            playSound('SonicJump',2)
            jumpPlayed = true
        end
        if curFrame == 495 and dashPlayed == false then
            playSound('SonicDash',2)
            dashPlayed = true
        end
    end
end