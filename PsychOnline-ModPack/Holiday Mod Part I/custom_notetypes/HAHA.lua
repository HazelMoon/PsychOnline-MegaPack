function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'HAHA' then
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true); --Change texture

		end
	end
end


function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'HAHA' then
		triggerEvent('Play Animation','haha', '1')
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'HAHA' then
		triggerEvent('Play Animation','haha', '0')
	end
end
