local SplashDamage = 0
local enabled = true
function onCreate()
	--Iterate over all notes
	for unnotesLength = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', unnotesLength, 'noteType') == 'BendySplashNote' then
			setPropertyFromGroup('unspawnNotes', unnotesLength, 'texture', 'bendy/BendySplashNoteAssets');--Change texture
			setPropertyFromGroup('unspawnNotes', unnotesLength, 'hitHealth', '-0.023'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', unnotesLength, 'ignoreNote', true);
		end
	end
	for bendySplash = 1,4 do
		precacheImage('bendy/Damage0'..bendySplash)
	end
	if songName == 'Last-Reel' or songName == 'Despair' then
		enabled = false
	end
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'BendySplashNote' and enabled then
		-- put something here if you want
		SplashDamage = SplashDamage + 1
		playSound('bendy/inked')
		if SplashDamage < 5 then
			makeLuaSprite('SplashScreen','bendy/Damage0'..SplashDamage,0,0)
			scaleObject('SplashScreen',0.7,0.7)
			setObjectCamera('SplashScreen','hud')
			setProperty('SplashScreen.alpha',1)
			addLuaSprite('SplashScreen',true)

			runTimer('SplashDestroy',3)
			cancelTween('byeSplash')
		else
			setProperty('health',-1)
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'SplashDestroy' and enabled then
		doTweenAlpha('byeSplash','SplashScreen',0,2,'sineIn')
	end
end
function onTweenCompleted(tag)
	if tag == 'byeSplash' and enabled then
		removeLuaSprite('SplashScreen',true)
		SplashDamage = 0
	end
end