local isPixel = false
local veloAdd = {0, 0, 0, 0}
local timingWindows = {}
local windowNames = {'sick', 'good', 'bad'}
local pixelShitPart1 = '';
local pixelShitPart2 = '';
local doStacking = true

function onCreate()
	-- luaDebugMode = true
    setProperty('showRating', false);
    setProperty('showComboNum', false);
	doStacking = getPropertyFromClass('backend.ClientPrefs', 'comboStacking')
    timingWindows = {getPropertyFromClass('backend.ClientPrefs','data.sickWindow'), getPropertyFromClass('backend.ClientPrefs','data.goodWindow'), getPropertyFromClass('backend.ClientPrefs','data.badWindow')};
	isPixel = getPropertyFromClass('states.PlayState', 'isPixelStage')

    if curStage == 'ejected' then
        veloAdd[4] = -1100
    elseif curStage == 'airship' then
        veloAdd[1] = -250
        veloAdd[3] = -550
    end
end

function goodNoteHit(i, noteData, noteType, isSustainNote)
    if not isSustainNote then
        popUpScore(getPropertyFromGroup('notes', i, 'strumTime'))
    end
end

local ratingCount = 0
function popUpScore(strumTime) --all of this is pretty much just the same code from playstate but recoded with lua instead
	if not getPropertyFromClass('backend.ClientPrefs', 'data.hideHud') then
		local noteDiff = math.abs(strumTime - getSongPosition() + getPropertyFromClass('backend.ClientPrefs','data.ratingOffset'))
		local rating = judgeNote(noteDiff)

		local sprName = 'rating'..ratingCount;
		if isPixel then
			pixelShitPart1 = 'pixelUI/';
			pixelShitPart2 = '-pixel';
		end

		makeLuaSprite(sprName, pixelShitPart1..rating..pixelShitPart2, 0, 0)
		setProperty(sprName..'.x', getProperty('gf.x') - 40)
		setProperty(sprName..'.y', getProperty('gf.y') - 60)

		setProperty(sprName..'.acceleration.x', veloAdd[3])
		setProperty(sprName..'.acceleration.y', 550 + veloAdd[4])
		setProperty(sprName..'.velocity.x', getProperty(sprName..'.velocity.x') - getRandomInt(0, 10) + veloAdd[1])
		setProperty(sprName..'.velocity.y', getProperty(sprName..'.velocity.y') - getRandomInt(140, 175) + veloAdd[2])

		if not isPixel then 
			scaleObject(sprName, 0.7, 0.7)
		else 
			scaleObject(sprName, 6 * 0.85, 6 * 0.85)
			setProperty(sprName..'.antialiasing', false)
		end

		addLuaSprite(sprName, true);
		updateHitbox(sprName);

		local combo = getProperty('combo')
		local combostr = tostring(combo)
		local curScore = ''

		while string.len(combostr) < 3 do
			combostr = '0'..combostr
		end
		if combo >= 10 or combo == 0 then 
			for i = 1, string.len(combostr) do
				curScore = string.sub(combostr, i, i)
				local comboName = ''..i..'combo'..ratingCount
				makeLuaSprite(comboName, pixelShitPart1..'num'..curScore..pixelShitPart2, 43 * i + getProperty(sprName..'.x') - 90, getProperty(sprName..'.y') + 120)

				if not isPixel then 
					scaleObject(comboName, 0.5, 0.5)
				else 
					scaleObject(comboName, 6, 6)
					setProperty(comboName..'.antialiasing', false)
				end

				updateHitbox(comboName);

				setProperty(comboName..'.acceleration.x', veloAdd[3])
				setProperty(comboName..'.acceleration.y', getRandomInt(200, 300) + veloAdd[4])
				setProperty(comboName..'.velocity.x', getRandomInt(-5, 5) + veloAdd[1])
				setProperty(comboName..'.velocity.y', getProperty(comboName..'.velocity.y') - getRandomInt(140, 160) + veloAdd[2])

				addLuaSprite(comboName, true)
                runTimer('combo'..ratingCount, crochet * 0.002, 1)
			end
		end

		runTimer(sprName, crochet * 0.001, 1)

		if doStacking then
			ratingCount = ratingCount + 1
		end
		if ratingCount > 50 then
			ratingCount = 0
		end
	end
