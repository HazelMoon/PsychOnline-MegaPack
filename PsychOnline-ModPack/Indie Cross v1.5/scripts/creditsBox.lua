local detect = true
function onCreate()
    local text = ''
    local font = ''
    if songName == 'Knockout' then
        text = 'Orenji Music - '

    elseif songName == 'Snake-Eyes' then
        text = 'Mike Geno - '
        

    elseif songName == 'Technicolor-Tussle' then
        text = 'BLVKAROT - '

    elseif songName == 'Devils-Gambit' then
        text = 'Saru & TheInnuend0 - '
        
    elseif songName == 'Satanic-Funkin' then
        text =  'Saru & TheInnuend0 -'
    
    elseif songName == 'Bad-Time' then
        text = 'Tenzubushi - ' 
        
    elseif songName == 'Despair' then
        text = 'CDMusic, Joan Atlas and Rozebud -'
        
    elseif songName == 'Whoopee' then
        text = 'yingyang48 & Saster - '

    elseif songName == 'Sansational' then
        text = 'Tenzubushi - '

    elseif songName == 'Final-Stretch' then
        text = 'Saru - '

    elseif songName == 'Burning-In-Hell' then
        text = 'TheInnuenedo & Saster - '

    elseif songName == 'imminent-demise' then
        text = 'Saruky, CDMusic - '

    elseif songName == 'Terrible-Sin' then
        text = 'CDMusic, Rozebud - '

    elseif songName == 'Last-Reel' then
        text = 'Joan Atlas - '

    elseif songName == 'Nightmare-Run' then
        text = 'Orenji Music, Rozebud - '

    elseif songName == 'Ritual' then
        text = 'BBPanzu and Brandxns - '

    elseif songName == 'Freaky-Machine' then
        text = 'DAGames and Saster - '

    elseif songName == 'build-our-freaky-machine' then
        text = 'Astro Galaxy - '


    elseif songName == 'Bonedoggle' then
        text = 'Saster - '

    elseif songName == 'Bad-To-The-Bone' then
        text = 'Yamahearted - '

    elseif songName == 'Saness' or songName == 'Gose' then
        text = 'CrystalSlime - '

    else
        detect = false
    end
    if detect then
        local stage = getPropertyFromClass('PlayState','curStage')
        local antialiasing = true
        local offsetY = 0
        if string.match(stage,'factory') == 'factory' or stage == 'freaky-machine' then
            font = 'DK Black Bamboo.ttf'
        elseif stage == 'field' or stage == 'field-rain' or stage == 'devilHall' or stage == 'devilHall-nightmare' then
            font = 'memphis.otf'
            offsetY = 6
        elseif stage == 'hall' or stage == 'void' then
            font = 'Comic Sans MS.ttf'
            offsetY = 11
        elseif stage == 'papyrus' then
            font = 'Papyrus Font [UNDETALE].ttf'
            antialiasing = false
        end
        makeLuaSprite('JukeBox', 'ICImages/musicBar', 1280, 500)
        setProperty('JukeBox.alpha', 0.7)
        setObjectCamera('JukeBox', 'other')
        addLuaSprite('JukeBox', true)


        local songNameText = string.gsub(songName,'-',' ')
                
        makeLuaText('JukeBoxText',text..songNameText, 1000, 0, 516)
        setTextFont('JukeBoxText',font)
        setTextBorder('JukeBoxText',0)
        setTextAlignment('JukeBoxText', 'left')
        setObjectCamera('JukeBoxText', 'other')
        setTextSize('JukeBoxText', 35)
        setProperty('JukeBoxText.offset.y',offsetY)
        addLuaText('JukeBoxText',true)
        setProperty('JukeBoxText.antialiasing',antialiasing)
        setTextColor('JukeBoxText','A8AAAF')
        addLuaText('JukeBoxText')

    end
end
function onUpdate()
    if detect then
        setProperty('JukeBoxText.x', getProperty('JukeBox.x') + 50)
    end
end
function onSongStart()
    if detect then
        doTweenX('heyBoxText', 'JukeBox', 550, 0.5, 'CircOut')
        runTimer('JukeBoxWait', 3, 1)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'JukeBoxWait' then
        doTweenX('MoveInTwo2', 'JukeBox', 3333, 1, 'CircInOut')
    end
end

function onTweenCompleted(tag)
    if tag == 'MoveInFour2' then
        removeLuaSprite('JukeBox',true)
        removeLuaText('JukeBoxText',true)
    end
end