function onCreatePost()
    addCharacterToList('devil','dad')
end

function onUpdate()
    if getProperty('dad.curCharacter') == 'devil-intro' and getProperty('dad.animation.curAnim.finished') == true then
        triggerEvent('Change Character','dad','devil')
    end
end