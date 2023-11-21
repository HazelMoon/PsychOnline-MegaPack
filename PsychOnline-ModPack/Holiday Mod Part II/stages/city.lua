local yy = 0
function onCreate()

	makeLuaSprite('sky','city/sky',200,115)
	setLuaSpriteScrollFactor('sky',0.5,0.5)
	addLuaSprite('sky',false)

	makeLuaSprite('bg','city/bg',0,0)
	addLuaSprite('bg',false)

	makeAnimatedLuaSprite('layer3','city/layer3',0,0)
	addAnimationByPrefix('layer3','idle','idle',2,true)
	objectPlayAnimation('layer3','idle',true)

	makeLuaSprite('layer2','city/layer2',0,0)
	addLuaSprite('layer2',false)


	makeAnimatedLuaSprite('layer1','city/layer1',30,0)
	addAnimationByPrefix('layer1','idle','idle',2,true)
	objectPlayAnimation('layer1','idle',true)
	addLuaSprite('layer1',false)

	makeLuaSprite('snow','city/snow',0,0)
	addLuaSprite('snow',true)

	makeLuaSprite('crtscreen','city/crtscreen',0,0)
	setLuaSpriteScrollFactor('crtscreen',160,90)
	addLuaSprite('crtscreen',true)

	makeLuaSprite('bars','city/bars',0,0)
	setLuaSpriteScrollFactor('bars',160,90)
	addLuaSprite('bars',true)

	setObjectCamera('bars','camOther')
	setObjectCamera('crtscreen','camOther')


	setProperty('sky.antialiasing',false)


	setProperty('bg.antialiasing',false)

	setProperty('layer1.antialiasing',false)

	setProperty('layer2.antialiasing',false)

	setProperty('layer3.antialiasing',false)

	setProperty('snow.antialiasing',false)
	setProperty('bars.antialiasing',false)
	setProperty('crtscreen.antialiasing',false)
	scaleObject('crtscreen',4,4)
	scaleObject('bars',4,4)


	if isStoryMode and not seenCutscene then



		makeAnimatedLuaSprite('felizintro','city/intro',0,0)
		addAnimationByPrefix('felizintro','felizintro','felizintro',30,false)
		setLuaSpriteScrollFactor('felizintro',0,0)
		objectPlayAnimation('felizintro','felizintro',true)
		addLuaSprite('felizintro',false)
		setProperty('felizintro.antialiasing',false)
		scaleObject('felizintro',4,4)
		setObjectCamera('felizintro','camOther')
		runTimer('l',0.02,1)

	end






end





local cx = 0
local cy = 0
function onTimerCompleted(t,l,ll)

	if t=='l' then

		playSound('felizintro',0.8,'boobs')

	end

	if t=='ll' then

		setProperty('camGame.alpha',1)
		setProperty('camHUD.alpha',1)
		startCountdown()

	end


end
local squish= 80
local incs = false

function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		--runTimer('startDialogue', 0.8);
		setPropertyFromClass('PlayState','seenCutscene',true)

		allowCountdown = true;
		incs = true
		return Function_Stop;
	end
	return Function_Continue;
end




function onUpdate( elapsed )


	if incs then
		if keyJustPressed('accept') then
			incs=false
			stopSound('boobs')
			playSound('sel',0.8,'inmymouth')
			setProperty('camGame.alpha',0)
			setProperty('camHUD.alpha',0)
			removeLuaSprite('felizintro',true)
			runTimer('ll',1.2,1)


		end
	end

	setProperty('gf.visible',false)
	if not middlescroll then
		noteTweenX('0',0,defaultOpponentStrumX0+squish,0.01,'linear')
		noteTweenX('1',1,defaultOpponentStrumX1+squish,0.01,'linear')
		noteTweenX('2',2,defaultOpponentStrumX2+squish,0.01,'linear')
		noteTweenX('3',3,defaultOpponentStrumX3+squish,0.01,'linear')
		noteTweenX('4',4,defaultPlayerStrumX0-squish,0.01,'linear')
		noteTweenX('5',5,defaultPlayerStrumX1-squish,0.01,'linear')
		noteTweenX('6',6,defaultPlayerStrumX2-squish,0.01,'linear')
		noteTweenX('7',7,defaultPlayerStrumX3-squish,0.01,'linear')

	end
	yy = yy+0.25
	setProperty('snow.y',math.floor(yy))
	setProperty('crtscreen.y',getProperty('crtscreen.y')+3)
	if yy > 0 then

		yy = -120
	end
	if getProperty('crtscreen.y') > 12 then

		setProperty('crtscreen.y',0)
	end
end