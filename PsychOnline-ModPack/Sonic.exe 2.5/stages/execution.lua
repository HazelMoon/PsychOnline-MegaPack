function onCreate()
	makeLuaSprite('sky', 'EXEcutionStage/sky', -1900, -1006);
	scaleObject('sky', 0.5, 0.5)
	setScrollFactor('sky', 0.95, 1);

	makeLuaSprite('hill', 'EXEcutionStage/hills1', -1900, -1006);
	scaleObject('hill', 0.5, 0.5)
	setScrollFactor('hill', 0.95, 1);

	makeLuaSprite('hills', 'EXEcutionStage/hills2', -1900, -1006);
	scaleObject('hills', 0.5, 0.5)
	setScrollFactor('hills', 0.97, 1);

	makeLuaSprite('floor', 'EXEcutionStage/floor', -1900, -1006);
	scaleObject('floor', 0.5, 0.5)
	setScrollFactor('floor', 1, 1);

    makeAnimatedLuaSprite('eyeflower','EXEcutionStage/ANIMATEDeye', -1560, -573)
    addAnimationByPrefix('eyeflower', 'flowey', 'EyeAnimated', 24, true)
    scaleObject('eyeflower', 2, 2)
    setScrollFactor('eyeflower', 1, 1)

    makeAnimatedLuaSprite('hand','EXEcutionStage/SonicXHandsAnimated', -995, -849)
    addAnimationByPrefix('hand', 'knunk', 'HandsAnimated', 24, true)
    scaleObject('hand', 0.5, 0.5)
    setScrollFactor('hand', 1, 1)

	makeLuaSprite('flowe1', 'EXEcutionStage/smallflower', -1900, -1006);
	scaleObject('flowe1', 0.5, 0.5)
	setScrollFactor('flowe1', 1.005, 1.005);

	makeLuaSprite('flowe2', 'EXEcutionStage/smallflowe2', -1900, -1006);
	scaleObject('flowe2', 0.5, 0.5)
	setScrollFactor('flowe2', 1.005, 1.005);

    makeAnimatedLuaSprite('tree','EXEcutionStage/TreeAnimatedMoment', -225, -1070)
    addAnimationByPrefix('tree', 'wut', 'TreeAnimated', 24, true)
    scaleObject('tree', 2, 2)
    setScrollFactor('tree', 1, 1)


	addLuaSprite('sky', false)
	addLuaSprite('hill', false)
	addLuaSprite('hills', false)
	addLuaSprite('floor', false)
	addLuaSprite('eyeflower', false)
	addLuaSprite('hand', false)
	addLuaSprite('flowe1', false)
	addLuaSprite('flowe2', false)
	addLuaSprite('tree', false)
end