function onCreate()
		makeLuaSprite('bg','deck/bg',-197.25, -323.8)
		makeLuaSprite('snow','deck/snow',237.35, 590.05)
		makeAnimatedLuaSprite('wall','deck/wall',-437.15, -376.55)
		makeAnimatedLuaSprite('door','deck/door',27.05, -285.8)
		addAnimationByIndices('wall','wall1','wall','0',0)
		addAnimationByIndices('wall','wall2','wall','1',0)
		addAnimationByIndices('door','dooropen','door','0',0)
		addAnimationByIndices('door','doorclose','door','1,2',12)
		setLuaSpriteScrollFactor('bg', 0.3, 0.3);
		addLuaSprite('bg',false)
		addLuaSprite('snow',true)
		addLuaSprite('wall',true)
		addLuaSprite('door',true)
		setLuaSpriteScrollFactor('wall', 1.2, 1.2);
		setLuaSpriteScrollFactor('door', 1.2, 1.2);


		makeGraphic('fade',1300, 800,getColorFromHex('000000'));
		addLuaSprite('fade',true)
		setProperty('fade.alpha',0)


end

