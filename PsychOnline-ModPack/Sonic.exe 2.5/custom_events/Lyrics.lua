local hideHud = false
local LyricsInExecutation = false
local lyricsFadeTime = 0.6
function onEvent(name,v1,v2)
    if name == 'Lyrics' then
        local textLyrics = v1
        local time = 0
        local color = ''
        local font = ''
        if v1 ~= '' then
            if string.find(string.lower(textLyrics),'--0x',0,true) then
                local comma1,comma2 = string.find(v1,'--0x',0,true)
                color = string.sub(v1,comma2 + 1,string.len(v1))
                textLyrics = string.sub(v1,0,comma1 - 1)
            end
            cancelTween('byeLyrics')
            if not luaTextExists('LyricsWow') then
                makeLuaText('LyricsWow',textLyrics,screenWidth,0,600)
                setTextSize('LyricsWow',24)
                setTextBorder('LyricsWow',1,'000000')
                setObjectCamera('LyricsWow','other')
                setProperty('LyricsWow.antialiasing',false)
                addLuaText('LyricsWow',true)
            else
                setTextString('LyricsWow',textLyrics)
                setProperty('LyricsWow.alpha',1)
            end
            if color ~= '' then
                setTextColor('LyricsWow',color)
            end
            if v2 ~= '' then
                if string.find(v2,',',0,true) ~= nil then
                    local comma1,comma2 = string.find(v2,',',0,true)
                    local hud = 'false'
                    if string.find(v2,',',comma2 + 1,true) ~= nil then
                        local comma3,comma4 = string.find(v2,',',comma2 + 1,true)
                        hud = string.lower(string.sub(v2,comma2+1,comma3 - 1))
                        lyricsFadeTime = tonumber(string.sub(v2,comma4 + 4))
                    end
                    time = tonumber(string.sub(v2,0,comma1 - 1))
                    if hud == 'true' then
                        doTweenAlpha('camLyrics','camHUD',0,0.6,'linear')
                        hideHud = true
                    end
                else
                    time = tonumber(v2)
                end
            end
            runTimer('removeLyricsEvent',time)
            if getPropertyFromClass('states.PlayState','isPixelStage') == true then
                font = 'PressStart2P.ttf'
            end
            if font ~= '' then
                setTextFont('LyricsWow',font)
            end
        end
        LyricsInExecutation = true
    elseif name == 'Close Lyrics' and LyricsInExecutation == true then
        refreshLyrics()
    end
end
function onTimerCompleted(tag)
    if tag == 'removeLyricsEvent' then
        doTweenAlpha('byeLyrics','LyricsWow',0,lyricsFadeTime,'linear')
    end
end
function refreshLyrics()
    if hideHud then
        doTweenAlpha('hudAlphaEvent','camHUD',1,0.6,'linear')
        hideHud = false
    end
    LyricsInExecutation = false
end
function onTweenCompleted(tag)
    if tag == 'byeLyrics' and not LyricsInExecutation then
        removeLuaText('LyricsWow',true)
    end
end
