
local stopAnimTimer = 0;
local targetTime = 0;
local stopAnimTimer2 = 0;
local targetTime2 = 0;

local goodhit = false
local taikoMode = true
local inputframes = {0,0,0,0}
function onCreate()

	setPropertyFromClass('PlayState', 'SONG.arrowSkin', 'NOTE_assets'); --
if taikoMode then
	setPropertyFromClass('PlayState', 'SONG.arrowSkin', 'NOTE_taiko'); --
	for i = 0, getProperty('unspawnNotes.length')-1 do
			--Check if the note is an Instakill Note
				--setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true); --Change texture

				--if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
					setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_taiko'); --Miss Misshas no penalties
				--end
		end
	end
	-- triggered when the lua file is started
	--setPropertyFromClass('flixel.FlxG', 'mouse.visible', true);

end

function onCreatePost()

	for i = 0,3 do
		setPropertyFromGroup('playerStrums',i,'x',30)
		setPropertyFromGroup('playerStrums',i,'y',650)
		--setPropertyFromGroup('opponentStrums',i,'x',30)
		--setPropertyFromGroup('opponentStrums',i,'y',600)
	end

	runTimer('tttt',0.3)

end
function onTimerCompleted(t,l,ll)

	if t == 'tttt' then
		makeLuaSprite('taikospot','taikoSpot',162,572)
		addLuaSprite('taikospot',true)
		scaleObject('taikospot',0.7,0.7)
		setObjectCamera('taikospot','camHUD')
 	end

end
function onDestroy()
	-- triggered when the lua file is ended (Song fade out finished)
	--setPropertyFromClass('flixel.FlxG', 'mouse.visible', false);
end
local elapsedd = 0;
local ddd = 0;
function onUpdate(elapsed)
elapsedd = elapsed
ddd = 0.016/elapsed
end

