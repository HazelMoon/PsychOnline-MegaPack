local papyrusArray = {}
local susFX = 0
local oFX = 0
function onCreatePost()
	for notesLength = 0, getProperty('unspawnNotes.length')-1 do
		local sus = getPropertyFromGroup('unspawnNotes', notesLength, 'isSustainNote')
		local mustPress = getPropertyFromGroup('unspawnNotes', notesLength, 'mustPress')
		if getPropertyFromGroup('unspawnNotes', notesLength, 'noteType') == 'PapyrusNote' then

			setPropertyFromGroup('unspawnNotes', notesLength,'texture','sans/PapyrusNote')
			if not sus then
				oFX = getPropertyFromGroup('unspawnNotes', notesLength, 'offsetX')
			else
				susFX = getPropertyFromGroup('unspawnNotes', notesLength, 'offsetX')
			end
			if mustPress then
				setPropertyFromGroup('unspawnNotes', notesLength, 'offsetX', getPropertyFromGroup('unspawnNotes', notesLength, 'offsetX') - 640)
			else
				setPropertyFromGroup('unspawnNotes', notesLength, 'offsetX', getPropertyFromGroup('unspawnNotes', notesLength, 'offsetX') + 640)
			end
        end
    end
end

function onUpdatePost(el)
    for notesLength = 0, getProperty('notes.length') - 1 do
        if getPropertyFromGroup('notes', notesLength, 'noteType') == 'PapyrusNote' then

			local strumTime = getPropertyFromGroup('notes', notesLength, 'strumTime')
			local sus = getPropertyFromGroup('notes', notesLength, 'isSustainNote')
			if #papyrusArray < notesLength then
				for papyrusLength = #papyrusArray,notesLength do
					if papyrusArray[papyrusLength] == nil and getPropertyFromGroup('notes',notesLength,'isSustainNote') == false then
						table.remove(papyrusArray,papyrusLength)
						table.insert(papyrusArray,papyrusLength,false)
					end
				end
			end
			if sus then
				setPropertyFromGroup('notes', notesLength, 'offsetX', getPropertyFromGroup('notes', notesLength, 'offsetX') + 3 * math.cos((curBeat + notesLength * 0.15) * math.pi))
				if (strumTime - getSongPosition()) < 1150 / scrollSpeed then
					if getPropertyFromGroup('notes', notesLength, 'offsetX') ~= susFX + 3 then
						setPropertyFromGroup('notes', notesLength, 'offsetX', lerp(getPropertyFromGroup('notes', notesLength, 'offsetX'), susFX + 3, boundTo(el * 7, 0, 1)))
					elseif getPropertyFromGroup('notes', notesLength, 'offsetX') <= susFX + 3 then
						setPropertyFromGroup('notes', notesLength, 'offsetX', susFX + 3)
					end
				end
			else
				if (strumTime - getSongPosition()) < 1100 / scrollSpeed then
					if (strumTime - getSongPosition()) > math.floor(1066 / scrollSpeed) then
						if papyrusArray[notesLength] == false then
							table.remove(papyrusArray,notesLength)
							table.insert(papyrusArray,notesLength,true)
							playSound('sans/ping')
						end
					else
						table.remove(papyrusArray,notesLength)
						table.insert(papyrusArray,notesLength,false)
					end
					if getPropertyFromGroup('notes', notesLength, 'offsetX') ~= oFX then
						setPropertyFromGroup('notes', notesLength, 'offsetX', lerp(getPropertyFromGroup('notes', notesLength, 'offsetX'), oFX, boundTo(el * 10, 0, 1)))
	
					elseif getPropertyFromGroup('notes', notesLength, 'offsetX') <= oFX then
						setPropertyFromGroup('notes', notesLength, 'offsetX', oFX)
					end
				end
			end
        end
    end
end
function goodNoteHit(id,data,type,sus)
	if papyrusArray[id] == true then
		table.remove(papyrusArray,id)
		table.insert(papyrusArray,id,false)
	end
	for papyrusLength = 1,#papyrusArray do

	end
end
function lerp(a, b, ratio)
  	return math.floor(a + ratio * (b - a))
end

function boundTo(value, min, max)
	return math.max(min, math.min(max, value))
end
