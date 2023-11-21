function onCreate()
	makeLuaSprite('Cup-BG-00', 'cup/BG-00', -600, -150);
	setLuaSpriteScrollFactor('Cup-BG-00', 0.1, 0.1);
	scaleObject('Cup-BG-00',3,3)

	makeLuaSprite('Cup-BG-01', 'cup/BG-01', -750, -300);
	setLuaSpriteScrollFactor('Cup-BG-01', 0.3, 0.3);
	scaleObject('Cup-BG-01',3,3)

	makeLuaSprite('Cup-BG-Ground', 'cup/BG-Ground', -600, -100);
	scaleObject('Cup-BG-Ground',4,4)

	addLuaSprite('Cup-BG-00', false);
    addLuaSprite('Cup-BG-01', false);
	addLuaSprite('Cup-BG-Ground', false);
	if not lowQuality then
		makeAnimatedLuaSprite('CupheqdShid', 'cup/CUpheqdshid',-350,-193);
		addAnimationByPrefix('CupheqdShid','dance','Cupheadshit_gif instance 1',24,true);
		objectPlayAnimation('CupheqdShid','Cupheadshit_gif instance',false)
		scaleObject('CupheqdShid',1.6,1.6)
		setObjectCamera('CupheqdShid','other')
	
		makeAnimatedLuaSprite('Grain', 'cup/Grainshit',-350,-193);
		addAnimationByPrefix('Grain','dance','Geain instance 1',24,true);
		objectPlayAnimation('Grain','Geain instance 1',false)
		scaleObject('Grain',1.6,1.6)
		setObjectCamera('Grain','other')
	
		addLuaSprite('CupheqdShid', true);
		addLuaSprite('Grain',true)
	end
end
function onCreatePost()
	for strumLineLength = 0,7 do
		setPropertyFromGroup('strumLineNotes', strumLineLength, 'texture','cup/Cuphead_NOTE_assets')
    end
	for notesLength = 0,getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', notesLength, 'noteType') == '' and getPropertyFromGroup('unspawnNotes', notesLength, 'texture') ~= noteTexture then
			setPropertyFromGroup('unspawnNotes', notesLength, 'texture', 'cup/Cuphead_NOTE_assets');
		end
    end
end