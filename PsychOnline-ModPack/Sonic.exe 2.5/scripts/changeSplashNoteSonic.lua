local enableSystem = true
local texture = 'noteSplashes/BloodSplash'
local splashCount = 0
local splashesDestroyed = 0
local curSplashAlpha = 0
function onCreate()
	curSplashAlpha = getPropertyFromClass('backend.ClientPrefs','data.splashAlpha')
	if string.match(songName,'endless') == 'endless' then
		enableSystem = false
		precacheImage('noteSplashes/endlessNoteSplashes')
		return
	end
	if string.match(songName,'milk')  == 'milk' then
		texture = 'noteSplashes/sunky_splash'
	end
	if songName == 'Too-Fest' then
		precacheImage('noteSplashes/hitmarker')
		precacheSound('hitmarker')
	end
	if enableSystem then
		precacheImage(texture)
		activeSplash(true)
		makeLuaSprite('noteSplashpChache',texture, 100, 100);
		addLuaSprite('noteSplashpChache',false);
		setProperty('noteSplashpChache.alpha',0.0001)
	end
end
function onDestroy()
	setPropertyFromClass('backend.ClientPrefs','data.splashAlpha',curSplashAlpha)
end
function goodNoteHit(note, direction, type, sus)
	if enableSystem and getPropertyFromGroup('notes',note,'rating') == 'sick' then
		spawnCustomSplash(note, direction, type, texture);
		if texture == 'noteSplashes/hitmarker' then
			playSound('hitmarker')
		end
	end
end
function activeSplash(enable)
	if enable then
		setPropertyFromClass('backend.ClientPrefs','data.splashAlpha',0)
	else
		setPropertyFromClass('backend.ClientPrefs','data.splashAlpha',curSplashAlpha)
	end
	enableSystem = enable
end
function spawnCustomSplash(noteId, noteDirection, type, splashTexture)
	splashCount = splashCount + 1
	local splash = 'noteSplashC'..splashCount
	local anim = ''
	local fps = 24
	local offsetX = 65
	local offsetY = 40
	--local alpha = 1
	local scaleX = 1
	local scaleY = 1
	
	local tex = string.gsub(splashTexture,'noteSplashes/','')
	if tex == 'BloodSplash' then
		fps = 30
		--alpha = 1
		anim = 'note splash blue 1'
	elseif tex == 'endlessNoteSplashes' then
		fps = 30
		offsetX = 150
		offsetY = 100
		scaleX = 0.8
		scaleY = 0.8
	elseif tex == 'milkSplashes' then
		fps = 34
		scaleX = 0.5
		scaleY = 0.5
		offsetX = 200
		offsetY = 300
	elseif tex == 'hitmarker' then
		offsetX = 10
		offsetY = 0
		anim = 'hit'
	elseif tex == 'sunky_splash' then
		offsetX = 180
		offsetY = 200
		fps = 34
		scaleX = 0.5
		scaleY = 0.5
	end
	if anim == '' then
		local dir = {'purple','blue','green','red'}
		if tex ~= 'sunky_splash' then
			local maxAnims = 2
			anim = 'note splash '..dir[noteDirection + 1]..' '..tostring(math.random(1,maxAnims))
		else
			anim = dir[noteDirection + 1]..'00'
		end
		
	end
	makeAnimatedLuaSprite(splash, splashTexture, getPropertyFromGroup('playerStrums', noteDirection, 'x'), getPropertyFromGroup('playerStrums', noteDirection, 'y'))
	addAnimationByPrefix(splash, 'anim', anim, fps, false)
	scaleObject(splash,scaleX,scaleY)
	setProperty(splash..'.offset.x', offsetX)
	setProperty(splash..'.offset.y', offsetY)

	--setProperty(splash..'.alpha', alpha)
	setProperty(splash..'.color', getPropertyFromGroup('playerStrums',noteDirection,'color'))
	setObjectCamera(splash, 'hud')
	addLuaSprite(splash,true)
end
function onUpdate()
	if enableSystem and splashCount > 0 then
		for splashes = splashesDestroyed, splashCount do
			local name = 'noteSplashC'..splashes
			if getProperty(name..'.animation.curAnim.finished') then
				setProperty(name..'.visible',false)
				removeLuaSprite(name,true)
				splashesDestroyed = splashesDestroyed + 1
			end
		end
	end
end

function onStepHit()
	if curStep == 900 and songName == 'endless' or curStep == 800 and songName == 'endless-encore' or songName == 'endless-og' and curStep == 920 then
		activeSplash(true)
		texture = 'noteSplashes/endlessNoteSplashes'
	end
	if songName == 'Too-Fest' then
		if curStep == 930  then
			texture = 'noteSplashes/hitmarker'
		end
		if curStep == 1168 then
			texture = 'noteSplashes/BloodSplash'
		end
	end
end