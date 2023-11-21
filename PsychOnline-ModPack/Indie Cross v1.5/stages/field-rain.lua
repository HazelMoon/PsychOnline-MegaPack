function onCreate()
	-- background shit

	
	makeLuaSprite('CupSky', 'cup/rain/CH-RN-00', -600, -150);
	setScrollFactor('CupSky', 0.1, 0.1);
	scaleObject('CupSky',3,3)
    
	makeLuaSprite('CupBG', 'cup/rain/CH-RN-01', -850, -300);
	setScrollFactor('CupBG', 0.2, 0.2);
	scaleObject('CupBG',3,3)

    makeLuaSprite('CupGround','cup/rain/CH-RN-02', -600, -100);
	scaleObject('CupGround',4,4)

	addLuaSprite('CupSky', false);
    addLuaSprite('CupBG', false);
    addLuaSprite('CupGround', false);

	if not lowQuality then

		makeAnimatedLuaSprite('CupRain1', 'cup/rain/NewRAINLayer01',0,0);
		addAnimationByPrefix('CupRain1','dance','RainFirstlayer instance 1',24,true);
		objectPlayAnimation('CupRain1','RainFirstlayer instance 1',false)
		scaleObject('CupRain1',0.7,0.7)
		setObjectCamera('CupRain1','other');
		
		makeAnimatedLuaSprite('CupRain2', 'cup/rain/NewRAINLayer02',0,0);
		addAnimationByPrefix('CupRain2','dance','RainFirstlayer instance 1',24,true);
		objectPlayAnimation('CupRain2','RainFirstlayer instance 1',false)
		setObjectCamera('CupRain2','other');
			

		makeAnimatedLuaSprite('CupheqdShid', 'cup/CUpheqdshid',-350,-193);
		addAnimationByPrefix('CupheqdShid','dance','Cupheadshit_gif instance 1',24,true);
		objectPlayAnimation('CupheqdShid','Cupheadshit_gif instance',false)
		setObjectCamera('CupheqdShid','hud')

		makeAnimatedLuaSprite('Grain', 'cup/Grainshit',-350,-193);
		addAnimationByPrefix('Grain','dance','Geain instance 1',24,true);
		objectPlayAnimation('Grain','Geain instance 1',false)
		setObjectCamera('Grain','hud')
	end

	addLuaSprite('CupheqdShid', true);
	addLuaSprite('Grain',true);
	addLuaSprite('CupRain1', true);
	addLuaSprite('CupRain2', true);
end
function onCreatePost()
	detectCharacter()
	for strumLineLength = 0,7 do
		setPropertyFromGroup('strumLineNotes', strumLineLength, 'texture','cup/Cuphead_NOTE_assets')
	end
	for notesLength = 0,getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', notesLength, 'noteType') == '' and getPropertyFromGroup('unspawnNotes', notesLength, 'texture') ~= noteTexture then
			setPropertyFromGroup('unspawnNotes', notesLength, 'texture', 'cup/Cuphead_NOTE_assets');
		end
	end
end
function onEvent(name)
	if name == 'Change Character' then
		detectCharacter()
	end
end
function detectCharacter()
	if getProperty('dad.curCharacter') ~= 'cuphead-pissed' then
		setProperty('dad.color',getColorFromHex('B2DFFF'))
	end
	if getProperty('boyfriend.curCharacter') ~= 'bf-ic-rain' then
		setProperty('boyfriend.color',getColorFromHex('B2DFFF'))
	end
end