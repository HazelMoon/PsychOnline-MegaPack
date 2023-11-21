function onCreate()
	-- background shit
	makeLuaSprite('closed', 'closed', -600, -200);
	setLuaSpriteScrollFactor('closed', 0.9, 0.9);
        
	makeLuaSprite('floor-arcade', 'floor-arcade', -640, 600);
	setLuaSpriteScrollFactor('floor-arcade', 0.9, 0.9);
	scaleObject('floor-arcade', 1.1, 1.1);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		makeAnimatedLuaSprite('s&p', 's&p', 20, 200);
	        luaSpriteAddAnimationByPrefix('s&p', 's&p', 'Bottom Level Boppers', 24, true);
	        setLuaSpriteScrollFactor('s&p', 0.9, 0.9);
		
		makeAnimatedLuaSprite('crowd2', 'crowd2', -600, -220);
	        luaSpriteAddAnimationByPrefix('crowd2', 'crowd2', 'Bottom Level Boppers', 24, true);
	        setLuaSpriteScrollFactor('crowd2', 0.9, 0.9);

		makeAnimatedLuaSprite('crowd1', 'crowd1', -600, -220);
	        luaSpriteAddAnimationByPrefix('crowd1', 'crowd1', 'Upper Crowd Bob', 24, true);
	        setLuaSpriteScrollFactor('crowd1', 0.9, 0.9); 
	end

	addLuaSprite('closed', false);
        addLuaSprite('crowd2', false);
	addLuaSprite('floor-arcade', false);
        addLuaSprite('crowd1', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end