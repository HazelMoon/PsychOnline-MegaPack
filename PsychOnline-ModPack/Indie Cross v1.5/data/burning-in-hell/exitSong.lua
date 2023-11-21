--The script was made for when the song ends, not go for the next one. The bug happens when we are playing in story mode
function onEndSong()
    if exitSong == true and allowCountdownEnd == true and not seenCutscene and isStoryMode then
        exitSong(false)
        return Function_Stop;
    end
    return Function_Continue;
end