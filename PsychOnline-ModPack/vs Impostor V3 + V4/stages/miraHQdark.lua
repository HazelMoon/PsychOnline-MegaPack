function onCreate()
	-- background shit
	makeLuaSprite('MiraDark', 'MiraDark', 64, 100);
	setScrollFactor('MiraDark', 0.9, 0.9);
	
        makeLuaSprite('tableDark', 'tableDark', -570, 700);
	setLuaSpriteScrollFactor('tableDark', 0.9, 0.9);
	scaleObject('tableDark', 1.1, 1.1);
        
        makeLuaSprite('tableDark2', 'tableDark2', 1200, 700);
	setLuaSpriteScrollFactor('tableDark2', 0.9, 0.9);
	scaleObject('tableDark2', 1.1, 1.1);
        setProperty('tableDark2.flipX', true); --mirror sprite horizontally

	makeLuaSprite('vending_machineDark', 'vending_machineDark', 1020, 210);
	setLuaSpriteScrollFactor('vending_machineDark', 0.9, 0.9);
	scaleObject('vending_machineDark', 1.1, 1.1);
        
        makeLuaSprite('MiraGradient', 'MiraGradient', 0, 100);
	setLuaSpriteScrollFactor('MiraGradient', 0.9, 0.9);
	scaleObject('MiraGradient', 1.1, 1.1);
        
        makeLuaSprite('vignette', 'vignette', 0, 100);
	setLuaSpriteScrollFactor('vignette', 0.9, 0.9);
	scaleObject('vignette', 1.1, 1.1);
        
        addLuaSprite('MiraDark', false);
	addLuaSprite('tableDark', false);
	addLuaSprite('tableDark2', false);
	addLuaSprite('vending_machineDark', false);
	addLuaSprite('MiraGradient', false);
	addLuaSprite('vignette', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end