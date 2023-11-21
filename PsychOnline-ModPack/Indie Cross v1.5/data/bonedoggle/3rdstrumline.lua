--[[
	CREDITS:
		- ShadowMario: made a multi-character script (from which I took animation offset)
		- Superpowers04: Helped with optimizing some code
		- MorenoTheCappuccinoChugger: Helped with note syncing (previous version on my youtube channel was off-sync)
		- BombasticTom (that's me!): Did most of the code.
--]]

local animationsList = {}

local defaultstrumy = 50
local songPosition

local defaultX

local offsetX

local safeZoneOffset

local isStrummin = false

local directions = {'left', 'down', 'up', 'right'}

function makeAnimationList(object)
	animationsList[0] = 'keyArrow' -- idle
	animationsList[1] = 'keyConfirm' -- key confirmed
	animationsList[2] = 'keyPressed' -- key miss
end

local offsets = {};

function makeOffset(object)
	offsets[0] = {x=36, y=36}
	offsets[1] = {x=63, y=59}
	offsets[2] = {x=34, y=34}
end
function onCreatePost()

	safeZoneOffset = getPropertyFromClass('Conductor', 'safeZoneOffset')/10

	defaultstrumy = 50

	defaultX = 100




	if middlescroll then

		
		defaultX = 0
		offsetX = 0

		if not downscroll then
			defaultstrumy = screenHeight - 50
	    else
			defaultstrumy = screenHeight - 670
		end

		
	else

		defaultX = 85
		offsetX = 6

		if downscroll then
			defaultstrumy = screenHeight - 50
		end

	end
	
	makeAnimationList('strum')
	makeOffset('strum')

	for strumLineLength=1, #directions do
		if not middlescroll then
			makeAnimatedLuaSprite('strum'..directions[strumLineLength], 'NOTE_assets', getPropertyFromGroup('opponentStrums', strumLineLength-1, 'x') - 500 - offsetX * strumLineLength, defaultstrumy)
		else
			makeAnimatedLuaSprite('strum'..directions[strumLineLength], 'NOTE_assets', getPropertyFromGroup('opponentStrums', strumLineLength-1, 'x') - defaultX - (offsetX * strumLineLength), defaultstrumy)
		end
		addAnimationByPrefix('strum'..directions[strumLineLength], 'keyConfirm', directions[strumLineLength]..' confirm', 24, false)
		addAnimationByPrefix('strum'..directions[strumLineLength], 'keyPressed', directions[strumLineLength]..' press', 24, false)
		addAnimationByPrefix('strum'..directions[strumLineLength], 'keyArrow', 'arrow'..directions[strumLineLength]:upper(), 24, false)

		setObjectCamera('strum'..directions[strumLineLength], 'camHUD')
		scaleObject('strum'..directions[strumLineLength], 0.68, 0.68)
		
		setProperty('strum'..directions[strumLineLength]..'.alpha', 0)
		
		addLuaSprite('strum'..directions[strumLineLength])

		--if middlescroll then
		--	setProperty('strum'..directions[strumLineLength]..'.visible', false)
		--end

		playAnimation('strum'..directions[strumLineLength], 0, true)
	end


end

function playAnimation(characterName, animId, forced) -- thank you shadowmario :imp:
	-- 0 = keyArrow
	-- 1 = keyConfirm
	-- 2 = keyPressed

	local animName = animationsList[animId]

	objectPlayAnimation(characterName, animName, forced); -- this part is easily broke if you use objectPlayAnim (I have no idea why its like this)
	
	setProperty(characterName..'.offset.x', offsets[animId].x);
	setProperty(characterName..'.offset.y', offsets[animId].y);
	
	if animId == 1 then
		runTimer('stopanim'..characterName, 0.1)
	end
end

function onTimerCompleted(tag)
	if(string.sub(tag,1,8) == "stopanim") then
        playAnimation(string.sub(tag,9), 0, true)
    end
end

function onUpdatePost()


	songPosition = getPropertyFromClass('Conductor', 'songPosition')

	-- NOTE: IF YOU WANT TO ADD STUFF THAT'LL UPDATE ONUPDATEPOST, PUT THEM BEFORE THE GAME COUNTS ALL 3RD STRUM NOTES

	for notesLength=0, getProperty('notes.length')-1 do
		if getPropertyFromGroup('notes', notesLength, 'noteType') == 'plr3' then

			if not isStrummin then
				return
			end

			local noteX = getPropertyFromGroup('notes', notesLength, 'x');
			local noteY = getPropertyFromGroup('notes', notesLength, 'y');

			setPropertyFromGroup('notes', notesLength, 'ignoreNote', true)

			local isSustainNote = getPropertyFromGroup('notes', notesLength, 'isSustainNote');
			
			local noteData = getPropertyFromGroup('notes', notesLength, 'noteData');
			
			local strumY = getProperty('strum'..directions[noteData + 1]..'.y')	

			noteX = getProperty('strum'..directions[noteData + 1]..'.x')
			local noteStrumTime = getPropertyFromGroup('notes', notesLength, 'strumTime')
			
			local hitMult = 1
			if isSustainNote then
				noteX = noteX + 37;
				hitMult = 0.5
			end

			if downscroll then
				noteY = strumY + 0.45 * (songPosition - noteStrumTime) * getProperty('songSpeed')
			else
				noteY = strumY - 0.45 * (songPosition - noteStrumTime) * getProperty('songSpeed')
			end
			
			setPropertyFromGroup('notes', notesLength, 'x', noteX)
			setPropertyFromGroup('notes', notesLength, 'y', noteY)
			
			if (noteStrumTime >= songPosition - safeZoneOffset and noteStrumTime <= songPosition + (safeZoneOffset * hitMult) and not isSustainNote) then
				removeFromGroup('notes', notesLength)
				playAnimation('strum'..directions[noteData+1], 1, false)

				if curStep >= 704 and curStep <=769 then

				characterPlayAnim('dad', 'sing'..directions[noteData+1]:upper()..'-alt', true);
				setProperty('dad.specialAnim',true)
				end

				if curStep > 320 and curStep < 704 or curStep > 769 and curStep< 1220 or curStep < 299 then
					characterPlayAnim('dad', 'sing'..directions[noteData+1]:upper(), true);
					setProperty('dad.specialAnim',true)
				end
			elseif (noteStrumTime >= songPosition - safeZoneOffset * 5 and noteStrumTime <= songPosition + (safeZoneOffset * 5 * hitMult) and isSustainNote) then
				removeFromGroup('notes', notesLength)
				playAnimation('strum'..directions[noteData+1], 1, false)

				if curStep >= 704 and curStep <=769 then
					characterPlayAnim('dad', 'sing'..directions[noteData+1]:upper()..'-alt', true);
					setProperty('dad.specialAnim',true)
				end
				if curStep > 320 and curStep < 704 or curStep > 769 and curStep< 1232 or curStep < 299 then
					characterPlayAnim('dad', 'sing'..directions[noteData+1]:upper(), true);
					setProperty('dad.specialAnim',true)
				end
			end
			
		end
	end
end

function tobool(val)
	if val:lower() =='true' then
		return true
	else
		return false
	end
end

function onEvent(n, v1, v2)
	if n == '3rdstrum' then
		isStrummin = tobool(v1)
		if tobool(v1) then
			for strum=1, #directions do

				setProperty('strum'..directions[strum]..'.y', defaultstrumy)

				if not middlescroll then
				 	doTweenAlpha('strumAlphaTweening'..strum, 'strum'..directions[strum], 1, 0.35 + 0.05*strum, 'easeInOut')
				 	doTweenX('strumX'..strum, 'strum'..directions[strum], defaultX + (offsetX * 17.3 * strum) - 190, 1.2, 'QuartOut')
				else
					
					doTweenY('strumTweening'..strum, 'strum'..directions[strum], defaultstrumy, 0.35 + 0.1*strum, 'QuartOut')
					doTweenAlpha('strumAlphaTweening'..strum, 'strum'..directions[strum], defaultstrumy, 0.35 + 0.05*strum, 'QuartOut')
				end
			end
		else
			for strum=1, #directions do
				if downscroll then
					doTweenY('strumTweening'..strum, 'strum'..directions[math.abs(strum-5)], 1, 'quadInOut')
				else
					doTweenY('strumTweening'..strum, 'strum'..directions[math.abs(strum-5)], 1, 'quadInOut')
				end
				doTweenAlpha('strumAlphaTweening'..strum, 'strum'..directions[math.abs(strum-5)], 0, 0.35 + 0.05*strum, 'easeInOut')
			end
		end
	end
end