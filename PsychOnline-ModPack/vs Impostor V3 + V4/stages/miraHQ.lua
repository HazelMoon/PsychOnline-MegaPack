function onCreate()
	-- background shit
	makeLuaSprite('Mira', 'Mira', 64, 100);
	setScrollFactor('Mira', 0.9, 0.9);
	
        makeLuaSprite('table', 'table', -570, 700);
	setLuaSpriteScrollFactor('table', 0.9, 0.9);
	scaleObject('table', 1.1, 1.1);

        makeLuaSprite('table2', 'table2', 1200, 700);
	setLuaSpriteScrollFactor('table2', 0.9, 0.9);
	scaleObject('table2', 1.1, 1.1);
        setProperty('table2.flipX', true); --mirror sprite horizontally

	makeLuaSprite('vending_machine', 'vending_machine', 1020, 210);
	setLuaSpriteScrollFactor('vending_machine', 0.9, 0.9);
	scaleObject('vending_machine', 1.1, 1.1);
        
        addLuaSprite('Mira', false);
	addLuaSprite('table', false);
	addLuaSprite('table2', false);
	addLuaSprite('vending_machine', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end