function onCreate()

	makeLuaSprite('Background0', 'bg0', -570, -475)
	addLuaSprite('Background0', false)

	makeLuaSprite('Background1', 'bg1', -570, -475)
	addLuaSprite('Background1', false)

	makeAnimatedLuaSprite('Background2', 'bg2', -570, -475)
	addAnimationByPrefix('Background2','idle','bg2',24,true)
	objectPlayAnimation('Background2','bg2',true)
	addLuaSprite('Background2', false)

	makeAnimatedLuaSprite('Background3', 'bg3', -570, -475)
	addAnimationByPrefix('Background3','idle','bg3',24,true)
	objectPlayAnimation('Background3','bg3',true)
	addLuaSprite('Background3', false)

	makeAnimatedLuaSprite('Background4', 'bg4', -570, -475)
	addAnimationByPrefix('Background4','idle','bg4',24,true)
	objectPlayAnimation('Background4','bg4',true)
	addLuaSprite('Background4', false)

	makeAnimatedLuaSprite('Background5', 'bg5', -570, -475)
	addAnimationByPrefix('Background5','idle','bg5',24,true)
	objectPlayAnimation('Background5','bg5',true)
	addLuaSprite('Background5', false)

	makeAnimatedLuaSprite('Background6', 'bg6', -570, -475)
	addAnimationByPrefix('Background6','idle','bg6',24,true)
	objectPlayAnimation('Background6','bg6',true)
	addLuaSprite('Background6', false)

	makeLuaSprite('Floor', 'ground', -570, -475)
	addLuaSprite('Floor', false)

	makeAnimatedLuaSprite('Gaster', 'xgasterink', -180, -275)
	addAnimationByPrefix('Gaster', 'Gaster', 'Xgasterink idle dance instance', 24, true)
	addLuaSprite('Gaster', false)
	objectPlayAnimation('Gaster', 'Gaster', true)

                 close(true)

end