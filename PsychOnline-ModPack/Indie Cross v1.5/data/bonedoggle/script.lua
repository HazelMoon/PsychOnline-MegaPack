function onUpdate()
	if curStep >= 190 then
		if not middlescroll then
			noteTweenX('NoteMove1',0, 416 ,1,'QuartOut')
			noteTweenX('NoteMove2',1, 525 ,1,'QuartOut')
			noteTweenX('NoteMove3',2, 635 ,1,'QuartOut')
			noteTweenX('NoteMove4',3, 743 ,1,'QuartOut')
			noteTweenX('NoteMove5',4, 849 ,1,'QuartOut')
			noteTweenX('NoteMove6',5, 958 ,1,'QuartOut')
			noteTweenX('NoteMove7',6, 1065 ,1,'QuartOut')
			noteTweenX('NoteMove8',7, 1170 ,1,'QuartOut')
		end
	end
end

function onStepHit()
	if curStep == 1244 then
		setProperty('camHUD.visible',false)
	end
end