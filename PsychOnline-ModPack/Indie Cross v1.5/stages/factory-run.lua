local frameRate = 0

local allowMoviment = true
local zoom = 0.7
local animCounter = 0

local curState = 0-- State 0 = Normal, State 1 = Tunnel, State 2 = Stairs, State 3 = Freaky Machine
local prevState = 0
local transiting = false

--State 2
local BGY = -1000
local stairsY = -2200
local playerX = -400

--State 3
local platformX = -500

local darkMode = false
local hellNotes = false
local enableNotes = true
function onCreate()
	createBG(curState)
	if songName == 'Nightmare-Run' then
		if difficulty == 0 then
			enableNotes = false
		end
		if difficulty == 2 then
			hellNotes = true
		end
		--Precache
		makeAnimatedLuaSprite('Transition', 'bendy/dark/Trans', -250, -150)
		addAnimationByPrefix('Transition','Trans','beb instance 1', 30, false)
		setProperty('Transition.alpha',0.001)
		setObjectCamera('Transition', 'hud')
		addLuaSprite('Transition',false)

		addCharacterToList('bf-bendy-run-dark','boyfriend')
		addCharacterToList('bendy-run-dark','dad')

		precacheImage('bendy/dark/Trans')
		--Stairs
		precacheImage('bendy/stairs/scrollingBG')
		precacheImage('bendy/stairs/stairs')
		precacheImage('bendy/stairs/chainleft')
		precacheImage('bendy/stairs/chainright')

		--Freaky Machine
		precacheImage('bendy/gay/C_00')
		precacheImage('bendy/gay/C_01')
		precacheImage('bendy/gay/C_02')
		precacheImage('bendy/gay/C_07')
		if not lowQuality then
			precacheImage('bendy/stairs/gradient')
			precacheImage('bendy/gay/C_03')
			precacheImage('bendy/gay/C_04')
			precacheImage('bendy/gay/C_05a')
			precacheImage('bendy/gay/C_05b')
			precacheImage('bendy/stairs/gradient')
		end
		if enableNotes then
			precacheImage('bendy/BendyNotes')
			precacheImage('bendy/BendyShadowNoteDark')
			if not hellNotes then
				precacheImage('bendy/BendySplashNoteDark')
			else
				precacheImage('bendy/BendyNotes-Hell')
				precacheImage('bendy/BendySplashNoteDark-Hell')
				precacheImage('bendy/BendyShadowNoteDark-Hell')
			end
		end
	end
