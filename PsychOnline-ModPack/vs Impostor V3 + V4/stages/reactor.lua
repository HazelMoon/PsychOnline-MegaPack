function onCreate()
	-- background shit
	makeLuaSprite('reactorBG', 'reactorBG', -650, -570);
	setScrollFactor('reactorBG', 0.9, 0.9);
	
        makeLuaSprite('reactorBG', 'reactorBG', -650, -570);
	setLuaSpriteScrollFactor('reactorBG', 0.9, 0.9);
	scaleObject('reactorBG', 1.1, 1.1);

	addLuaSprite('reactorBG', false);
	addLuaSprite('reactorBG', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end