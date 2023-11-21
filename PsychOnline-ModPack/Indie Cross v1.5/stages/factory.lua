function onCreate()
	-- background shit

	makeAnimatedLuaSprite('SammyBG','bendy/third/SammyBg',670,580)
	addAnimationByPrefix('SammyBG','idle','Sam instance 1',24,false)
	scaleObject('SammyBG',1.1,1.1)
	
	makeLuaSprite('BendyBG', 'bendy/BACKBACKgROUND',-220, -100);
	scaleObject('BendyBG',1,1)
    
	if songName == 'Last-Reel' then
		makeAnimatedLuaSprite('JzBoy','bendy/third/JzBoy',100,580)
		addAnimationByPrefix('JzBoy','dance','Jack Copper Walk by instance 1',24,false)
		objectPlayAnimation('JzBoy','dance',false)
	end

	makeLuaSprite('BendyBG2', 'bendy/BackgroundwhereDEEZNUTSfitINYOmOUTH', -600, -150);
	scaleObject('BendyBG2',1,1)

	makeLuaSprite('BendyGround', 'bendy/MidGrounUTS', -600, -150);

	scaleObject('BendyGround',1,1)

	makeLuaSprite('Pillar', 'bendy/ForegroundEEZNUTS', 1700, -200);
	setScrollFactor('Pillar',1.2,1)




	addLuaSprite('BendyBG', false);
    addLuaSprite('BendyBG2', false);
	addLuaSprite('SammyBG',false)
	addLuaSprite('BendyGround', false);
	addLuaSprite('Pillar', true);
	if not lowQuality and songName ~= 'Terrible-Sin' then
		makeAnimatedLuaSprite('ButcherGang','bendy/third/Butchergang_Bg',-600,1200)
		addAnimationByPrefix('ButcherGang','idle','Symbol 1 instance 1',18,false)
		setScrollFactor('ButcherGang',1.2,1)
		scaleObject('ButcherGang',2.6,2.6)
		addLuaSprite('ButcherGang',true)
	end
end

function onUpdate()
	if songName == 'Last-Reel' and curStep > 986 and curStep < 1100 then
		if getProperty('JzBoy.animation.curAnim.finished') then
			removeLuaSprite('JzBoy',true)
		end
	end
end

function onStepHit()
	if curStep == 986 and songName == 'Last-Reel' then
		addLuaSprite('JzBoy', false);
		setObjectOrder('JzBoy',getObjectOrder('BendyBG2'))
	end
end
function onBeatHit()
	objectPlayAnimation('SammyBG','idle',false)
	if not lowQuality  then
		objectPlayAnimation('ButcherGang','idle',false)
	end
end