end

function judgeNote(diff) --sorry i steal code bb
    diff = diff or 0
	for i=1, 3 do
		if diff <= timingWindows[round(math.min(i, 3))] then
			return windowNames[i];
		end
	end
	return 'shit';
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function onTimerCompleted(tag, loops, loopsLeft)
    if string.find(tag, 'rating') then --find rating timers
        doTweenAlpha(tag, tag, 0, 0.2, 'linear')
    end
    if string.find(tag, 'combo') then --find rating timers
        doTweenAlpha('1'..tag, '1'..tag, 0, 0.2, 'linear')
        doTweenAlpha('2'..tag, '2'..tag, 0, 0.2, 'linear')
        doTweenAlpha('3'..tag, '3'..tag, 0, 0.2, 'linear')
        if luaSpriteExists('4'..tag) then
            doTweenAlpha('4'..tag, '4'..tag, 0, 0.2, 'linear')
        end
    end
end

function onTweenCompleted(tag)
	if doStacking then
		if string.find(tag, 'rating') then 
			removeLuaSprite(tag)
		end
		if string.find(tag, 'combo') then 
			removeLuaSprite(tag)
		end
	end
end

-- local isPixel = false
-- local veloAdd = {0, 0, 0, 0}
-- local timingWindows = {}
-- local windowNames = {}
-- local pixelShitPart1 = '';
-- local pixelShitPart2 = '';
-- local doStacking = true

-- function onCreate()
--     setProperty('showRating', false);
--     setProperty('showComboNum', false);
-- 	doStacking = getPropertyFromClass('ClientPrefs', 'comboStacking')
-- 	-- doStacking = false
--     timingWindows = {getPropertyFromClass('ClientPrefs','sickWindow'), getPropertyFromClass('ClientPrefs','goodWindow'), getPropertyFromClass('ClientPrefs','badWindow')};
-- 	windowNames = {'sick', 'good', 'bad'}
-- 	isPixel = getProperty('isPixelStage')

-- 	if curStage == 'ejected' then
-- 		veloAdd[4] = -1100
-- 	elseif curStage == 'airship' then
-- 		veloAdd[1] = -250
-- 		veloAdd[3] = -550
-- 	end
-- end

-- function goodNoteHit(i, noteData, noteType, isSustainNote)
--     if not isSustainNote then
--         local strumTime = getPropertyFromGroup('notes', i, 'strumTime');
--         popUpScore(strumTime)
--     end
-- end

-- local ratingCount = 0
-- function popUpScore(strumTime) --all of this is pretty much just the same code from playstate but recoded with lua instead
-- 	if not getPropertyFromClass('ClientPrefs', 'hideHud') then
-- 		-- local gfOrder = getObjectOrder('dadGroup') - 1
-- 		local noteDiff = math.abs(strumTime - getSongPosition() + getPropertyFromClass('ClientPrefs','ratingOffset'))
-- 		local rating = judgeNote(noteDiff)

-- 		local sprName = 'rating'..ratingCount;

-- 		-- debugPrint(isPixel)
-- 		if isPixel then
-- 			pixelShitPart1 = 'pixelUI/';
-- 			pixelShitPart2 = '-pixel';
-- 		end

-- 		makeLuaSprite(sprName, pixelShitPart1..rating..pixelShitPart2, 0, 0)
-- 		setProperty(sprName..'.x', getProperty('gf.x') - 40)
-- 		setProperty(sprName..'.y', getProperty('gf.y') - 60)

-- 		setProperty(sprName..'.acceleration.x', veloAdd[3])
-- 		setProperty(sprName..'.acceleration.y', 550 + veloAdd[4])
-- 		setProperty(sprName..'.velocity.x', getProperty(sprName..'.velocity.x') - getRandomInt(0, 10) + veloAdd[1])
-- 		setProperty(sprName..'.velocity.y', getProperty(sprName..'.velocity.y') - getRandomInt(140, 175) + veloAdd[2])