end
function createBG(state)
	allowMoviment = false
	local bfX = 1800
	local bfY = 980
	local dadX = 1000
	local dadY = 980
	if state == 0 then
		zoom = 0.7
		allowMoviment = true
		makeAnimatedLuaSprite('BendyBGRun', 'bendy/run/hallway', -4400,600)
		scaleObject('BendyBGRun', 2.7, 2.7)
		setScrollFactor('BendyBGRun', 0.8, 0.8)
		addAnimationByPrefix('BendyBGRun','Loop0', 'Loop01 instance 1', 75, false)
		addAnimationByPrefix('BendyBGRun','Loop1', 'Loop02 instance 1', 75, false)
		addAnimationByPrefix('BendyBGRun','Loop2', 'Loop03 instance 1', 75, false)
		addAnimationByPrefix('BendyBGRun','Loop3', 'Loop04 instance 1', 75, false)
		addAnimationByPrefix('BendyBGRun','Loop4', 'Loop05 instance 1', 75, false)
		setProperty('BendyBGRun.offset.x',0)
		setProperty('BendyBGRun.offset.y',0)
		addLuaSprite('BendyBGRun', false)
	elseif state == 1 then
		zoom = 0.5
		allowMoviment = true
		makeAnimatedLuaSprite('BendyBGRun', 'bendy/run/hallway', -5400, 800)
		addAnimationByPrefix('BendyBGRun','Tunnel', 'Tunnel instance 1', 75, true)
		scaleObject('BendyBGRun', 2.3, 2.3)
		setProperty('BendyBGRun.offset.x',0)
		setProperty('BendyBGRun.offset.y',0)
		setScrollFactor('BendyBGRun', 0, 1)
		addLuaSprite('BendyBGRun', false)
	elseif state == 2 then
		allowMoviment = false
		triggerEvent('Camera Follow Pos', 1500, 1000)
		zoom = 0.5
		for bg = 1,2 do
			makeLuaSprite('StairsBG'..bg,'bendy/stairs/scrollingBG', -1200, -500)
			setScrollFactor('StairsBG'..bg,0,0)
			scaleObject('StairsBG'..bg,2,2)
			addLuaSprite('StairsBG'..bg, false)
		end
		makeLuaSprite('stairs','bendy/stairs/stairs',-650, -150)
		setScrollFactor('stairs',0,0)
		scaleObject('stairs',1.8,1.8)
		addLuaSprite('stairs', true)

		for chain = 1,3 do
			makeLuaSprite('stairsChainleft'..chain,'bendy/stairs/chainleft',-400,-260)
			scaleObject('stairsChainleft'..chain,2,2)
			setScrollFactor('stairsChainleft'..chain,0,0)
			setObjectOrder('stairsChainleft'..chain,getObjectOrder('stairs') - 1)
			addLuaSprite('stairsChainleft'..chain,false)

			makeLuaSprite('stairsChainright'..chain,'bendy/stairs/chainright',1400,0)
			scaleObject('stairsChainright'..chain,2,2)
			setScrollFactor('stairsChainright'..chain,0,0)
			addLuaSprite('stairsChainright'..chain,true)
		end
		if (not lowQuality) then
			addLuaSprite('gradient',true)
		end
	elseif state == 3 then
		allowMoviment = false
		triggerEvent('Camera Follow Pos', 1500, 1000)
		zoom = 0.4

		makeLuaSprite('GayBG', 'bendy/gay/C_00', -25, -600)
		setScrollFactor('GayBG',0,0)
		scaleObject('GayBG', 1.85, 1.85)
		addLuaSprite('GayBG', false)

		makeLuaSprite('GayFreakyMachine', 'bendy/gay/C_02', 100, -560)
		setScrollFactor('GayFreakyMachine',0,0)
		scaleObject('GayFreakyMachine', 1.65, 1.65)
		addLuaSprite('GayFreakyMachine', false)

		for ground = 1,2 do
			makeLuaSprite('GayBGGround'..ground, 'bendy/gay/C_01', -1500,0)
			setScrollFactor('GayBGGround'..ground,0,1)
			scaleObject('GayBGGround'..ground,1.8,1.8)
			addLuaSprite('GayBGGround'..ground, true)
		end

		if (not lowQuality) then
			makeLuaSprite('gradient', 'bendy/stairs/gradient', -700, -500)
			setScrollFactor('gradient',0,0)
			scaleObject('gradient',1.6,1.6)

			makeLuaSprite('GayBG3', 'bendy/gay/C_03', 1295, 125)
			setScrollFactor('GayBG3', 1.6, 1.6)
			scaleObject('GayBG3', 1.65 , 1.65 )

			makeLuaSprite('GayBG4', 'bendy/gay/C_04', 1095, -200)
			scaleObject('GayBG4', 1.5, 1.5)

			makeLuaSprite('GayBG5a', 'bendy/gay/C_05a', -95, 105)
			scaleObject('GayBG5a', 1.7, 1.7)

			makeLuaSprite('GayBG5b', 'bendy/gay/C_05b', -95, 105)
			scaleObject('GayBG5b', 1.7, 1.7)

			makeLuaSprite('GayBlend', 'bendy/gay/C_06_BLEND_MODE_ADD', -495, -600)
			setScrollFactor('GayBlend', 0, 0)
			setBlendMode('GayBlend', 'add')
			scaleObject('GayBlend', 1.85, 1.85)

			addLuaSprite('GayBG4', false)
			addLuaSprite('GayBG3', true)
			addLuaSprite('GayBG5a', false)
			addLuaSprite('GayBG5b', true)
			addLuaSprite('GayBlend',true)
		end
		makeLuaSprite('GayBGVignette', 'bendy/gay/C_07', -10, -10)
		scaleObject('GayBGVignette',0.685,0.685)
		setObjectCamera('GayBGVignette','hud')
		addLuaSprite('GayBGVignette', true)
	end
	setProperty('boyfriendGroup.x', bfX)
	setProperty('boyfriendGroup.y', bfY)

	setProperty('dadGroup.x', dadX)
	setProperty('dadGroup.y', dadY)
	if (state == 1 or state == 3) then
		setDarkMode(true)
	else
		setDarkMode(false)
	end
	setProperty('defaultCamZoom',zoom)
