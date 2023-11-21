local canEnd = false
function onEndSong()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if  isStoryMode and not canEnd then
		setProperty('inCutscene', true);
		triggerEvent('startDia')
		canEnd = true
		runTimer('endDialogue',2)
		return Function_Stop;
	else
	return Function_Continue;
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'endDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogueEnd', '');
	end
end

-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(count)
	-- triggered when the next dialogue line starts, 'line' starts with 1
end

function onSkipDialogue(count)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
end