-- 		local offset = getPropertyFromClass('ClientPrefs', 'comboOffset') --i dont think this works, but it doesnt cause any errors so uhhh

-- 		if not isPixel then 
-- 			scaleObject(sprName, 0.7, 0.7)
-- 			setProperty(sprName..'.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
-- 		else 
-- 			scaleObject(sprName, 6 * 0.85, 6 * 0.85)
-- 			setProperty(sprName..'.antialiasing', false)
-- 		end

-- 		addLuaSprite(sprName, true);
--         -- setProperty(sprName..'.active', false)
-- 		-- setObjectOrder(sprName, gfOrder)
-- 		updateHitbox(sprName);

-- 		local combo = getProperty('combo')
-- 		local combostr = tostring(combo)
-- 		local curScore = ''

-- 		while string.len(combostr) < 3 do
-- 			combostr = '0'..combostr
-- 		end

-- 		if combo >= 10 or combo == 0 then 
-- 			for i = 1, string.len(combostr) do
-- 				curScore = string.sub(combostr, i, i)
-- 				local comboName = ''..i..'combo'..ratingCount
-- 				makeLuaSprite(comboName, pixelShitPart1..'num'..curScore..pixelShitPart2, 43 * i + getProperty(sprName..'.x') - 90, getProperty(sprName..'.y') + 120)

-- 				if not isPixel then 
-- 					scaleObject(comboName, 0.5, 0.5)
-- 					setProperty(comboName..'.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
-- 				else 
-- 					scaleObject(comboName, 6, 6)
-- 					setProperty(comboName..'.antialiasing', false)
-- 				end

-- 				updateHitbox(comboName);

-- 				setProperty(comboName..'.acceleration.x', veloAdd[3])
-- 				setProperty(comboName..'.acceleration.y', getRandomInt(200, 300) + veloAdd[4])
-- 				setProperty(comboName..'.velocity.x', getRandomInt(-5, 5) + veloAdd[1])
-- 				setProperty(comboName..'.velocity.y', getProperty(comboName..'.velocity.y') - getRandomInt(140, 160) + veloAdd[2])

-- 				addLuaSprite(comboName, true)
--                 -- setProperty(comboName..'.active', false)
-- 				-- setObjectOrder(comboName, gfOrder)
-- 			end
-- 		end

-- 		runTimer(sprName, crochet * 0.001, 1)
-- 		runTimer('combo'..ratingCount, crochet * 0.002, 1)

-- 		if doStacking then
-- 			ratingCount = ratingCount + 1
-- 		end
-- 		-- debugPrint(ratingCount)
-- 		if ratingCount > 50 then
-- 			ratingCount = 0
-- 		end
-- 	end
-- end

-- function judgeNote(diff) --sorry i steal code bb
-- 	for i=1, 4 do
-- 		if diff <= timingWindows[round(math.min(i, 4))] then
-- 			return windowNames[i];
-- 		end
-- 	end
-- 	return 'shit';
-- end

-- function round(num, numDecimalPlaces)
-- 	local mult = 10^(numDecimalPlaces or 0)
-- 	return math.floor(num * mult + 0.5) / mult
-- end

-- function onTimerCompleted(tag, loops, loopsLeft)
--     if string.find(tag, 'rating') then --find rating timers
--         doTweenAlpha(tag, tag, 0, 0.2, 'linear')
--     end
--     if string.find(tag, 'combo') then --find rating timers
--         doTweenAlpha('1'..tag, '1'..tag, 0, 0.2, 'linear')
--         doTweenAlpha('2'..tag, '2'..tag, 0, 0.2, 'linear')
--         doTweenAlpha('3'..tag, '3'..tag, 0, 0.2, 'linear')
--         doTweenAlpha('4'..tag, '4'..tag, 0, 0.2, 'linear')
--     end
-- end

-- function onTweenCompleted(tag)
-- 	if doStacking then
-- 		if string.find(tag, 'rating') then 
-- 			removeLuaSprite(tag)
-- 		end
-- 		if string.find(tag, 'combo') then 
-- 			removeLuaSprite(tag)
-- 		end
-- 	end
-- end

-- -- function onBeatHit()
-- --     debugPrint(curBeat)
-- -- end