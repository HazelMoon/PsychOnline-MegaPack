local InvincibleTime = 0;
local DamageEnable = false;
local DamageEnable2 = false;

local FlipX = 0
local FlipX2 = false
local SansAttack = false

local posX1 = 0
local posX2 = 0
local posY1 = 0
local posY2 = 0

local limitX1 = 220
local limitX2 = 1660
local limitY1 = 440
local limitY2 = 1110
local hitboxOffset = 160
local frameRate = 0
function onCreate()
	makeAnimatedLuaSprite('ray','sans/Gaster_blasterss',-2500,400);
	addAnimationByPrefix('ray','Attack1','fefe instance 1',24,false)
	objectPlayAnimation('ray','Attack1',false)

	makeAnimatedLuaSprite('ray2','sans/Gaster_blasterss',-2500,400);
	addAnimationByPrefix('ray2','Attack1','fefe instance 1',24,false)
	objectPlayAnimation('ray2','Attack1',false)

	makeLuaSprite('HeartSans','sans/heart',990,850)
	precacheImage('sans/Gaster_blasterss')
	precacheImage('sans/heart')

end
function onUpdate(el)
	
	if FlipX == 0 then
		FlipX2 = false
	else
		FlipX2 = true
	end
	if SansAttack == true then
		cameraSetTarget('boyfriend')
		frameRate = frameRate + el
		if (frameRate >= 1 / 120) then
			frameRate = 0
			if keyPressed('left') and getProperty('HeartSans.x') > limitX1 then
				setProperty('HeartSans.x',getProperty('HeartSans.x') - 10)
			end

			if keyPressed('right') and getProperty('HeartSans.x') < limitX2 then
				setProperty('HeartSans.x',getProperty('HeartSans.x') + 10)
			end

			if keyPressed('up') and getProperty('HeartSans.y') > limitY1 then
				setProperty('HeartSans.y',getProperty('HeartSans.y') - 10)
			end

			if keyPressed('down') and getProperty('HeartSans.y') < limitY2 then
				setProperty('HeartSans.y',getProperty('HeartSans.y') + 10)
			end
			if InvincibleTime > 0 then
				InvincibleTime = InvincibleTime - 1
			end
			if InvincibleTime == 0  then
				local rayFrame = getProperty('ray.animation.curAnim.curFrame')
				if rayFrame >= 29 and rayFrame <= 37 then
					--if getProperty('HeartSans.y') >= (getProperty('ray.y') - hitboxOffset) and getProperty('HeartSans.x') <= (getProperty('ray.x') + hitboxOffset) and getProperty('HeartSans.y') >= getProperty('ray.y') - hitboxOffset and getProperty('HeartSans.y') <= getProperty('ray.y') - hitboxOffset or objectsOverlap('HeartSans','ray')  then
					if getProperty('HeartSans.x') >= posX1 - hitboxOffset and getProperty('HeartSans.x') <= posX1 + hitboxOffset and getProperty('HeartSans.y') >= posY1 - hitboxOffset and getProperty('HeartSans.y') <= posY1 + hitboxOffset then
						InvincibleTime = 150
						playSound('sans/hearthurt')
						setProperty('health',getProperty('health') - 1)
					end
				elseif rayFrame > 37 then
					posX1 = 0
					posY1 = 0
				end
				local ray2Frame = getProperty('ray2.animation.curAnim.curFrame')
				if ray2Frame >= 29 and ray2Frame <= 37 then
					--if getProperty('HeartSans.y') >= (getProperty('ray2.y') - hitboxOffset) and getProperty('HeartSans.x') <= (getProperty('ray2.x') + hitboxOffset) and getProperty('HeartSans.y') >= getProperty('ray2.y') - hitboxOffset and getProperty('HeartSans.y') <= getProperty('ray2.y') - hitboxOffset or objectsOverlap('HeartSans','ray') or objectsOverlap('HeartSans','ray2') then
					if getProperty('HeartSans.x') >= posX2 - hitboxOffset and getProperty('HeartSans.x') <= posX2 + hitboxOffset and getProperty('HeartSans.y') >= posY2 - hitboxOffset and getProperty('HeartSans.y') <= posY2 + hitboxOffset then
						InvincibleTime = 150
						playSound('sans/hearthurt')
						setProperty('health',getProperty('health') - 1)
					end
				elseif ray2Frame > 37 then
					posX2 = 0
					posY2 = 0
				end
			end
		end
	else
		if getProperty('HeartSans.alpha') > 0 then
			setProperty('HeartSans.alpha',getProperty('HeartSans.alpha') - 0.02)
		end
		if getProperty('boyfriend.alpha') < 1 then
			setProperty('boyfriend.alpha', getProperty('boyfriend.alpha') + 0.02)
		end
	end

	if getProperty('ray.animation.curAnim.finished') == true then
		removeLuaSprite('ray',false)
	end
	if getProperty('ray2.animation.curAnim.finished') == true then
		removeLuaSprite('ray2',false)
	end
