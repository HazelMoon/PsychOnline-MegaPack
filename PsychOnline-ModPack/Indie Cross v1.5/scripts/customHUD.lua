local haveDodge = false
local haveAttack = false
local enableTimer = false

local songLength = 0
function onCreatePost()
    if songName == 'Despair' or songName == 'Last-Reel' or songName == 'Sansational' or songName == 'Burning-In-Hell' then
        haveDodge = true
    else
        for events = 0,getProperty('eventNotes.length')-1 do
            local eventName = getPropertyFromGroup('eventNotes',events,'event')
            if eventName == 'CupheadAttack' or eventName == 'CupheadDoubleAttack' or eventName == 'SansDodge' or eventName == 'Devil Dodge' then
                haveDodge = true
            elseif eventName == 'CupheadShooting' then
                haveAttack = true
            end
        end
    end
    if haveAttack then
        makeAnimatedLuaSprite('AttackButton','IC_Buttons',-6,245)
        scaleObject('AttackButton',0.5,0.5)
        setProperty('AttackButton.alpha',0.5)
        addAnimationByPrefix('AttackButton','normal','Attack instance 1',0,true)
        addAnimationByPrefix('AttackButton','clicked','Attack Click instance 1',24,false)
        addAnimationByPrefix('AttackButton','NA','AttackNA instance 1',24,false)
        setObjectCamera('AttackButton','hud')
        setProperty('AttackButton.offset.x',0)
        setProperty('AttackButton.offset.y',0)
        addLuaSprite('AttackButton',false)
    end
    if haveDodge then
        makeAnimatedLuaSprite('DodgeButton','IC_Buttons',-6,335)
        scaleObject('DodgeButton',0.5,0.5)
        setProperty('DodgeButton.alpha',0.5)
        addAnimationByPrefix('DodgeButton','normal','Dodge instance 1',0,true)
        addAnimationByPrefix('DodgeButton','clicked','Dodge click instance 1',24,false)
        setObjectCamera('DodgeButton','hud')
        setProperty('DodgeButton.offset.x',0)
        setProperty('DodgeButton.offset.y',0)
        addLuaSprite('DodgeButton',false)
    end
    local stage = getPropertyFromClass('PlayState','curStage')
    local font = nil
    local size = getTextSize('scoreTxt')
    local textOffY = 0
    local border = nil
    local antialiasing = true
    if string.match(stage,'factory') == 'factory' or stage == 'freaky-machine' then
        font = 'DK Black Bamboo.ttf'
    elseif stage == 'field' or stage == 'field-rain' or stage == 'devilHall' or stage == 'devilHall-nightmare' then
        font = 'memphis.otf'
        textOffY = 4
    elseif string.match(stage,'hall') == 'hall' or stage == 'void' then
        font = 'Comic Sans MS.ttf'
        textOffY = 7
    elseif stage == 'papyrus' then
        font = 'Papyrus Font [UNDETALE].ttf'
        antialiasing = false
    end
    if font ~= '' then
        setTextFont('scoreTxt',font)
        setTextFont('timeTxt',font)
    end
    if size ~= getTextSize('scoreTxt') then
        setTextSize('scoreTxt',size)
        setTextSize('timeTxt',size)
    end
    if border ~= nil then
        setTextBorder('scoreTxt',border,'000000')
        setTextBorder('timeTxt',border,'000000')
    end
    setProperty('scoreTxt.antialiasing',antialiasing)
    setProperty('timeTxt.antialiasing',antialiasing)
    if getPropertyFromClass('ClientPrefs','timeBarType') ~= 'Disabled' then
        enableTimer = true
        scaleObject('timeBarBG',1.5,1)
        setProperty('timeBarBG.color',getColorFromHex('808080'))
        scaleObject('timeBar',1.5,1)
        setProperty('timeBar.visible',false)
        setProperty('timeBar.color',getColorFromHex('FFF0000'))
        setProperty('timeBarBG.offset.x',0)
        setProperty('timeBar.offset.x',0)

        makeLuaText('timeTxtIC',songName,350,0,0)
        setObjectCamera('timeTxtIC','hud')
        addLuaText('timeTxtIC',true)
        setTextSize('timeTxtIC',20)
        setObjectOrder('timeTxtIC',getObjectOrder('timeTxt'))
        setProperty('timeTxtIC.offset.y',textOffY)
        setProperty('timeTxt.visible',false)
        if font ~= nil then
           setTextFont('timeTxtIC',font)
        end
        makeLuaSprite('timeBarIC',nil,0,0)
        makeGraphic('timeBarIC',getProperty('timeBar.width'),getProperty('timeBar.height'),'FFFFFF')
        setObjectCamera('timeBarIC','hud')
        addLuaSprite('timeBarIC',false)
        setObjectOrder('timeBarIC',getObjectOrder('timeBar'))
        updateBarColor()
    end
