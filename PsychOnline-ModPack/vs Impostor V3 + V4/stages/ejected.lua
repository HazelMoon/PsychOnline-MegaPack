function onCreate()
	-- background shit
	makeLuaSprite('ejected', 'ejected', -400, -250);
	setScrollFactor('ejected', 0.9, 0.9);
	
        makeLuaSprite('ejected', 'ejected', -1210, -400);
	setLuaSpriteScrollFactor('ejected', 0.9, 0.9);
	scaleObject('ejected', 1.1, 1.1);

	addLuaSprite('ejected', false);
	addLuaSprite('ejected', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end