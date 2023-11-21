function onCreatePost()
    for strumLineNotes = 0,3 do
        setPropertyFromGroup('strumLineNotes', strumLineNotes,'texture','fatal')
        setPropertyFromGroup('strumLineNotes', strumLineNotes,'useRGBShader',false)
    end
    for notes = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', notes,'mustPress') == false and getPropertyFromGroup('unspawnNotes', notes,'texture') == '' then
            setPropertyFromGroup('unspawnNotes',notes,'texture','fatal')
            setPropertyFromGroup('unspawnNotes',notes,'rgbShader.enabled',false)
        end
    end
end