local alr = true
function onUpdatePost()
	-- end of "update"
	if taikoMode and not inGameOver then
	
		for i = 0,3 do
			setPropertyFromGroup('playerStrums',i,'x',30)
			setPropertyFromGroup('playerStrums',i,'y',570)
			--setPropertyFromGroup('opponentStrums',i,'x',30)
			--setPropertyFromGroup('opponentStrums',i,'y',600)
		end
		--noteTweenX('tits0',4,640,0.1,'linear')
		--noteTweenX('tits1',5,640,0.1,'linear')
		--noteTweenX('tits2',6,640,0.1,'linear')
		--noteTweenX('tits3',7,640,0.1,'linear')
		--noteTweenAlpha('tits4',0,0,0.1,'linear')
		--noteTweenAlpha('tits5',1,0,0.1,'linear')
		--noteTweenAlpha('tits6',2,0,0.1,'linear')
		--noteTweenAlpha('tits7',3,0,0.1,'linear')
		--noteTweenAngle('tits8',4,270,0.1,'linear')
		--noteTweenAngle('tits9',5,270,0.1,'linear')
		--noteTweenAngle('tits10',6,270,0.1,'linear')
		--noteTweenAngle('tits11',7,270,0.1,'linear')

		setProperty('camHUD.scale.y', 1280/720); --stop boyfriend from hitting notes normally
		setProperty('camHUD.scale.x', 1280/720); --stop boyfriend from hitting notes normally
		--setProperty('camHUD.angle', 90); --stop boyfriend from hitting notes normally
		setProperty('boyfriend.stunned', true); --stop boyfriend from hitting notes normally
		goodhit = false;
		noteCount = getProperty('notes.length');

					if keyJustPressed("left") then
						inputframes[1] = math.floor(18*ddd)
					end
					if keyJustPressed("down") then
						inputframes[2] = math.floor(18*ddd)
					end
					if keyJustPressed("up") then
						inputframes[3] = math.floor(18*ddd)
					end
					if keyJustPressed("right") then
						inputframes[4] = math.floor(18*ddd)
					end

					if keyReleased("left") then
						inputframes[1] = 0
					end
					if keyReleased("down") then
						inputframes[2] = 0
					end
					if keyReleased("up") then
						inputframes[3] = 0
					end
					if keyReleased("right") then
						inputframes[4] = 0
					end

			--debugPrint(inputframes)
		for i = 0, noteCount-1 do

				setPropertyFromGroup('notes', i, 'x',(1150 + 0.45 * (getSongPosition() - getPropertyFromGroup('notes', i, 'strumTime')) * getProperty('songSpeed')));
				setPropertyFromGroup('notes', i, 'y',0);
			if getPropertyFromGroup('notes', i, 'mustPress') then
				strumY = 160
				setPropertyFromGroup('notes', i, 'x',(strumY - 0.45 * (getSongPosition() - getPropertyFromGroup('notes', i, 'strumTime')) * getProperty('songSpeed')));
				setPropertyFromGroup('notes', i, 'y',570);
				

				noteX = getPropertyFromGroup('notes', i, 'x');
				noteY = getPropertyFromGroup('notes', i, 'y');
				
				hitbox = 60;
				isSustainNote = getPropertyFromGroup('notes', i, 'isSustainNote');
				nd = getPropertyFromGroup('notes', i, 'noteData');
				if isSustainNote then
					 setPropertyFromGroup('notes', i, 'mustPress',false)
					 setPropertyFromGroup('notes', i, 'visible',false)
					 setPropertyFromGroup('notes', i, 'noAnimation',true)
				end

				if math.abs( getSongPosition() - getPropertyFromGroup('notes', i, 'strumTime')) < 40 then --strict ass hit timing

					
					
					if nd == 0 then
						if inputframes[2] > 0 and inputframes[3] > 0 then
							goodhit = true
						end

					end
					if nd == 3 then
						if inputframes[1] > 0 and inputframes[4]> 0  then
							goodhit = true
						end

					end
					if nd == 2 then
						if inputframes[1] > 0 or inputframes[4]> 0  then
							goodhit = true
						end

					end
					if nd == 1 then
						if inputframes[2] > 0 or inputframes[3] > 0 then
							goodhit = true
						end

					end
				end


				if goodhit then
					playSound('ChartingTick', 0.25);
					addScore(350);
					addHits(1);
					noteDiff = math.abs(getPropertyFromGroup('notes', i, 'strumTime') - getSongPosition() + getPropertyFromClass('ClientPrefs','ratingOffset'));
					
					rating = judgeNote(noteDiff)

					if rating == 'sick' then
						setProperty('sicks',getProperty('sicks')+1)
						setProperty('totalNotesHit',getProperty('totalNotesHit')+1)
					elseif rating == 'good' then
						setProperty('goods',getProperty('goods')+1)
						setProperty('totalNotesHit',getProperty('totalNotesHit')+0.75)
					elseif rating == 'bad' then
						setProperty('bads',getProperty('bads')+1)
						setProperty('totalNotesHit',getProperty('totalNotesHit')+0.5)
					elseif rating == 'shit' then
						setProperty('shits',getProperty('shits')+1)
					end



					setProperty('totalPlayed',getProperty('totalPlayed')+1)

					noteData = getPropertyFromGroup('notes', i, 'noteData');
					noteType = getPropertyFromGroup('notes', i, 'noteType');
					
					
					
					if noteType == 'Hurt Note' then
						characterPlayAnim('boyfriend', 'hurt', true);
					elseif getPropertyFromGroup('notes', i, 'gfNote') then

						if noteData == 0 then
							characterPlayAnim('gf', 'singLEFT', true);
						elseif noteData == 1 then
							characterPlayAnim('gf', 'singDOWN', true);
						elseif noteData == 2 then
							characterPlayAnim('gf', 'singUP', true);
						elseif noteData == 3 then
							characterPlayAnim('gf', 'singRIGHT', true);
						end
						triggerEvent('tom sing',noteData)
						stopAnimTimer2 = 0;
						targetTime2 = stepCrochet * 0.001 * getProperty('gf.singDuration');
					else
						triggerEvent('edd sing',noteData)
						if noteData == 0 then
							characterPlayAnim('boyfriend', 'singLEFT', true);
						elseif noteData == 1 then
							characterPlayAnim('boyfriend', 'singDOWN', true);
						elseif noteData == 2 then
							characterPlayAnim('boyfriend', 'singUP', true);
						elseif noteData == 3 then
							characterPlayAnim('boyfriend', 'singRIGHT', true);
						end
						stopAnimTimer = 0;
						targetTime = stepCrochet * 0.001 * getProperty('boyfriend.singDuration');
					end
					
					if noteType == 'Hey!' then
						characterPlayAnim('boyfriend', 'hey', true);
						setProperty('boyfriend.heyTimer', 0.6);
						characterPlayAnim('gf', 'hey', true);
						setProperty('gf.heyTimer', 0.6);
					elseif noteType == 'Hurt Note' then
						if not isSustainNote then
							setProperty('health', getProperty('health') - 0.15);
						else
							setProperty('health', getProperty('health') - 0.03);
						end
					else
						if not isSustainNote then
							setProperty('health', getProperty('health') + 0.023);
						else
							setProperty('health', getProperty('health') + 0.004);
						end
					end
					removeFromGroup('notes', i);
					setProperty('vocals.volume', 1);
					break;
				end
			end
		end
		stopAnimTimer = stopAnimTimer + elapsedd;
		if targetTime > 0 and stopAnimTimer > targetTime then
			characterPlayAnim('boyfriend', 'danceLeft');
			characterPlayAnim('boyfriend', 'idle');
			characterPlayAnim('gf', 'danceLeft');
			targetTime = 0;
			stopAnimTimer = 0;
		end
		if targetTime2 > 0 and stopAnimTimer2 > targetTime2 then
			characterPlayAnim('gf', 'danceLeft');
			targetTime2 = 0;
			stopAnimTimer2 = 0;
		end

		for t = 1,4 do
			if inputframes[t] >0 then inputframes[t] = inputframes[t]-1 end
		end
	end
end



function noteMiss(id,d,n,s)


					setProperty('totalPlayed',getProperty('totalPlayed')+1)

end
function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function judgeNote(diff)

timingWindows = {getPropertyFromClass('ClientPrefs','sickWindow'), getPropertyFromClass('ClientPrefs','goodWindow'), getPropertyFromClass('ClientPrefs','badWindow')};
		windowNames = {'sick', 'good', 'bad'}

		
		for i=1, 4 do
			if diff <= timingWindows[round(math.min(i, 4))] then
			
				return windowNames[i];
			end
		end
		return 'shit';

end
function goodNoteHit(id, direction, noteType, isSustainNote)



end