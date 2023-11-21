local gf = false;
local duet = false
local rr = 1.2
local del = 0;
local laughtimer = 0;
function onCreate()
	makeLuaSprite('BG', 'santa/BG', -203, -309);
	setLuaSpriteScrollFactor('BG', 0.9, 0.9);
	addLuaSprite('BG', false);

	makeLuaSprite('eyes', 'santa/eyes', 400, 204);
	setLuaSpriteScrollFactor('eyes', 0.9, 0.9);
	addLuaSprite('eyes', false);
	setProperty('eyes.alpha', 0);

	makeAnimatedLuaSprite('skid','characters/skid',40.65,273)
	addAnimationByPrefix('skid','idle','skid idle',24,false)
	addAnimationByPrefix('skid','singLEFT','skid left',24,false)
	addAnimationByPrefix('skid','singDOWN','skid down',24,false)
	addAnimationByPrefix('skid','singUP','skid up',24,false)
	addAnimationByPrefix('skid','singRIGHT','skid right',24,false)
	addAnimationByPrefix('skid','haha','skid haha',24,false)
	addAnimationByPrefix('skid','laugh','skid haha',24,false)
	addAnimationByPrefix('skid','hey','skid yea',24,false)
	addLuaSprite('skid',true)
	objectPlayAnimation('skid',anim,false)



	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Alt Animation' and not getPropertyFromGroup('unspawnNotes', i, 'mustHit') then
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true); --Change texture

		end
	end
end

function onBeatHit()
	if laughtimer == 0 then
		objectPlayAnimation('skid','idle',false)
	end

end

function onUpdate()
	if laughtimer > 0 then
		laughtimer = math.floor(laughtimer) - 1;
	end
	if del > 0 then
		del = del - 1;
	end


end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if duet == false then
		setProperty('defaultCamZoom', rr)
		if noteType == 'GF Sing' then
			
			triggerEvent('Camera Follow Pos',950,300)
		elseif noteType == 'Hey!' then
			triggerEvent('Add Camera Zoom',0.04,0)
		elseif noteType == 'HAHA' then
			triggerEvent('Play Animation','haha', '')
		elseif noteType == 'HAHAGF' then
			triggerEvent('Play Animation','cheer', 'gf')
		else
			triggerEvent('Camera Follow Pos',820.7, 471.9)
		end
	else
		triggerEvent('Camera Follow Pos',640,420)
		setProperty('defaultCamZoom', 1)
	end
end

function opponentNoteHit(id, d, noteType, isSustainNote)
	if duet == false then
		setProperty('defaultCamZoom', rr)
		if noteType == 'GF Sing' then
			triggerEvent('Camera Follow Pos',950,300)
		elseif noteType == 'Hey!' then
			laughtimer = (6.1*stepCrochet/1000)*(framerate/60)
			objectPlayAnimation('skid','hey',true)
		elseif noteType == 'HAHA' then
			triggerEvent('Play Animation','haha', 'dad')
			objectPlayAnimation('skid','laugh',true)
			laughtimer = (6.1*stepCrochet/1000)*(framerate/60)
		elseif noteType == 'HAHAGF' then
			triggerEvent('Play Animation','cheer', 'gf')
		else
			triggerEvent('Camera Follow Pos',355,312)
		end
	else

		if noteType == 'Hey!' then
			laughtimer = (6.1*stepCrochet/1000)*(framerate/60)
			objectPlayAnimation('skid','hey',true)
		elseif noteType == 'HAHA' then
			triggerEvent('Play Animation','haha', 'dad')
			objectPlayAnimation('skid','laugh',true)
			laughtimer = (6.1*stepCrochet/1000)*(framerate/60)
		elseif noteType == 'HAHAGF' then
			triggerEvent('Play Animation','cheer', 'gf')
		end

		triggerEvent('Camera Follow Pos',640,420)
		setProperty('defaultCamZoom', 1)
	end
	if noteType == 'Alt Animation' or noteType == 'Spooky Sing' then
	if duet == false then
		triggerEvent('Camera Follow Pos',640,520)
	end
		if d == 0 then
		anim = 'singLEFT'
		end
		if d == 1 then
		anim = 'singDOWN'
		end
		if d == 2 then
		anim = 'singUP'
		end
		if d == 3 then
		anim = 'singRIGHT'
		end
			laughtimer = (6.1*stepCrochet/1000)*(framerate/60)
		objectPlayAnimation('skid',anim,true)
	end
end

function onEvent(name,value1,value2)
	if name == 'Kill Henchmen' then
		
		if del == 0 then
			del = 3
			if duet == true then
				duet = false
			else
				duet = true
			end
		end

	end
	if name == 'BG Freaks Expression' then
		
		doTweenAlpha('ee','eyes',2,1,'linear')
		doTweenAlpha('eEe','BG',0.5,1,'linear')

	end


	if name == 'YEA!' then

			triggerEvent('Add Camera Zoom',0.6,0.3)

	end

end

