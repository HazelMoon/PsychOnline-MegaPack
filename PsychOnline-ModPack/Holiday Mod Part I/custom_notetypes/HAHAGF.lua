function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'HAHAGF' then
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true); --Change texture

		end
	end
end


function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'HAHA' then
		triggerEvent('Play Animation','laugh', '2')
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'HAHA' then
		triggerEvent('Play Animation','laugh', '2')
	end
end
