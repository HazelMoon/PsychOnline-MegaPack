function onCreate()
	-- background shit
	makeLuaSprite('NM-BG', 'bendy/inky depths',-500, -400);
	scaleObject('NM-BG',1.8,1.8)
	setScrollFactor('NM-BG',0.6,0.6)
	precacheImage('bendy/inky depths')
	addLuaSprite('NM-BG',false)
	if songName == 'Despair' then
		setProperty('NM-BG.alpha',0.001)

		makeAnimatedLuaSprite('BendyFire','bendy/Fyre',500,800)
		addAnimationByPrefix('BendyFire','FireDance','Penis instance 1',24,true)
		objectPlayAnimation('BendyFire','FireDance',false)
		scaleObject('BendyFire',1.9,1.9)
		addLuaSprite('BendyFire',false)
	end

	makeLuaSprite('BendyGround', 'bendy/nightmareBendy_foreground',-220, -100);
	precacheImage('bendy/nightmareBendy_foreground')
	scaleObject('BendyGround',2,2)

	addLuaSprite('BendyGround', false)
end
--[[function onUpdate()
	if getProperty('dad.curCharacter') ~= 'Nightmare-Bendy' then
		setProperty('dad.color',getColorFromHex('FFE97F'))
	end
	if getProperty('boyfriend.curCharacter') ~= 'bf-bendy-nm' then
		setProperty('boyfriend.color',getColorFromHex('FFE97F'))
	end
end]]--
function onStepHit()
	if songName == 'Despair' then
		if curStep == 1297 or curStep == 2064 then
			doTweenAlpha('BendyBG','NM-BG',1,3,'linear')

		elseif curStep == 1860 then
			doTweenAlpha('BendyBG','NM-BG',0,1,'linear')

		elseif curStep == 3216 then
			doTweenY('FireUp', 'BendyFire',-100, 10, 'QuartOut')

		end
	end
end