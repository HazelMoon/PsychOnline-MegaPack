function onCreate()
	makeLuaSprite('sky', 'luther/sky', -500, -400);
	setLuaSpriteScrollFactor('sky', 0.6, 0.6);
	scaleObject('sky', 1, 1);
	setProperty('sky.color',100100100)
	
	makeLuaSprite('floor', 'luther/floor', -700, 750);
	scaleObject('floor', 1.5, 1.5);

	if songName == 'Luther' then
		makeAnimatedLuaSprite('shid','luther/CUpheqdshid',0,0)
		addAnimationByPrefix('shid','sdj','Cupheadshit_gif instance 1',24,true)
		setObjectCamera('shid','other')
		setProperty('shid.alpha',0.001)

		makeAnimatedLuaSprite('Grain','luther/Grainshit',0,0)
		addAnimationByPrefix('Grain','sdj','Geain instance 1',24,true)
		setObjectCamera('Grain','other')
		setProperty('Grain.alpha',0.001)

		

		addLuaSprite('shid',true)
		addLuaSprite('Grain',true)
	end
	addLuaSprite('sky', false);
	addLuaSprite('floor', false);
end
function onStepHit()
	if curStep == 14 then
		setProperty('shid.alpha',1)
		setProperty('Grain.alpha',1)
	end
	if curStep < 496 then
		setProperty('sky.alpha',0)
		setProperty('floor.alpha',0)
	elseif curStep == 496 then
		setProperty('sky.alpha',1)
		setProperty('floor.alpha',1)
		removeLuaSprite('shid',true)
		removeLuaSprite('Grain',true)
	end
end