function onEvent(name,v1,v2)
    if name == 'cinematic' then
        local bordersSize = '115'
        local easing = 'quartOut'
        local duration = 1
        local comma1v1 = 0
        local comma2v1 = 0
        local comma3v1 = 0
        local comma4v1 = 0
        local comma5v1 = 0
        local comma6v1 = 0

        local comma1v2 = 0
        local comma2v2 = 0
        local enable = 'true'
        local notesFollow = 'true'
        local layer = 'hud'
        
        if v1 ~= '' then
            comma1v1,comma2v1 = string.find(v1,',',0,true)
            if comma1v1 ~= nil then
                comma3v1,comma4v1 = string.find(v1,',',comma2v1 + 1)
                if comma3v1 ~= nil then
                    bordersSize = string.sub(v1,comma2v1 + 1,comma3v1 - 1)
                    comma5v1,comma6v1 = string.find(v1,',',comma4v1 + 1,true)
                    if comma5v1 ~= nil then
                        layer = string.lower(string.sub(v1,comma4v1 + 1,comma5v1 - 1))
                        notesFollow = string.lower(string.sub(v1,comma6v1 + 1))
                    else
                        layer = string.sub(v1,comma4v1 + 1)
                    end
                else
                    bordersSize = string.sub(v1,comma1v1 + 1)
                end
                enable = string.sub(v1,0,comma1v1 - 1)
            else
                enable = v1
            end
        end
        if bordersSize == '.' then
            bordersSize = 115
        end
        if layer == '.' then
            layer = 'hud'
        end
        
        if v2 ~= '' then
            comma1v2,comma2v2 = string.find(v2,',',0,true)
            if comma1v2 ~= nil then
                duration = tonumber(string.sub(v2,0,comma1v2 - 1))
                easing = string.sub(v2,comma2v2 + 1)
            else
                if v2 ~= '' then
                    duration = tonumber(v2)
                else
                    duration = 0
                end
            end
        end
        for cinematicBorders = 1,2 do
            if enable ~= 'false' then
                if cinematicBorders == 1 then
                    makeLuaSprite('cinematicBorders'..cinematicBorders,nil,0,bordersSize * -1)
                else
                    makeLuaSprite('cinematicBorders'..cinematicBorders,nil,0,screenHeight)
                end
                if duration ~= 0 then
                    if cinematicBorders == 1 then
                        doTweenY('cinematicBordersY'..cinematicBorders,'cinematicBorders'..cinematicBorders,0,duration,easing)
                    else
                        doTweenY('cinematicBordersY'..cinematicBorders,'cinematicBorders'..cinematicBorders,screenHeight - bordersSize,duration,easing)
                    end
                    if notesFollow == 'true' then
                        for strumLineNotes = 0,7 do
                            if downscroll == false then
                                noteTweenY('noteFollowBorders'..strumLineNotes,strumLineNotes,bordersSize,duration,easing)
                            else
                                noteTweenY('noteFollowBorders'..strumLineNotes,strumLineNotes,screenHeight - 105 - bordersSize,duration,easing)
                            end
                        end
                    end
                else
                    if cinematicBorders == 1 then
                        setProperty('cinematicBorders'..cinematicBorders..'.y',0)
                    else
                        setProperty('cinematicBorders'..cinematicBorders..'.y',screenHeight - bordersSize)
                    end
                    if notesFollow == 'true' then
                        for strumLineNotes = 0,7 do
                            if downscroll == false then
                                setPropertyFromGroup('strumLineNotes',strumLineNotes,'y',bordersSize)
                            else
                                setPropertyFromGroup("strumLineNotes",strumLineNotes,'y',screenHeight - 105 - bordersSize)
                            end
                        end
                    end
                end
                makeGraphic('cinematicBorders'..cinematicBorders,screenWidth,bordersSize,'000000')
                setObjectCamera('cinematicBorders'..cinematicBorders,layer)
                addLuaSprite('cinematicBorders'..cinematicBorders,false)
            else
                if duration ~= 0 then
                    if notesFollow == 'true' then
                        for strumLineNotes = 0,7 do
                            if downscroll == false then
                                noteTweenY('noteFollowBorders'..strumLineNotes,strumLineNotes,50,duration,easing)
                            else
                                noteTweenY('noteFollowBorders'..strumLineNotes,strumLineNotes,screenHeight - 150,duration,easing)
                            end
                            
                        end
                    end
                    if cinematicBorders == 1 then
                        doTweenY('cinematicBordersY'..cinematicBorders,'cinematicBorders'..cinematicBorders,bordersSize *-1,duration,easing)
                    else
                        doTweenY('cinematicBordersY'..cinematicBorders,'cinematicBorders'..cinematicBorders,screenHeight,duration,easing)
                    end
                else
                    if notesFollow == 'true' then
                        for strumLineNotes = 0,7 do
                            setPropertyFromGroup('strumLineNotes',strumLineNotes,'y',50)
                        end
                    end
                    removeLuaSprite('cinematicBorders'..cinematicBorders,false)
                end
            end

        end
    end
end