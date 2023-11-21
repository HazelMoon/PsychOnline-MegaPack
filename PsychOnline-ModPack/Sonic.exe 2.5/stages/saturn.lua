function onCreate()
	-- background shit
	makeLuaSprite('sky', 'xterion/sky', -500, -400);
	setLuaSpriteScrollFactor('sky', 0.6, 0.6);
	scaleObject('sky', 1.1, 1.1);
	
	makeLuaSprite('floor', 'xterion/floor', -700, 700);
	setLuaSpriteScrollFactor('floor', 1, 1);
	scaleObject('floor', 1.5, 1.5);


	addLuaSprite('sky', false);
	addLuaSprite('floor', false);
end