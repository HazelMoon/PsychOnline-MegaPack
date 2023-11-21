local bgSpeed = 2500
local skyX = -600
local preyState = 0
function onCreate()
	for starvedBg = 0,2 do
		if starvedBg == 0 then
			makeLuaSprite('StarvedBG'..starvedBg,'starved/stardustBg',-600,-1100)
			makeLuaSprite('StarvedGround'..starvedBg,'starved/stardustFloor',-600,-1465)
		else
			makeLuaSprite('StarvedBG'..starvedBg,'starved/stardustBg',-600 + (getProperty('StarvedBG0.width') * starvedBg),-1100)
			makeLuaSprite('StarvedGround'..starvedBg,'starved/stardustFloor',-600 + (getProperty('StarvedGround0.width') * starvedBg),-1465)
		end
		addLuaSprite('StarvedBG'..starvedBg)
		addLuaSprite('StarvedGround'..starvedBg,true)
		if songName == 'prey' then
			setProperty('StarvedBG'..starvedBg..'.alpha',0.0001)
			setProperty('StarvedGround'..starvedBg..'.alpha',0.0001)
			preyState = 1
		end
	end
end
function onSongStart()
	if curStep > 128 then
		for starvedBg = 0,2 do
			setProperty('StarvedBG'..starvedBg..'.alpha',1)
			setProperty('StarvedGround'..starvedBg..'.alpha',1)
		end
		preyState = 0
	end
end
function onUpdate(el)
	if bgSpeed ~= 0 then
		local speed = bgSpeed*el
		for bgCount = 0,2 do
			setProperty('StarvedBG'..bgCount..'.x',getProperty('StarvedBG'..bgCount..'.x') - (speed/2))
			setProperty('StarvedGround'..bgCount..'.x',getProperty('StarvedGround'..bgCount..'.x') - speed)
		end
		if getProperty('StarvedBG1.x') < skyX - getProperty('StarvedBG1.width') then
			for bg = 0,2 do
				setProperty('StarvedBG'..bg..'.x',skyX + (getProperty('StarvedBG'..bg..'.width') * bg))
			end
		end
		if getProperty('StarvedGround1.x') < skyX - getProperty('StarvedGround0.width')then
			for platform = 0,2 do
				setProperty('StarvedGround'..platform..'.x',-600 + (getProperty('StarvedGround'..platform..'.width') * platform))
			end
		end
	end
end
function onBeatHit()
	if songName == 'prey' then
		if curBeat >= 32 and preyState == 1 then
			for starvedBg = 0,2 do
				setProperty('StarvedBG'..starvedBg..'.alpha',1)
				setProperty('StarvedGround'..starvedBg..'.alpha',1)
			end
			preyState = 0
		end
	end
end
function onStepHit()
	if songName == 'prey' then
		if curStep >= 1784 and curStep < 3367 then
			bgSpeed = 3500
		elseif curStep == 3367 then
			bgSpeed = 0
			for starvedBg = 0,2 do
				removeLuaSprite('StarvedBG'..starvedBg,true)
				removeLuaSprite('StarvedGround'..starvedBg,true)
			end
		end
	end
end