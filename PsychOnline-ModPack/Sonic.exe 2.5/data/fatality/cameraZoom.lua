function onUpdate()
    if curStep < 1984 then
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.5)
        else
            setProperty('defaultCamZoom',0.7)
        end
    else
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.7)
        else
            setProperty('defaultCamZoom',0.8)
        end
    end
end