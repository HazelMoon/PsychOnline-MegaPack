-- Lua stuff
function onCreate()
	makeAnimatedLuaSprite('ZardyBackground', 'Maze', -600, -200)
	luaSpriteAddAnimationByPrefix('ZardyBackground', 'bop', 'Stage', 16, true)
	scaleObject('ZardyBackground', 0.9, 0.9);
	addLuaSprite('ZardyBackground',  false)
end

