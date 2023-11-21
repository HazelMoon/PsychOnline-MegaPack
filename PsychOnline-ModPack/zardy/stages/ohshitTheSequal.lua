-- Lua stuff
function onCreate()
	makeAnimatedLuaSprite('FRONT', 'Zardy2BG', -600, -200)
	luaSpriteAddAnimationByPrefix('FRONT', 'bop', 'BG', 24, true)
	scaleObject('FRONT', 0.9, 0.9);
	addLuaSprite('FRONT',  false)
end

