function onUpdate()
    if getProperty('dad.curCharacter') == 'sonicexe-gotcha' and getProperty('dad.animation.curAnim.name') == 'gotcha' and getProperty('dad.animation.curAnim.finished') == true then
        triggerEvent('Change Character','dad','sonicexe')
    end
end