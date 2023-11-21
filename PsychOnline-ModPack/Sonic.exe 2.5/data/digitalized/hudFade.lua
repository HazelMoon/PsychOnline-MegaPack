function onCreate()
    setProperty('skipArrowStartTween',true)
end
function onCreatePost()
    for strumLineNotes = 0,7 do
        setPropertyFromGroup('strumLineNotes',strumLineNotes,'alpha',0)
    end
end