end
function onSongStart()
    if songName == 'Imminent-Demise' and curStep < 1129 then
        songLength = 70000
    else
        songLength = getProperty('songLength')
    end
end
function updateBarColor()
    local dad = getProperty('dad.curCharacter')
    if dad == 'sans-ic' or dad == 'sans-ic-wt' or dad == 'sans-phase2' or dad == 'sans-phase3' or dad == 'sans-tired' then
        setProperty('timeBarIC.color',getColorFromHex(rgb({39,74,122})))
    else
        setProperty('timeBarIC.color',getColorFromHex(rgb({getProperty('dad.healthColorArray[0]'),getProperty('dad.healthColorArray[1]'),getProperty('dad.healthColorArray[2]')})))
    end
end
function rgb(rgb)
    --Credits to marceloCodget for the script = https://gist.github.com/marceloCodget/3862929
	local hexadecimal = ''
	for key, value in pairs(rgb) do
		local hex = ''

		while(value > 0)do
			local index = math.fmod(value, 16) + 1
			value = math.floor(value / 16)
			hex = string.sub('0123456789ABCDEF', index, index) .. hex
		end

		if(string.len(hex) == 0)then
			hex = '00'

		elseif(string.len(hex) == 1)then
			hex = '0' .. hex
		end
		hexadecimal = hexadecimal .. hex
	end
    return hexadecimal
end
function onUpdate()
    local ratingS = getProperty('ratingFC')
    if ratingS ~= '' then
        ratingS = '('..getProperty('ratingFC')..')'
    else
        ratingS = 'N/A'
    end
    local score = getProperty('songScore')
    local misses = getProperty('songMisses')
    local rating = math.floor(getProperty('ratingPercent') * 10000)/100
    if songName ~= 'Saness' then
        setTextString('scoreTxt','Score: '..score..' | Misses: '..misses..' | Accurancy: '..rating..' | '..ratingS)
    else
        setTextString('scoreTxt','Social Credit Points: '..score..' | Skill Issues: '..misses..' | Wackyness: '..rating..' % | '..ratingS)
    end
    if haveDodge then
        if keyJustPressed('space') then
            objectPlayAnimation('DodgeButton','clicked',true)
            setProperty('DodgeButton.offset.x',-5)
            setProperty('DodgeButton.offset.y',-7)
        end
        if keyReleased('space') then
            objectPlayAnimation('DodgeButton','normal',true)
            setProperty('DodgeButton.offset.x',0)
            setProperty('DodgeButton.offset.y',0)
        end
    end
    if haveAttack then
        if getPropertyFromClass('flixel.FlxG','keys.justPressed.SHIFT') then
            objectPlayAnimation('AttackButton','clicked',true)
            setProperty('AttackButton.offset.x',-7)
            setProperty('AttackButton.offset.y',-5)
        end
        if getPropertyFromClass('flixel.FlxG','keys.justReleased.SHIFT') then
            setProperty('AttackButton.offset.x',0)
            setProperty('AttackButton.offset.y',0)
            objectPlayAnimation('AttackButton','normal',true)
        end
    end
    if enableTimer then
        setProperty('timeTxtIC.alpha',getProperty('timeTxt.alpha'))
        setProperty('timeTxtIC.x',getProperty('timeTxt.x') + 25)
        setProperty('timeTxtIC.y',getProperty('timeTxt.y') + 6)

        setProperty('timeBarIC.alpha',getProperty('timeBar.alpha'))
        if getSongPosition() <= songLength then
            setProperty('timeBarIC.scale.x',(getSongPosition()/songLength))
        end
        setProperty('timeBarIC.offset.x',192 - (getProperty('timeBarIC.width') * getProperty('timeBarIC.scale.x')/2))
        setProperty('timeBarIC.x',getProperty('timeBar.x') - 202)
        setProperty('timeBarIC.y',getProperty('timeBar.y'))
    end
end
function onStepHit()
    if songName == 'Imminent-Demise' and curStep >= 1129 then
        songLength = 174681
    end
end