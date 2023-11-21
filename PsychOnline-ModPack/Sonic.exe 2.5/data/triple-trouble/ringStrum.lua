
function onCreate()
    for ring = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',ring,'noteType') == 'RingNote' then
            setPropertyFromGroup('unspawnNotes',ring,'copyX',false)
            setPropertyFromGroup('unspawnNotes',ring,'copyY',false)
            setPropertyFromGroup('unspawnNotes',ring,'blockHit',true)
        end
    end
    makeAnimatedLuaSprite('RingStrum','RingStrumNote',0,0)
    scaleObject('RingStrum',0.7,0.7)
    setObjectCamera('RingStrum','hud')
    addAnimationByPrefix('RingStrum','static','arrowSPACE',24,true)
    addAnimationByPrefix('RingStrum','confirm','space confirm',24,false)
    addAnimationByPrefix('RingStrum','press','space press',24,false)
    addLuaSprite('RingStrum',false)
    ringPlayAnim('static',true)
end
function onCreatePost()
    for strumNotes = 0,getProperty('playerStrums.length')-1 do
        local x = getPropertyFromGroup('playerStrums',strumNotes,'x')
        if strumNotes < 2 then
            setPropertyFromGroup('playerStrums',strumNotes,'x',x - 56)
        else
            setPropertyFromGroup('playerStrums',strumNotes,'x',x + 56)
        end
    end
    setProperty('RingStrum.x',getPropertyFromGroup('playerStrums',1,'x') + 112)
    setProperty('RingStrum.y',getPropertyFromGroup('playerStrums',1,'y'))
end
function onUpdate()
    if keyboardJustPressed('SPACE') then
        ringPlayAnim('press',true)
    end
    if not keyboardPressed('SPACE') then
        ringPlayAnim('static',false)
    end
    for ring = 0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes',ring,'noteType') == 'RingNote' then
            setPropertyFromGroup('notes',ring,'x',getProperty('RingStrum.x'))
            setPropertyFromGroup('notes',ring,'y',getProperty('RingStrum.y') + getPropertyFromGroup('notes',ring,'distance'))
            if getPropertyFromGroup('notes',ring,'canBeHit') and keyboardJustPressed('SPACE') then
                callOnLuas('goodNoteHit',{ring,getPropertyFromGroup('notes',ring,'noteData'),'RingNote',getPropertyFromGroup('notes',ring,'isSustainNote')})
                ringPlayAnim('confirm',true)
                removeFromGroup('notes',ring)
            end
        end
    end
end
function ringPlayAnim(anim,force)
    local offsetX = 20
    local offsetY = 20
    if anim == 'confirm' then
        offsetX = 48
        offsetY = 47
    elseif anim == 'press' then
        offsetX = 23
        offsetY = 23
    end
    objectPlayAnimation('RingStrum',anim,force)
    setProperty('RingStrum.offset.x',offsetX)
    setProperty('RingStrum.offset.y',offsetY)
end