end
function detectSection()
    if gfSection ~= true then
        if mustHitSection ~= true then
            return 'dad'
        else
            return 'boyfriend'
        end
    else
        return 'gf'
    end
end
function changeBG()
	if prevState ~= curState then
		if prevState ~= 0 and prevState ~= 1 and (curState == 0 or curState == 1) then
			removeLuaSprite('BendyBGRun',true)
		elseif curState == 2 then
			triggerEvent('Camera Follow Pos', '', '')
			removeLuaSprite('StairsBG1', true)
			removeLuaSprite('StairsBG2', true)
			removeLuaSprite('gradient', true)
			removeLuaSprite('stairs', true)
			for chain = 1,3 do
				removeLuaSprite('stairsChainleft'..chain,true)
				removeLuaSprite('stairsChainright'..chain,true)
			end
		elseif curState == 3 then
			triggerEvent('Camera Follow Pos', '', '')
			for gays = 1,2 do
				removeLuaSprite('GayBGGround'..gays, true)
			end
			removeLuaSprite('GayBGVignette',true)
			if(not lowQuality) then
				removeLuaSprite('GayBG', true)
				removeLuaSprite('GayFreakyMachine', true)
				removeLuaSprite('GayBG5', true)
				removeLuaSprite('GayBG3', true)
				removeLuaSprite('GayBG4', true)
				removeLuaSprite('GayBG5a', true)
				removeLuaSprite('GayBG5b', true)
				removeLuaSprite('GayBlend',true)
			end
		end
		curState = prevState
		createBG(curState)
	end
end
function setDarkMode(dark)
	if darkMode ~= dark then
		local texture = 'NOTE_assets'
		darkMode = dark
		if dark then
			if getProperty('dad.curCharacter') == 'bendy-run' then
				triggerEvent('Change Character','dad','bendy-run-dark')
			end
			if getProperty('boyfriend.curCharacter') == 'bf-bendy-run' then
				triggerEvent('Change Character','bf','bf-bendy-run-dark')
			end
			texture = 'bendy/BendyNotes'
		else
			if getProperty('dad.curCharacter') == 'bendy-run-dark' then
				triggerEvent('Change Character','dad','bendy-run')
			end
			if getProperty('boyfriend.curCharacter') == 'bf-bendy-run-dark' then
				triggerEvent('Change Character','bf','bf-bendy-run')
			end
			changeNotes('NOTE_assets','bendy/BendySplashNoteAssets','bendy/BendyShadowNoteAssets')
		end
		for strumNotes = 0,7 do
			setPropertyFromGroup('strumLineNotes',strumNotes,'texture',texture)
		end
	end
end
function changeState(state,transition)
	if state ~= prevState then
		if transition or transition == nil then
			makeAnimatedLuaSprite('Transition', 'bendy/dark/Trans', -250, -150)
			addAnimationByPrefix('Transition','Trans','beb instance 1', 30, false)
			objectPlayAnimation('Transition','Trans', false)
			setScrollFactor('Transition', 0, 0)
			scaleObject('Transition', 1.75, 1.75)
			setObjectCamera('Transition', 'hud')
			addLuaSprite('Transition',false)
			transiting = true
			runTimer('TransitionDestroy', 1.5)
		else
			changeBG()
		end
		prevState = state
	end
end
function changeNotes(texture,splashTexture,shadowTexture)
	for notesLength = 0,getProperty('notes.length')-1 do
		local noteType = getPropertyFromGroup('notes', notesLength, 'noteType')
		local curTexture = texture
		if (noteType ~= '') then
			if (noteType == 'BendyShadowNote') then
				curTexture = shadowTexture
			elseif (noteType == 'BendySplashNote') then
				curTexture = splashTexture
			else
				curTexture = nil
			end
		end
		if curTexture ~= nil then
			setPropertyFromGroup('notes', notesLength, 'texture',curTexture)
		end
	end
