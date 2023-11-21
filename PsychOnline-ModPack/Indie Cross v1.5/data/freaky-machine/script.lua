function onUpdate(elapsed)
    if curStep > 694 then
        local currentBeat = (getSongPosition()/1000)*(bpm/80)
        doTweenY('dadFly', 'dad', 50 + (100*math.sin((currentBeat*0.25)*math.pi)),1)
    end
end
function onCreatePost()
    setProperty('boyfriend.color',getColorFromHex('B2B2B2'))
end