end

function onTimerCompleted(tag)
	if SansAttack == true then
		if tag == 'SansAttack1' then
			runTimer('gasSound',1.1)
			addLuaSprite('ray',true)
			objectPlayAnimation('ray','Attack1',true)
			setProperty('ray.flipX',FlipX2)
			setProperty('ray.y',getProperty('HeartSans.y')- 250)
			setProperty('ray.angle',math.random(0,30))
			updateHitbox('ray')
			playSound('sans/readygas')
			runTimer('SansAttack2',1)
			runTimer('SansHitBox',1.3)
			
			posX1 = getProperty('HeartSans.x')
			posY1 = getProperty('HeartSans.y')
		end

		if tag == 'SansAttack2' then
			runTimer('gasSound2',1.1)
			addLuaSprite('ray2',true)
			objectPlayAnimation('ray2','Attack1',true)
			setProperty('ray2.flipX',FlipX2)
			setProperty('ray2.y',getProperty('HeartSans.y')-250)
			setProperty('ray2.angle',math.random(0,30))
			updateHitbox('ray2')
			playSound('sans/readygas')
			runTimer('SansAttack1',2)
			runTimer('SansHitBox2',1.3)

			posX2 = getProperty('HeartSans.x')
			posY2 = getProperty('HeartSans.y')
		end
    end

	if string.find(tag,'gasSound') then
		playSound('sans/shootgas')
		sansShake()
	end
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
function onStepHit()
	FlipX = math.random(0,1)
	if curStep == 408 or curStep == 662 then
		SansAttack = true
		runTimer('SansAttack1',1)
		addLuaSprite('HeartSans',true)
		setProperty('HeartSans.alpha',0)
		doTweenAlpha('bfAlphaSans','boyfriend',0.5,0.3,'linear')
		doTweenAlpha('healthAlphaSans','HeartSans',1,0.3,'linear')
	elseif curStep == 508 or curStep == 761 then
		SansAttack = false
		cameraSetTarget(detectSection())
		doTweenAlpha('healthAlphaSans','HeartSans',0,0.3,'linear')
		doTweenAlpha('bfAlphaSans','boyfriend',1,0.3,'linear')
	end
end

function sansShake()
	cameraShake('camGame',0.05,0.3)
	cameraShake('camHUD',0.005,0.3)
	local lol = 0
	for strumLineNotes = 0,7 do
		lol = math.random(1,2)
		local randomX = 0
		local randomY = 0
		local randomAngle = 0
		if lol == 2 then
			randomX = math.random(-30,-15)
			randomY = math.random(-30,-15)
			randomAngle = math.random(-45,-15)
			lol = 1
		else
			randomX = math.random(30,15)
			randomY = math.random(30,15)
			randomAngle = math.random(45,15)
			lol = 0
		end
		local strumX = getPropertyFromGroup('strumLineNotes',strumLineNotes,'x')
		local strumY = getPropertyFromGroup('strumLineNotes',strumLineNotes,'y')
		local strumAngle = getPropertyFromGroup('strumLineNotes',strumLineNotes,'angle')
		setPropertyFromGroup('strumLineNotes', strumLineNotes,'x', strumX + randomX)
		setPropertyFromGroup('strumLineNotes', strumLineNotes,'y', strumY + randomY)
		setPropertyFromGroup('strumLineNotes', strumLineNotes,'angle', strumAngle + randomAngle)
		noteTweenX('ShakeBackX'..strumLineNotes, strumLineNotes, strumX,0.3,'backOut')
		noteTweenY('ShakeBackY'..strumLineNotes, strumLineNotes, strumY,0.3,'backOut')
		noteTweenAngle('ShakeBackAngle'..strumLineNotes, strumLineNotes, strumAngle,0.3,'backOut')
	end
end