end
function onUpdate(el)
	if curState == 0 then
		if (getProperty('BendyBGRun.animation.curAnim.finished')) then
			animCounter = (animCounter + 1)%5
			objectPlayAnimation('BendyBGRun', 'Loop' ..animCounter, false)
		end
	elseif curState == 2 or curState == 3 then
		frameRate = frameRate + el
		if frameRate >= 1/120 then
			if curState == 2 then
				local starsSpeed = 25
				BGY = BGY + (starsSpeed/3)
				stairsY = stairsY + starsSpeed
				playerX = playerX + starsSpeed + 7

				if (stairsY >= 2000) then
					stairsY = -2200
					playerX = -500
				end
	
				if (getProperty('StairsBG2.y') >= -1000) then
					BGY = getProperty('StairsBG2.y')
				end
				local chainY = getProperty('stairsChainleft1.y')
				local chainRight = getProperty('stairsChainright1.y')
				if getProperty('stairsChainleft2.y') >= 260 then
					chainY = getProperty('stairsChainleft2.y')
				end
				if getProperty('stairsChainright2.y') >= 400 then
					chainRight = getProperty('stairsChainright2.y')
				end
				setProperty('stairsChainleft1.y',chainY + starsSpeed + 5)
				setProperty('stairsChainright1.y',chainRight + starsSpeed + 5)
				for chain = 2,3 do
					setProperty('stairsChainleft'..chain..'.y',chainY - ((getProperty('stairsChainleft1.height') - 10) * (chain - 1)))
					setProperty('stairsChainright'..chain..'.y',chainRight - ((getProperty('stairsChainright1.height') - 20) * (chain - 1)))
				end
	
				setProperty('StairsBG1.y', BGY)
				setProperty('StairsBG2.y', BGY - getProperty('StairsBG1.height'))
				setProperty('stairs.y',stairsY)
	
				setProperty('boyfriendGroup.x',playerX)
				setProperty('boyfriendGroup.y',stairsY + 1560 - (playerX/2.3))
	
				setProperty('dadGroup.x', playerX - 1040)
				setProperty('dadGroup.y', stairsY + 2100 - (playerX/2.3 + 50))

				frameRate = 0
			elseif curState == 3 then
				setProperty('GayBG.x', getProperty('GayBG.x') - 1)
				if (not lowQuality) then
					setProperty('GayBG4.x', getProperty('GayBG4.x') - 1.1)
					setProperty('GayBG3.x', getProperty('GayBG3.x') - 1)
				end
				local groundX = getProperty('GayBGGround1.x')
				if (groundX <= -2000) then
					groundX = -1600
				end
				setProperty('GayBGGround1.x', groundX - 25)
				setProperty('GayBGGround2.x', groundX + getProperty('GayBGGround1.width') - 25)
				setProperty('GayFreakyMachine.x', getProperty('GayFreakyMachine.x') - 1)
				setProperty('GayBlend.x', getProperty('GayBlend.x') - 1)
				frameRate = 0
			end
		end
	end
	if songName == 'Nightmare-Run' then
		if (curStep >= 411 and curStep < 537 or curStep >= 1676 and curStep < 1930) then
			changeState(1)
		elseif (curStep >= 537 and curStep < 783 or curStep >= 1306 and curStep < 1676 or curStep >= 1930) then
			changeState(0)
		elseif (curStep >= 783 and curStep <= 1049) then
			changeState(2)

		elseif (curStep >= 1050 and curStep <= 1305) then
			changeState(3)
		end
	end
	if transiting then
		local transtionFrame = getProperty('Transition.animation.curAnim.curFrame')
		if transtionFrame > 13 and transtionFrame < 17 then
			changeBG()
		end
	end

	if allowMoviment then
		local hp = math.min(2,getProperty('health'))
		if (curStep < 783 or curStep > 1056) then
			if (hp < 0.76) then
				triggerEvent('Alt Idle Animation', 1, '-alt')
				cameraSetTarget('boyfriend')
				setProperty('defaultCamZoom', zoom + 0.5 - (getProperty('health') / 2))
			else
				triggerEvent('Alt Idle Animation', 1, '')
				cameraSetTarget(detectSection())
				setProperty('defaultCamZoom', zoom)
			end
			setProperty('dad.x',getProperty('dadGroup.x') + (300 - (hp * 300)))
		end
	end

	if darkMode and enableNotes then
		if not hellNotes then
			changeNotes('bendy/BendyNotes','bendy/BendySplashNoteDark','bendy/BendyShadowNoteDark')
		else
			changeNotes('bendy/BendyNotes-Hell','bendy/BendySplashNoteDark-Hell','bendy/BendyShadowNoteDark-Hell')
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'TransitionDestroy' then
		removeLuaSprite('Transition',true)
		transiting = false
	end
end