local originy = 0
function onCreate()

	originy = getProperty('boyfriend.y')

end
function goodNoteHit(i,d,t,s)
	if not getPropertyFromGroup('notes',i,'gfNote') then
		setProperty('boyfriend.y',originy+20)
		doTweenY('wifjwif','boyfriend',originy,0.08,'linear')
	end

end


function onBeatHit()
	if getProperty('boyfriend.animation.curAnim.name') == "idle" then
		setProperty('boyfriend.y',originy+40)
		doTweenY('wifjwiuuf','boyfriend',originy,0.2,'sineOut')
	end

end