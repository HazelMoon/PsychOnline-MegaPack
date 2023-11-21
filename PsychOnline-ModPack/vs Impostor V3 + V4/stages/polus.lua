function onCreate()
	-- background shit
	makeLuaSprite('polusSky', 'polusSky', -500, -200);
	setScrollFactor('polusSky', 0.9, 0.9);
	
        makeLuaSprite('polusrocks', 'polusrocks', -500, -200);
	setLuaSpriteScrollFactor('polusrocks', 0.9, 0.9);
	scaleObject('polusrocks', 1.1, 1.1);

	makeLuaSprite('polusHills', 'polusHills', -1350, -100);
	setLuaSpriteScrollFactor('polusHills', 0.9, 0.9);
	scaleObject('polusHills', 1.1, 1.1);
        
        makeLuaSprite('polusWarehouse', 'polusWarehouse', -500, -230);
	setLuaSpriteScrollFactor('polusWarehouse', 0.9, 0.9);
	scaleObject('polusWarehouse', 1.1, 1.1);
        
        makeLuaSprite('polusGround', 'polusGround', -500, 370);
	setLuaSpriteScrollFactor('polusGround', 0.9, 0.9);
	scaleObject('polusGround', 1.1, 1.1);
        
        addLuaSprite('polusSky', false);
	addLuaSprite('polusrocks', false);
	addLuaSprite('polusHills', false);
	addLuaSprite('polusWarehouse', false);
	addLuaSprite('polusGround', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end