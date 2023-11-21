local DrainTime = 0
function onCreate()
	--Iterate over all notes
	for unnotesLength = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', unnotesLength, 'noteType') == 'Devil Note' then
			setPropertyFromGroup('unspawnNotes', unnotesLength, 'texture', 'cup/devilNOTE_assets'); --Change texture
			setPropertyFromGroup('unspawnNotes', unnotesLength, 'hitHealth', '-0.05'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', unnotesLength, 'missHealth', '0'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', unnotesLength, 'hitCausesMiss', false);

			if getPropertyFromGroup('unspawnNotes', unnotesLength, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', unnotesLength, 'ignoreNote', true); --Miss has no penalties
			end
		end
	end
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Devil Note' then
		-- put something here if you want
		DrainTime = 200
		playSound('cup/burnSound')
	end
end

-- Called after the note miss calculations
-- Player missed a note by letting it go offscreen

function onUpdate()
	if DrainTime > 0  then
		DrainTime = DrainTime - 1
		setProperty('health',getProperty('health') - 0.001)
	end
end