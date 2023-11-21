function onCreatePost()
    if string.match(string.lower(songName),'soulless') then
        setProperty('camGame.alpha',0)
        setProperty('camHUD.alpha',0)
    end
end
function onStepHit()
    if string.match(string.lower(songName),'soulless') then
        if curStep >= 3 then
            doTweenAlpha('heyGame','camGame',1,12,'linear')
        end
        if curStep == 64 then
            doTweenAlpha('helloHUD','camHUD',1,10,'linear')
        end
    end
end