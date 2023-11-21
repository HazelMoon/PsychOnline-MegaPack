local changedNotes = false
function onStepHit()
    if curStep >= 1296 and not changedNotes then
        for i = 0, getProperty('unspawnNotes.length')-1 do
            --Check if the note is an Instakill Note
            if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'BendySplashNote' then
                setPropertyFromGroup('unspawnNotes', i, 'texture', 'bendy/BendySplashNoteDark');--Change texture
            end
            if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'BendyShadowNote' then
                setPropertyFromGroup('unspawnNotes', i, 'texture', 'bendy/BendyShadowNoteDark');--Change texture
            end
        end
        for notes = 0,getProperty('notes.length')-1 do
            if getPropertyFromGroup('notes', notes, 'noteType') == 'BendySplashNote' then
                setPropertyFromGroup('notes', notes, 'texture', 'bendy/BendySplashNoteDark');--Change texture
            end
            if getPropertyFromGroup('notes', notes, 'noteType') == 'BendyShadowNote' then
                setPropertyFromGroup('notes', notes, 'texture', 'bendy/BendyShadowNoteDark');--Change texture
            end
        end
        changedNotes = true
    end
end