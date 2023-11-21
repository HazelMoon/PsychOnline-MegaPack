function onCreate()
	-- background shit
	makeAnimatedLuaSprite('GoseBG', 'secretSongs/goseLandAnimated', -250, -62)
	addAnimationByPrefix('GoseBG', 'BG', 'BG instance', 24, false)
	addLuaSprite('GoseBG', false);
end

function onBeatHit()
	if curBeat % 2 == 0 then
		objectPlayAnimation('GoseBG','BG',true)
	end
end