local EnableSans = false

function onCreatePost()
    if difficulty == 2 then
        if songName == 'Whoopee' or songName == 'Sansational' or songName == 'Burning-In-Hell' or songName == 'Final-Strech' or songName == 'Bad-Time' or songName == 'Bad-To-The-Bone' then
            EnableSans = true
        end
    end
end


function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'BlueBoneNote' and EnableSans == true then
	    setProperty('health',0)
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
    if EnableSans == true then
        if noteType == 'OrangeBoneNote' or noteType == 'PapyrusNote' then
            setProperty('health',0)
        end
    end
end