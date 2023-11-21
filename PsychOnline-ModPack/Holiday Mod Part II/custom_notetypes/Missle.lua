function onCreate()


	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
			--setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true); --Change texture

			if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Missle' then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_missle'); --Miss has no penalties

				if downscroll then
					setPropertyFromGroup('unspawnNotes', i, 'flipY', true);
					setPropertyFromGroup('unspawnNotes', i, 'offsetY', -250);
				end


			end
	end


end

function onUpdate( elapsed )
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
			--setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true); --Change texture

			if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Missle' then --Doesn't let Dad/Opponent notes get ignored
				
					setPropertyFromGroup('unspawnNotes', i, 'offsetX', -40);

				if downscroll then
					setPropertyFromGroup('unspawnNotes', i, 'offsetY', -250);
				end


			end
	end
end
function goodNoteHit(id, direction, noteType, isSustainNote)
	--if duet == false then
		if noteType == 'Missle' then
			
			playSound('boom')
		end
	--else
	--	triggerEvent('Camera Follow Pos',640,420)
	--	setProperty('defaultCamZoom', 1)
	--end
end
function noteMiss(id, direction, noteType, isSustainNote)
	--if duet == false then
		if noteType == 'Missle' then
			setProperty('health',-999)
			playSound('boom')
		end
	--else
	--	triggerEvent('Camera Follow Pos',640,420)
	--	setProperty('defaultCamZoom', 1)
	--end
end
