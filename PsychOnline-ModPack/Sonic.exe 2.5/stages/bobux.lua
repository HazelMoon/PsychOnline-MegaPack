function onCreate()
	-- background shit
	makeLuaSprite('Destroyed', 'Destroyed', -600, -300);
	setScrollFactor('Destroyed', 0.9, 0.9);
	-- sprites that only load if Low Quality is turned off but no

	addLuaSprite('Destroyed', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end