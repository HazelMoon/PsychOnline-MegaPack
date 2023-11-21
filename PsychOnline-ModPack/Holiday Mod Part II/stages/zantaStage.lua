function onCreate()
	if difficulty == 0 then
		addLuaScript('taikoInput')
	end
	makeLuaSprite('bg','characters/zanta/bg',-52.6,86.65)
	makeAnimatedLuaSprite('gate','characters/zanta/gate',1099.85,-3.7)
	addAnimationByIndices('gate','close','gate','0',24)
	addAnimationByIndices('gate','open','gate','1',24)
	objectPlayAnimation('gate','close')
	addLuaSprite('bg',false)





	makeAnimatedLuaSprite('santa','characters/zanta/Santa',1550.65,92.95)

	addAnimationByPrefix('santa','idle','santa0',24,false)
	addAnimationByPrefix('santa','alt','santa alt',24,false)
	addAnimationByPrefix('santa','hurt','santa hurt',24,false)
	addAnimationByPrefix('santa','bald','santa BALD',24,false)
	addLuaSprite('santa',false)
	objectPlayAnimation('santa','idle')








	addLuaSprite('gate',false)

	makeAnimatedLuaSprite('tom','characters/zanta/Tom Assets',93.85,116.25)

	addAnimationByPrefix('tom','idle','tom idle',24,false)
	addAnimationByPrefix('tom','singLEFT','tom gun left',24,false)
	addAnimationByPrefix('tom','singDOWN','tom gun down',24,false)
	addAnimationByPrefix('tom','singUP','tom gun up',24,false)
	addAnimationByPrefix('tom','singRIGHT','tom gun right',24,false)
	addAnimationByPrefix('tom','idleboobs','tom gun idle',24,false)
	addAnimationByPrefix('tom','shoot','tom shoot',24,false)
	addAnimationByPrefix('tom','shot','tom shot',24,false)


	addLuaSprite('tom',true)



	makeAnimatedLuaSprite('matt','characters/zanta/matt',-7,186)
	addAnimationByIndices('matt','idle','matt idle','0',24)
	addAnimationByIndices('matt','hm','matt idle','1',24)
	addLuaSprite('matt',true)

	makeLuaSprite('bartop','',0,0)
	makeGraphic('bartop',1280,100,'000000')
	addLuaSprite('bartop',true)

	makeLuaSprite('barbot','',0,620)
	makeGraphic('barbot',1280,100,'000000')
	addLuaSprite('barbot',true)
	setScrollFactor('bartop',0,0)
	setScrollFactor('barbot',0,0)
	setObjectCamera('bartop','hud')
	setObjectCamera('barbot','hud')
end

local originy = 0
function onCreatePost()
	originy = getProperty('boyfriend.y')

	setProperty('gf.visible',false)
	
	for i = 0, getProperty('opponentStrums.length')-1 do
		setPropertyFromGroup('opponentStrums',i,'visible',false)
		setPropertyFromGroup('opponentStrums',i,'y',130)
		setPropertyFromGroup('opponentStrums',i,'x',-9999)
	end


	--triggerEvent('Camera Follow Pos','900','360')
	setProperty('camFollow.y',360)
	setProperty('camFollow.x',900)
	setProperty('camPos.x',0)
	setProperty('camPos.y',0)
	setProperty('camGame.scroll.x',640)
	setProperty('camGame.scroll.y',360)


	

end


function goodNoteHit(id,d,t,s)

	if getPropertyFromGroup('notes',id,'gfNote') then
	tomAnim(d)
	end

end
function opponentNoteHit(id,d,t,s)

	if getPropertyFromGroup('notes',id,'gfNote') then
	tomAnim(d)
	end


end
function tomAnim(anim)

	anims = {'singLEFT','singDOWN','singUP','singRIGHT'}
	setProperty('tom.offset.y',-20)
	doTweenY('tomss','tom.offset',0,0.08,'linear')
	objectPlayAnimation('tom',anims[anim+1])
	runTimer('tomsing',(stepCrochet/1000)*6.1)

end
function onUpdatePost()
	--setProperty('camHUD.zoom',0.8)


end
function onTimerCompleted(t,l,ll)

	if t == "tomsing" then
		objectPlayAnimation('tom','idleboobs')
	end

end
function onEvent(n,v1,v2)

if n == "duet" then

	duet = v1 == "true"

end

if n == "edd sing" then
setProperty('health',getProperty('health')+0.01)
		setProperty('boyfriend.y',originy+20)
		doTweenY('wifjwif','boyfriend',originy,0.08,'linear')

end
if n == "tom sing" then
tomAnim(tonumber(v1))

end

end
function onBeatHit()
	if duet then
			triggerEvent('Camera Follow Pos','1000','360')

	else
		if mustHitSection then
		
			triggerEvent('Camera Follow Pos','600','360')

		else
			triggerEvent('Camera Follow Pos','1440','360')

		end
	end

	setProperty('matt.y',186+40)
	doTweenY('mattbounce','matt',186,0.15,'circOut')

	setProperty('tom.y',116.25+20)
	doTweenY('tombounce','tom',116.25,0.15,'cubeOut')


end