local healthBarStyle = ''
local barOffsetX = 0
local barOffsetY = 0

local barImage = ''
local changeHealthBar = true
function onCreatePost()
	if downscroll then
		setProperty('healthBar.y',getProperty('healthBar.y') - 30)
		setProperty('scoreTxt.y',getProperty('scoreTxt.y') - 30)
		setProperty('iconP1.y',getProperty('iconP1.y') - 30)
		setProperty('iconP2.y',getProperty('iconP2.y') - 30)
	end
	local antialising = true
    if songName == 'Burning-In-Hell' or songName == 'Final-Stretch' or songName == 'Bad-Time' or songName == 'Whoopee' or songName == 'Sansational' then
		healthBarStyle = 'Sans'

		barImage = 'healthbar-ic/sanshealthbar'
		barOffsetX = 55
		barOffsetY = 6.6

		makeLuaSprite('SansHealthBarP1','',getProperty('healthBar.x'),getProperty('healthBar.y') - 6.6)
		setObjectCamera('SansHealthBarP1','hud')
		setProperty('SansHealthBarP1.antialiasing',false)
		makeGraphic('SansHealthBarP1',getProperty('healthBar.width')/2,getProperty('healthBar.height'),'FFFF00')
		addLuaSprite('SansHealthBarP1',true)
		setObjectOrder('SansHealthBarP1',5)


		makeLuaSprite('SansHealthBarP2','',getProperty('healthBar.x'),getProperty('healthBar.y') - 6.6)
		setObjectCamera('SansHealthBarP2','hud')
		makeGraphic('SansHealthBarP2',getProperty('healthBar.width'),getProperty('healthBar.height'),'FF0000')
		addLuaSprite('SansHealthBarP2',true)
		setProperty('SansHealthBarP2.antialiasing',false)
		setObjectOrder('SansHealthBarP2',4)

		makeLuaSprite('SansHealthBar','',getProperty('healthBar.x'),getProperty('healthBar.y') - 6.6)
		setObjectCamera('SansHealthBar','hud')
		makeGraphic('SansHealthBar',getProperty('healthBar.width'),getProperty('healthBar.height'),'FF0000')
		addLuaSprite('SansHealthBar',true)
		setProperty('SansHealthBar.antialiasing',false)
		setObjectOrder('SansHealthBar',4)
		antialising = false

		setProperty('iconP1.alpha', 0)
		setProperty('iconP2.alpha', 0)
		setProperty('healthBar.flipX', true)
	elseif songName == 'Despair' or songName == 'Nightmare-Run' or songName == 'Last-Reel' or songName == 'Terrible-Sin' or songName == 'Imminent-Demise' or songName == 'build-our-freaky-machine' or songName == 'Ritual' or songName == 'Freaky-Machine' then

			healthBarStyle = 'Bendy'

			barImage = 'healthbar-ic/bendyhealthbar'
			barOffsetX = 50
			barOffsetY = 87

		if songName == 'build-our-freaky-machine' then
			precacheImage('healthbar-ic/bendyhealthbar-grey')
		end
	elseif songName == 'Snake-Eyes' or songName == 'Technicolor-Tussle' or songName == 'Knockout' or songName == 'Devils-Gambit' or songName == 'Satanic-Funkin' then
	    healthBarStyle = 'Cuphead'
		barImage = 'healthbar-ic/cuphealthbar'

		barOffsetX = 25
		barOffsetY = 18
	else
		changeHealthBar = false
	end
	if changeHealthBar == true then
		createCustomBar(barImage,barOffsetX,barOffsetY,'hud',false,antialising)
	end
end
function onUpdate()
	if healthBarStyle == 'Sans' then

		setProperty('SansHealthBarP1.x',getProperty('healthBar.x'))
		setProperty('SansHealthBarP1.y',getProperty('healthBar.y') - 6.6)
		
		setProperty('SansHealthBarP1.width',getProperty('healthBar.width')/2)
		setProperty('SansHealthBarP1.height',getProperty('healthBarBG.height'))

		setProperty('SansHealthBarP2.x',getProperty('healthBar.x'))
		setProperty('SansHealthBarP2.y',getProperty('healthBar.y') - 6.6)

		if getProperty('health') <= 2 then
			scaleObject('SansHealthBarP1',getProperty('health') + 0.01,getProperty('healthBar.scale.y'))
			scaleObject('SansHealthBarP2',getProperty('healthBar.scale.x'),getProperty('healthBar.scale.y'))
		end
	   
		setProperty('SansHealthBarP2.width',getProperty('healthBar.width'))
		setProperty('SansHealthBarP2.height',getProperty('healthBar.height'))
	   
	end

	setProperty('customHealthBar.x', getProperty('healthBar.x'))
	setProperty('customHealthBar.y', getProperty('healthBar.y'))
	setProperty('customHealthBar.alpha', getProperty('healthBar.alpha'))
	setProperty('customHealthBar.angle', getProperty('healthBar.angle'))

	if healthBarStyle ~= '' then

		setProperty('healthBarBG.visible', false)
		setProperty('healthBar.scale.y', 2.2)
		setObjectOrder('healthBar', 3)
		setObjectOrder('healthBarBG', 2)
	end
end
function onStepHit()
	if songName == 'build-our-freaky-machine' then
		if curStep == 1280 then
			createCustomBar('healthbar-ic/bendyhealthbar-grey',barOffsetX,barOffsetY,'hud',false)
		elseif curStep == 1536 then
			createCustomBar(barImage,barOffsetX,barOffsetY,'hud',false)
		end
	end
end
function createCustomBar(image,offsetX,offsetY,layer,ahead,antialiasing)
	makeLuaSprite('customHealthBar',image,0,0)
	setProperty('customHealthBar.offset.x',offsetX)
	setProperty('customHealthBar.offset.y',offsetY)
	setObjectCamera('customHealthBar',layer)
	setProperty('customHealthBar.antialiasing',antialiasing)
	addLuaSprite('customHealthBar',ahead)
	setObjectOrder('customHealthBar',getObjectOrder('healthBar') - 5)
end