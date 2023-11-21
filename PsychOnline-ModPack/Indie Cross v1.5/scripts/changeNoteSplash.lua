local splashCount = 0
local splashDestroyed = 0

local specialSplashCount = 0
local specialSplashDestroyed = 0
local splashThing = 'note splash purple 1'

local sickTrack = 0

local texture = 'IC_NoteSplash'
local enableSplash = false

-- No longer messes with your ClientPrefs! Which means Note Splashes no longer randomly turn off!

-- function onCreate()
-- 	preCacheShit()
-- end
function onCreate()
	enableSplash = getPropertyFromClass('ClientPrefs','noteSplashes')
	setPropertyFromClass('ClientPrefs','noteSplashes',false)
end
function onDestroy()
	setPropertyFromClass('ClientPrefs','noteSplashes',enableSplash)
end
function onCreatePost()
	if enableSplash then
		precacheImage(texture)
		precacheImage('cup/NOTECup_assetsSplash')
		makeAnimatedLuaSprite('noteSplashp', texture, 100, 100)
		addLuaSprite('noteSplashp',false)
		setProperty('noteSplashp.alpha',0.001)
		if songName == 'build-our-freaky-machine' then
			precacheImage('IC_NoteSplash - grey')
		end
	end
end

function goodNoteHit(note, direction, type, sus)
	if enableSplash and sickTrack < getProperty('sicks') then
		sickTrack = sickTrack + 1
		if type == '' then
			spawnNormalSplash(direction)
		else
			spawnCustomSplash(direction,type)
		end
	end
end
function spawnCustomSplash(direction, type)
	specialSplashCount = specialSplashCount + 1

	local name = 'noteSplashS'..specialSplashCount
	local file = texture
	local scaleX = 1
	local scaleY = 1
	local anim = splashThing
	local speed = 24
	local offsetX = 85
	local offsetY = 85
	local color = 'FFFFFF'
	if type == 'BlueBoneNote' then
		color = '000000'
	elseif type == 'OrangeBoneNote' or type == 'PapyrusNote' then
		anim = 'note splash orange 1'
	elseif type == 'BendySplashNote' then
		anim = 'note splash purple 1'
	elseif type == 'Parry Note' then
		file = 'cup/NOTECup_assetsSplash'
		offsetX = 210
		offsetY = 240
		scaleX = 0.8
		scaleY = 0.8
		anim = 'ParryFX'
	end
	makeAnimatedLuaSprite(name, file, getPropertyFromGroup('playerStrums', direction, 'x'), getPropertyFromGroup('playerStrums', direction, 'y'))
	scaleObject(name,scaleX,scaleY)
	addAnimationByPrefix(name, 'anim', anim, speed, false)
	setObjectCamera(name, 'hud')
	addLuaSprite(name,true)

	setProperty(name..'.offset.x', offsetX)
	setProperty(name..'.offset.y', offsetY)
	setProperty(name..'.alpha', 0.6)

	if color ~= 'FFFFFF' then
		setProperty(name..'.color',color)
	end
end

function spawnNormalSplash(direction)
	splashCount = splashCount + 1
	local name = 'noteSplash'..splashCount
	if direction == 0 then
		splashThing = 'note splash purple 1'
	elseif direction == 1 then
		splashThing = 'note splash blue 1'
	elseif direction == 2 then
		splashThing = 'note splash green 1'
	else
		splashThing = 'note splash red 1'
	end

	makeAnimatedLuaSprite(name, texture, getPropertyFromGroup('playerStrums', direction, 'x'), getPropertyFromGroup('playerStrums', direction, 'y'))
	addAnimationByPrefix(name, 'anim', splashThing, 22, false)
	setObjectCamera(name, 'hud')
	addLuaSprite(name,true)

	setProperty(name..'.offset.x', 85)
	setProperty(name..'.offset.y', 85)
	setProperty(name..'.alpha', 0.6)
end

function onUpdate()
	if enableSplash then
		if splashDestroyed < splashCount then
			for splashLength = splashDestroyed + 1, splashCount do
				if getProperty('noteSplash'..splashLength..'.animation.curAnim.finished') == true then
					removeLuaSprite('noteSplash'..splashLength,true)
					splashDestroyed = splashDestroyed + 1
				end
			end
		end
		if specialSplashDestroyed < specialSplashCount then
			for splashSLength = specialSplashDestroyed + 1, specialSplashCount do
				if getProperty('noteSplashS'..splashSLength..'.animation.curAnim.finished') == true then
					removeLuaSprite('noteSplashS'..splashSLength,true)
					specialSplashDestroyed = specialSplashDestroyed + 1
				end
			end
		end
	end
end
function onStepHit()
	if songName == 'build-our-freaky-machine' then
		if curStep == 1280 then
			texture = 'IC_NoteSplash - grey'
		elseif curStep == 1536 then
			texture = 'IC_NoteSplash'
		end
	end
end