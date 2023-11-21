local battleMode = false
local altBG = false
function onCreate()
    if songName == 'Burning-In-Hell' then
		makeLuaSprite('SansBG','sans/halldark',0,100)
		scaleObject('SansBG',1.55,1.5)
		addLuaSprite('SansBG', false);

		makeLuaSprite('SansBattle','sans/battle',0,-800)
		scaleObejct('SansBattle',1.55,1.5)
		precacheImage('sans/battle')
	else
		makeLuaSprite('SansBG','sans/hall',0,100)
		scaleObject('SansBG',1.55,1.5)
		addLuaSprite('SansBG', false);
		if songName == 'Final-Stretch' then
			makeLuaSprite('SansBG-Alt','sans/Waterfall',-450,-100)
			scaleObject('SansBG-Alt',1.55,1.5)
			precacheImage('sans/Waterfall')
		end
	end
end
function sansBGAttack(enable)
	if battleMode ~= enable then
		if enable then
			addLuaSprite('SansBattle',false)
			removeLuaSprite('SansBG',false)
			setProperty('defaultCamZoom',0.4)
			setProperty('dadGroup.x',getProperty('dadGroup.x') + 520)
			setProperty('dadGroup.y',getProperty('dadGroup.y') - 600)
			setProperty('boyfriendGroup.x',getProperty('boyfriendGroup.x') - 470)
			setProperty('boyfriendGroup.y',getProperty('boyfriendGroup.y') - 50)
		else
			setProperty('dadGroup.x',getProperty('dadGroup.x') - 520)
			setProperty('dadGroup.y',getProperty('dadGroup.y') + 600)
			setProperty('boyfriendGroup.x',getProperty('boyfriendGroup.x') + 470)
			setProperty('boyfriendGroup.y',getProperty('boyfriendGroup.y') + 50)
			removeLuaSprite('SansBattle',false)
			addLuaSprite('SansBG',false)
			BfFly = false
			cancelTween('boyfriendTweenY')
			setProperty('defaultCamZoom',0.9)
		end
		battleMode = enable
	end
end
function onStepHit()
	if songName == 'Final-Stretch' then
		if not altBG and curStep >= 765 and curStep < 1277 then
			addLuaSprite('SansBG-Alt',false)
			removeLuaSprite('SansBG',false)
			altBG = true
		elseif altBG and curStep >= 1277 then
			addLuaSprite('SansBG',false)
			removeLuaSprite('SansBG-Alt',true)
			altBG = false
		end
	elseif songName == 'Burning-In-Hell' then
		if not battleMode and (curStep >= 379 and curStep < 896 or curStep >= 1146 and curStep < 1408) then
			sansBGAttack(true)
		end
		if battleMode and (curStep >= 896 and curStep < 1146 or curStep > 1408) then
			sansBGAttack(false)
		end
	end
end

