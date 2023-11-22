local songSpeed = 0
kaderEngine = false
missLimited = false
missLimitCount = 0

function onCreatePost()
	if timeBarType ~= 'Disabled' then
		setProperty('timeBarBG.visible', true)
		setProperty('timeBar.visible', true)
		setProperty('timeTxt.visible', true)
		setProperty('scoreTxt.visible', true)
	end

	loadGraphic('timeBarBG', 'impostorTimeBar')
	setProperty('timeBarBG.color', getColorFromHex('FFFFFF'))
	setProperty('timeBar.x', getProperty('timeBar.x') - 337)
	runHaxeCode([[
		game.timeBar.createFilledBar(0xFF2e412e, 0xFF44d844);
	]])

	setTextAlignment('timeTxt', 'left')
	setProperty('timeTxt.x', getProperty('timeTxt.x') - 330)
	if downscroll then
		setProperty('timeTxt.y', screenHeight - 36)
	else
		setProperty('timeTxt.y', 20)
	end
	setTextString('timeTxt', string.upper(getTextString('timeTxt')))
	setTextSize('timeTxt', 14)
	setProperty('timeTxt.borderSize', 1)

	if missLimited then
		setProperty('scoreTxt.color', getColorFromHex('FF0000'))
		setProperty('botplayTxt.color', getColorFromHex('FF0000'))

		setProperty('healthGain', 0)
		setProperty('healthLoss', 0)
		setProperty('healthBar.visible', false)
		setProperty('healthBarBG.visible', false)
		setProperty('healthBarBG.active', false)
	else
		setProperty('scoreTxt.color', getIconColor('dad'))
		setProperty('botplayTxt.color', getIconColor('dad'))
	end

	setProperty('iconP2.origin.x',80)
	setProperty('iconP1.origin.y',0)
	setProperty('iconP1.origin.x',20)
	setProperty('iconP2.origin.y',0)

	songSpeed = playbackRate
	setRating()
end

function noteMiss() missed() end function noteMissPress() missed() end
function goodNoteHit() setRating() end
function missed()
	setRating()
	if missLimited and misses > missLimitCount then setProperty('health', -1) end -- die
end

local scoreY = 0
function kaderToggle()
	kaderEngine = not kaderEngine

	if kaderEngine then
		setProperty('scoreTxt.size', 16)
		scoreY = getProperty('scoreTxt.y')
		if downscroll then
			setProperty('scoreTxt.y', scoreY + 24)
		else
			setProperty('scoreTxt.y', screenHeight - 16)
		end
		if missLimited then
			setProperty('iconP1.visible', false)
			setProperty('iconP2.visible', false)
		end
		if songName == 'Defeat' then
			setPropertyFromClass('substates.GameOverSubstate', 'loopSoundName', 'death/gameOverEmpty');
			setPropertyFromClass('substates.GameOverSubstate', 'endSoundName', 'death/gameOverEndEmpty');
		else
			setPropertyFromClass('substates.GameOverSubstate', 'loopSoundName', 'death/gameOver');
			setPropertyFromClass('substates.GameOverSubstate', 'endSoundName', 'death/gameOverEnd');
		end
		setProperty('scoreTxt.color', getColorFromHex('FFFFFF'))
		setProperty('botplayTxt.color', getColorFromHex('FFFFFFF'))
	else
		setProperty('scoreTxt.size', 20)
		setProperty('scoreTxt.y', scoreY)

		if missLimited then
			setProperty('iconP1.visible', true)
			setProperty('iconP2.visible', true)
			setProperty('scoreTxt.color', getColorFromHex('FF0000'))
			setProperty('botplayTxt.color', getColorFromHex('FF0000'))
		else
			setProperty('scoreTxt.color', getIconColor('dad'))
			setProperty('botplayTxt.color', getIconColor('dad'))
		end
	end
	callScript('scripts/pauseDeath', 'setDeathAssets')
	setRating()
end

local rateText = ''
local scored = ''
local missed = ''
local wifeConditions = {
    {99.9935, 'AAAAA'}, -- AAAAA
    {99.980, 'AAAA:'}, -- AAAA:
    {99.970, 'AAAA.'}, -- AAAA.
    {99.955, 'AAAA'}, -- AAAA
    {99.90, 'AAA:'}, -- AAA:
    {99.80, 'AAA.'}, -- AAA.
    {99.70, 'AAA'}, -- AAA
    {99, 'AA:'}, -- AA:
    {96.50, 'AA.'}, -- AA.
    {93, 'AA'}, -- AA
    {90, 'A:'}, -- A:
    {85, 'A.'}, -- A.
    {80, 'A'}, -- A
    {70, 'B'}, -- B
    {60, 'C'}, -- C
    {0, 'D'}, -- D
}

function setRating()
    rateText = '?'
    if not kaderEngine then
		scored = '?'
		missed = '?'
        if not botPlay then
            scored = score
			missed = misses..(missLimited and (' / '..missLimitCount) or '')
            if ratingName ~= '?' then
                rateText = round(rating * 100, 2)..'%'..((misses == 0) and (' ['..ratingFC..']') or '')
			end
        end
    else
		scored = score
		missed = misses
        if ratingName == '?' then
            rateText = '0%'..missLimited and ' | N/A' or ' | BotPlay'
        else
            rateText = round(rating * 100, 2)..'% | ('..string.gsub(ratingFC, 'SFC', 'MFC')..') '
            for _, v in ipairs(wifeConditions) do
                if rating * 100 >= v[1] then
                    rateText = rateText .. v[2]
                    break
                end
            end
        end
    end
	setTextString('scoreTxt', 'Score: '..scored.. ' | Combo Breaks: '..missed.. ' | Accuracy: '..rateText)
end

function getIconColor(chr)
	return getColorFromHex(rgbToHex(getProperty(chr .. ".healthColorArray")))
end

function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end

function onUpdatePost(elapsed)
	setProperty('iconP1.scale.x', lerp(1, getProperty('iconP1.scale.x'), boundTo((1 - (elapsed * 30)) / songSpeed, 0, 1)))
	setProperty('iconP2.scale.x', lerp(1, getProperty('iconP2.scale.x'), boundTo((1 - (elapsed * 30)) / songSpeed, 0, 1)))
end

function boundTo(value, min, max)
	return math.max(min, math.min(max, value))
end

function lerp(from,to,i)
	return from+(to-from)*i
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end