function onCreate()
	-- background shit

		
	makeLuaSprite('BendySprite', 'bendy/first/Boi',0, 700);
	scaleObject('BendySprite',1,1)
    
	makeLuaSprite('BG', 'bendy/first/BG01', -800, 300);
    if not lowQuality then
	 makeLuaSprite('Pillar', 'bendy/first/Pillar', 1250, 0);
 	 setScrollFactor('Pillar',1.2,1)
	end

	makeAnimatedLuaSprite('MusicBox','bendy/first/MusicBox',500,850)
	addAnimationByPrefix('MusicBox','dance','Music box thingy instance 1',24,false)
	objectPlayAnimation('MusicBox','dance',false)

	addLuaSprite('BG', false);
    addLuaSprite('MusicBox', false);
	addLuaSprite('BendySprite',false)
	addLuaSprite('Pillar', true);

	if not lowQuality then
		makeAnimatedLuaSprite('Light','bendy/first/Light(Add-Blend)',getProperty('boyfriend.x'),400)
		addAnimationByPrefix('Light','Light','fezt instance 1',24,true)
		objectPlayAnimation('Light','Light',true)
		scaleObject('Light',1,1)
		addLuaSprite('Light', true);
		setObjectOrder('Light', getObjectOrder('Pillar') - 1 )
	end
end

function onStepHit()
	if curStep %2 == 0 then
	 	objectPlayAnimation('MusicBox','dance',false)
	end
end