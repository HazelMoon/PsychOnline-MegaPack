local zoomed = false
function onStepHit()
    if not zoomed and curStep >= 1984 and not middlescroll then
        local camWidth = getProperty('camGame.width')
        for strumLine = 0,7 do
            setPropertyFromGroup('strumLineNotes',strumLine,'angle',-360)
            if strumLine < 2 then
                noteTweenX('GTPStrum'..strumLine,strumLine,camWidth/2 - 448  + (112 * strumLine),1,'quartOut')
            elseif strumLine >= 2 and strumLine < 4 then
                noteTweenX('GTPStrum'..strumLine,strumLine,camWidth/2 + (112 * strumLine),1,'quartOut')
            elseif strumLine >= 4 then
                noteTweenX('GTPStrum'..strumLine,strumLine,camWidth/2 - 224 + (112 * (strumLine - 4)),1,'quartOut')
            end
            if strumLine < 4 then
                noteTweenAlpha('WowTweenAlpha'..strumLine,strumLine,0.3,1,'linear')
            end
            noteTweenAngle('wowTweenAngle'..strumLine,strumLine,0,1,'quartOut')
            zoomed = true
        end
    end
end