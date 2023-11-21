local speed = 0
local target = 0
local default = 0.05

function onCreatePost()
    local stage = getPropertyFromClass('PlayState','curStage')
    local founded = true
    if string.match(stage,'factory') or stage == 'devilHall-nightmare' then
        --default = -0.05
        speed = 0.5
        target = 0.05
        if stage == 'factory' then
            speed = 0.2
        end
    elseif stage == 'hall' and songName == 'Burning-In-Hell' then
        --default = -0.04
        speed = 0.2
        target = 0.06
    else
        founded = false
    end
    if founded then
        makeLuaSprite('DarkenEffect','',0,0)
        makeGraphic('DarkenEffect',screenWidth,screenHeight,'646464')
        setObjectCamera('DarkenEffect','other')
        setProperty('DarkenEffect.alpha',0)
        addLuaSprite('DarkenEffect',true)
        setBlendMode('DarkenEffect','SUBTRACT')
    end
end
function onUpdate()
    if target ~= 0 then
        setProperty('DarkenEffect.alpha',default + (math.sin((getSongPosition()/1000) * (bpm/60) * speed) * target) * 7)
    end
end