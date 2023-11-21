function onEvent(name,v1,v2)
    if name == 'objectAlpha' then
        local comma1v1 = 0
		local comma2v1 = 0
        local comma1v2 = 0
		local comma2v2 = 0
        local object = ''
        local target = 1
        local time = 1
        local easing = 'linear'
		comma1v1,comma2v1 = string.find(v1,',',0,true)
        comma1v2,comma2v2 = string.find(v2,',',0,true)
        if comma1v1 ~= nil then
            object = string.sub(v1,0,comma1v1 - 1)
            target = string.sub(v1,comma2v1 + 1)
        else
            object = v1
        end
        if comma1v2 ~= nil then
            time = tonumber(string.sub(v2,0,comma2v1 - 1))
            easing = string.sub(v2,comma2v1 + 1)
        else
            if v2 ~= '' then
                time = tonumber(v2)
            end
        end
        if object ~= '' then
            if time ~= 0 then
                doTweenAlpha(object..'alphaEvent',object,target,time,easing)
            else
                setProperty(object..'.alpha',target)
            end
        end
    end
end