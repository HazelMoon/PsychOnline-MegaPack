function onCreate()

	makeLuaSprite('floor','mountains/floor',-666.7, 338.2)
	makeLuaSprite('mountainsbg','mountains/mountainsbg',-1025.8, -116.05)
	makeLuaSprite('mountainsmg','mountains/mountainsmg',-1490.1, -592.75)
	makeLuaSprite('sky','mountains/sky',-1130.75, -1093.5)
	addLuaSprite('sky')
	addLuaSprite('mountainsbg')
	addLuaSprite('mountainsmg')
	addLuaSprite('floor')
	setScrollFactor('sky',0,0)
	setScrollFactor('mountainsbg',0.2,0.2)
	setScrollFactor('mountainsmg',0.4,0.4)
	setScrollFactor('floor',0.9,0.9)

end

function onUpdatePost(elapsed)

	setProperty('camGame.scroll.y',0)

end

