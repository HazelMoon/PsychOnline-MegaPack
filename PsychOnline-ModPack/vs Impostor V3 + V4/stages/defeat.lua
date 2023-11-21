function onCreate()
	-- background shit
	makeLuaSprite('defeat', 'defeat', 0, 0);
	setScrollFactor('defeat', 0.9, 0.9);
	
        makeLuaSprite('defeat', 'defeat', 0, 0);
	setLuaSpriteScrollFactor('defeat', 0.9, 0.9);
	scaleObject('defeat', 1.1, 1.1);

	addLuaSprite('defeat', false);
	addLuaSprite('defeat', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end