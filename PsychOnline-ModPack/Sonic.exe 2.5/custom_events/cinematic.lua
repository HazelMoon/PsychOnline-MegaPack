function onEvent(name,v1,v2)
    if name == 'cinematic' then
        local bordersSize = 115
        local easing = 'quartOut'
        local duration = 1
        local enable = true
        local layer = 'hud'
        
        if v1 ~= '' then
            local comma1,comma2 = string.find(v1,',',0,true)
            if comma1 ~= nil then
                local comma3,comma4 = string.find(v1,',',comma2 + 1)
                if comma3 ~= nil then
                    bordersSize = tonumber(string.sub(v1,comma2 + 1,comma3 - 1))
                    layer = string.sub(v1,comma4 + 1)
                else
                    bordersSize = string.sub(v1,comma2 + 1)
                end
                enable = string.sub(v1,0,comma1 - 1)
            else
                enable = (string.lower(v1) ~= 'false')
            end
        end
        if bordersSize == nil then
            bordersSize = 115
        end
        
        if v2 ~= '' then
            local comma1,comma2 = string.find(v2,',',0,true)
            if comma1 ~= nil then
                duration = tonumber(string.sub(v2,0,comma1 - 1))
                easing = string.sub(v2,comma2 + 1)
            else
                if v2 ~= '' then
                    duration = tonumber(v2)
                else
                    duration = 0
                end
            end
        end
        for cinematicBorders = 1,2 do
            if enable then
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
                else
                    if cinematicBorders == 1 then
                        setProperty('cinematicBorders'..cinematicBorders..'.y',0)
                    else
                        setProperty('cinematicBorders'..cinematicBorders..'.y',screenHeight - bordersSize)
                    end
                end
                makeGraphic('cinematicBorders'..cinematicBorders,screenWidth,bordersSize,'000000')
                setObjectCamera('cinematicBorders'..cinematicBorders,layer)
                addLuaSprite('cinematicBorders'..cinematicBorders,false)
            else
                if duration ~= 0 then
                    cancelTween('cinematicBordersY'..cinematicBorders)
                    if cinematicBorders == 1 then
                        doTweenY('cinematicBordersYD'..cinematicBorders,'cinematicBorders'..cinematicBorders,bordersSize *-1,duration,easing)
                    else
                        doTweenY('cinematicBordersYD'..cinematicBorders,'cinematicBorders'..cinematicBorders,screenHeight,duration,easing)
                    end
                else
                    removeLuaSprite('cinematicBorders'..cinematicBorders,false)
                end
            end
        end
    end
end
function onTweenCompleted(tag)
    if string.match(tag,'cinematicBordersYD') then
        removeLuaSprite('cinematicBorders'..string.sub(tag,string.len(tag)),false)
    end
end