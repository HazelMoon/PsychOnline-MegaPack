local speed = 90
local i =0
local inTunnel = false

local momshow = false
local sleighx = 0;
local sleighy = 0;


local thrusterstate = 0
local thrusterhp = 200
local thrustermaxhp = 200

local battle = false

local thrusterhitboxx = 0
local thrusterhitboxy = 0
local thrusterhitboxw = 250
local thrusterhitboxh = 250
local canShootNow = true
local tomouch = false
local killing = false
local fps = 60
local zoomspeed = 80
function onCreate()
	fps = getPropertyFromClass('flixel.FlxG','updateFramerate')
	makeLuaSprite('sky','coketruck/sky',-950,-800)
	addLuaSprite('sky',false)
	scaleObject('sky',1.5,1.5)
    setLuaSpriteScrollFactor('sky',0.1,0.1)

	makeLuaSprite('moon','coketruck/moon',-500,-360)
	addLuaSprite('moon',false)
    setLuaSpriteScrollFactor('moon',0.1,0.1)

	makeLuaSprite('tree','coketruck/tree',-998.2,-265.2)
	addLuaSprite('tree',false)
    setLuaSpriteScrollFactor('tree',0.8,0.8)


	makeAnimatedLuaSprite('sleigh','tomstage/sleigh',0,0)
	addAnimationByPrefix('sleigh','sleigh','sleigh',24,true)
	addLuaSprite('sleigh',false)

	makeAnimatedLuaSprite('missle1','tomstage/missle',0,0)
	addAnimationByIndices('missle1','missle','missle','0',24)
	addAnimationByIndices('missle1','fire','missle','1,2,3',24)
	addAnimationByPrefix('missle1','shoot','missle',24,false)
	addLuaSprite('missle1',false)
	makeAnimatedLuaSprite('missle2','tomstage/missle',0,0)
	addAnimationByIndices('missle2','missle','missle','0',24)
	addAnimationByIndices('missle2','fire','missle','1,2,3',24)
	addAnimationByPrefix('missle2','shoot','missle',24,false)
	
	
	
	makeAnimatedLuaSprite('thruster','tomstage/thrusters',0,0)
	addAnimationByIndices('thruster','thruster0','thruster','0,1,2',24)
	addAnimationByIndices('thruster','thruster0_shoot','thruster','3,4,5,6,7,8',24)
	addAnimationByIndices('thruster','thruster0_shot','thruster','9,10,11',24)

	addAnimationByIndices('thruster','thruster1','thruster','12,13,14',24)
	addAnimationByIndices('thruster','thruster1_shoot','thruster','15,16,17,18,19,20',24)
	addAnimationByIndices('thruster','thruster1_shot','thruster',',21,22,23',24)
	addAnimationByIndices('thruster','thruster2','thruster','24,25,26',24)
	objectPlayAnimation('thruster','thruster0',false)
	addLuaSprite('thruster',false)

	makeLuaSprite('sleighback','tomstage/sleighback',-998.2,-265.2)
	addLuaSprite('sleighback',false)


	makeLuaSprite('crosshair','tomstage/crosshair',0,0)
	addLuaSprite('crosshair',false)
    setLuaSpriteScrollFactor('crosshair',1,1)
    
    setObjectCamera('crosshair','camGame')


	makeLuaSprite('branch','coketruck/branch',70.35,-1260)
	addLuaSprite('branch',false)
    setLuaSpriteScrollFactor('branch',0.8,0.8)


	makeAnimatedLuaSprite('tunnel','coketruck/tunnel',-451.1,-694.3)
	addAnimationByIndices('tunnel','in','tunnel','0,1,2',24)
	addAnimationByIndices('tunnel','out','tunnel','3,4,5',24)
	objectPlayAnimation('tunnel','in',false)
    setLuaSpriteScrollFactor('tunnel',0.9,0.9)

	makeAnimatedLuaSprite('picoarm','tomstage/picoarm',1550,260)
	addAnimationByIndices('picoarm','idle','picoarm','0',24)
	addAnimationByIndices('picoarm','shoot','picoarm','1,2,0',24)
	addLuaSprite('picoarm',true)

	makeAnimatedLuaSprite('pico','tomstage/pico',1350,170)
	addAnimationByPrefix('pico','idle','pico',24,false)
	addAnimationByPrefix('pico','monochrome','im dead',24,false)
	addLuaSprite('pico',true)


	makeAnimatedLuaSprite('smoke','tomstage/smoke',-500,-600)
	addAnimationByPrefix('smoke','smoke','smoke',24,true)
	addLuaSprite('smoke',true)
	objectPlayAnimation('smoke','smoke')

	makeLuaSprite('truck','coketruck/truck',-763.55,451.25)
	addLuaSprite('truck',false)

	makeLuaSprite('lamp','tomstage/lamp',-763.55,-361.25)
	--makeLuaSprite('lamp','tomstage/lamp',1063.55,-361.25)
	addLuaSprite('lamp',false)
    
	makeLuaSprite('treeF','coketruck/tree',-998.2,-265.2)
	addLuaSprite('treeF',true)
    setLuaSpriteScrollFactor('treeF',1.6,1.6)

    
    setProperty('treeF.scale.x',1.3)
    setProperty('treeF.scale.y',1.3)
    
	makeLuaSprite('flash', '', 0, 0);
	makeGraphic('flash',1280,720,'ffffff')
	addLuaSprite('flash', true);
	setLuaSpriteScrollFactor('flash',0,0)
	setProperty('flash.scale.x',1.2)
	setProperty('flash.scale.y',1.2)
	setProperty('flash.alpha',0)
	--setProperty('lamp.visible',true)
	setProperty('picoarm.origin.x',50)
	setProperty('picoarm.origin.y',100)

	--setObjectCamera('picoarm','camOther')
	--setProperty('picoarm.x',600)
	--setProperty('picoarm.y',400)


	precacheSound('boom')
	precacheSound('metalhit')
	precacheSound('shots')
		setProperty('lamp.visible',false)

	


		doTweenX('ss','moon',500,songLength/1000,'linear')
end

local grav = 0
function onTweenCompleted(t)



	if t == 'missle_drop' then
		playSound('boom')
		setProperty('health',-999)
	end
	if t == 'missle_drop2' then
		playSound('boom')
		setProperty('health',-999)
	end

end
function onTimerCompleted(t,l,ll)

	--debugPrint('KILL!!!!!')
	if t == 'killNiggas' then
		triggerEvent('Check Won','','')
	end

	if t == 'boobs' then
	setPropertyFromClass('flixel.FlxG','updateFramerate',fps)
	end

	if t == 'cock' then
	killing = false
	zoomspeed  = 80
	end

end

function onEvent(n,v1,v2)

	if n == "Toggle Battle" and difficulty > 0 then
		battle = v1 == 'true'
		canShootNow = true
		thrusterhp = thrustermaxhp
		objectPlayAnimation('missle1','missle')
		objectPlayAnimation('missle2','missle')
		if battle then
			--debugPrint(thrusterhp)
			runTimer('killNiggas',(stepCrochet/1000)*tonumber(v2))
		
		
		end
	--debugPrint((stepCrochet/1000)*tonumber(v2))
		
	end
	if n == "movaDaTom" then
		--debugPrint(getProperty('inCutscene'))
		zoomspeed = 15
		killing = true;
		sleighx = 2000
		runTimer('cock',2)
	end

	if n == "Check Won" then
	
--	debugPrint('KILL!!!!!')
				killing = false
		if thrusterhp > 0 then
				--debugPrint(thrusterhp)
			
				killing = true
				endSong()
		
		end

	end
	if n == "Missle" then
		--debugPrint('ffff')
		objectPlayAnimation('missle' .. v1,'shoot')
		triggerEvent('Play Animation','missle','dad')

	end
	if n == "hitByTree" then
		tomouch = true
		setObjectOrder('dadGroup',8)
		grav = -20
		playSound('tomouch',1)
		triggerEvent('Screen Shake','0.3,0.03','0.3,0.01')
		triggerEvent('Camera Follow Pos',1020,200)
		triggerEvent('Flash Camera',0.3)
		triggerEvent('Play Animation','end',0)

		
		runTimer('boobs',0.02)

	end
	if n == "spawnpole" then
		
		setProperty('lamp.visible',true)
		doTweenX('dog','lamp',4000,0.7,'linear')

	end

end
local m = 0.01
local shottime = 10;
local shotted = false

function onEndSong()


if killing then
	setProperty('vocals.volume',0);

		objectPlayAnimation('missle1','fire')
		objectPlayAnimation('missle2','fire')
	doTweenY('missle_drop','missle1',getProperty('missle1.y')+500,1,'backIn')
	doTweenY('missle_drop2','missle2',getProperty('missle1.y')+500,1,'backIn')
		setObjectOrder('missle1',getObjectOrder('pico'))
		setObjectOrder('missle2',getObjectOrder('pico'))
	return Function_Stop;

	
end

end


function onUpdate(elapsed)



	DALAPSED = elapsed/0.016
	i = i + DALAPSED 
	shottime = shottime - DALAPSED
	ofsdadx = 700
	ofsdady = -900
	ofssx = 500
	ofssy = -970
	speed = 90*DALAPSED
	ofssx2 = ofssx+84
	ofssy2 = ofssy+318.5

	ofsthx = ofssx+1198.15
	ofsthy = ofssy+259.5

	ofsmssx = ofssx-1621.9
	ofsmssy = ofssy+526.95



	thrusterhitboxx = getProperty('thruster.x')-8;
	thrusterhitboxy = getProperty('thruster.y')+246;

		if botPlay then
			setProperty('crosshair.x',thrusterhitboxx+50);
			setProperty('crosshair.y',thrusterhitboxy+50);
		else
	setProperty('crosshair.x',getMouseX('camGame')+ getProperty('camGame.scroll.x'));
	setProperty('crosshair.y',getMouseY('camGame')+ getProperty('camGame.scroll.y'));

		end
	setProperty('crosshair.offset.x',85);
	setProperty('crosshair.offset.y',85);

		local shotsuffix = ""

	setProperty('picoarm.visible',battle)
--WAS DEBUGING SHIT   setProperty('picoarm.angle',((180*math.atan2(getMouseY('camOther')-getProperty('picoarm.y'),getMouseX('camOther')-getProperty('picoarm.x')))/math.pi))--angle his arm
	setProperty('crosshair.visible',battle);
	if battle then

		triggerEvent('Camera Follow Pos',1220,-200)
		m = 1
		setProperty('picoarm.angle',((180*math.atan2(getProperty('crosshair.y')-getProperty('picoarm.y'),getProperty('crosshair.x')-getProperty('picoarm.x')))/math.pi))--angle his arm
				shotted = false;
			if mousePressed('left') and shottime <= 0 and canShootNow then
				shottime = 12
				shotted = true;
				doTweenColor('ryy7r', 'sleighback', 'ffffff', 0.01, 'linear')
				objectPlayAnimation('picoarm','shoot',true)
				triggerEvent('Screen Shake','0.1,0.01','0.1,0.01')
			end

			if getProperty('crosshair.x') > thrusterhitboxx and getProperty('crosshair.x') < thrusterhitboxx+thrusterhitboxw and getProperty('crosshair.y') > thrusterhitboxy and getProperty('crosshair.y') < thrusterhitboxy+thrusterhitboxh and mousePressed('left') and canShootNow then
					
					shotsuffix = '_shot'
					triggerEvent('Screen Shake','0.3,0.03','0.3,0.03')
					thrusterhp = thrusterhp - DALAPSED
					if thrusterhp <= 0 then
						triggerEvent('Flash Camera',0.1,'')
						setProperty('camHUD.y',50)
						setProperty('camHUD.angle',12)
						setProperty('camHUD.zoom',1.4)
						doTweenY('sss','camHUD',0,0.5,'linear')
						doTweenAngle('ssss','camHUD',0,0.5,'linear')
						thrusterstate = thrusterstate + 1
						canShootNow = false
						playSound('boom')
					end

					if shotted then
						doTweenColor('r7889r', 'sleighback', '666699', 0.1, 'linear')
						shottime =  6
						playSound('shots',0.2)
						playSound('metalhit',0.4)

					end

			else

					if shotted then
					playSound('shots',0.4)

					doTweenColor('r7889r', 'sleighback', '666699', 0.1, 'linear')
					end
				if canShootNow then

					shotsuffix = '_shoot'

				else

					shotsuffix = ''

				end
			end


		objectPlayAnimation('thruster','thruster'.. thrusterstate .. shotsuffix,false)



	else
		m = 0.01
		objectPlayAnimation('thruster','thruster'.. thrusterstate,false)

	end

	if killing then
		sleighx = sleighx-zoomspeed*DALAPSED
	else
		sleighx = math.sin(i/20)*(1000*m)
		sleighy = math.cos(i/20)*(500*m)+300*thrusterstate
	end

	if not tomouch then 
		setProperty('dad.x',sleighx+ofsdadx);
		setProperty('dad.y',sleighy+ofsdady);
	else
		grav = grav + DALAPSED
		setProperty('dad.x',getProperty('dad.x')+10);
		setProperty('dad.y',getProperty('dad.y')+grav);

	end
	setProperty('sleigh.x',sleighx+ofssx);
	setProperty('sleigh.y',sleighy+ofssy);
	setProperty('sleighback.x',sleighx+ofssx2);
	setProperty('sleighback.y',sleighy+ofssy2);
	setProperty('thruster.x',sleighx+ofsthx);
	setProperty('thruster.y',sleighy+ofsthy);
	if not killing then
	setProperty('missle1.x',sleighx+ofsmssx);
	setProperty('missle1.y',sleighy+ofsmssy);
	setProperty('missle2.x',sleighx+ofsmssx);
	setProperty('missle2.y',sleighy+ofsmssy);
	else
	setProperty('missle2.color',getColorFromHex('FFFFFF'));
	setProperty('missle1.color',getColorFromHex('FFFFFF'));

	end

	math.randomseed(i)
	setProperty('tree.x',getProperty('tree.x')+speed)
	if getProperty('tree.x') > 2000 then
		setProperty('tree.flipX',false)
		setProperty('tree.x',-1800)
	end
	if getProperty('tree.x') > 500 then
		setProperty('tree.flipX',true)
	end
	setProperty('treeF.x',getProperty('treeF.x')+speed*1.6)
	if getProperty('treeF.x') > 8000 then
		setProperty('treeF.flipX',false)
		setProperty('treeF.x',-2800)
	end
	if getProperty('treeF.x') > 500 then
		setProperty('treeF.flipX',true)
	end

	
	setProperty('treeF.visible',inTunnel == false)

	setProperty('branch.x',getProperty('branch.x')+speed)
	if getProperty('branch.x') > 9000 then
		setProperty('branch.x',-1800)
	end

	if not inTunnel then
		objectPlayAnimation('tunnel','in',false)

	end

		setProperty('truck.y',451+math.random(-5,5))
		
end
function onCreatePost()
		setObjectOrder('dadGroup',4)
		setObjectOrder('sleigh',4)
		setObjectOrder('sleighback',3)
		setObjectOrder('thruster',3)
		setObjectOrder('missle1',4)
		doTweenColor('rrr', 'boyfriend', '666699', 0.01, 'linear')
		doTweenColor('rr5r', 'gf', '666699', 0.01, 'linear')
		doTweenColor('rr1r', 'dad', '666699', 0.01, 'linear')
		doTweenColor('rr4r', 'pico', '666699', 0.01, 'linear')
		doTweenColor('r5r', 'sleigh', '666699', 0.01, 'linear')
		doTweenColor('r77r', 'sleighback', '666699', 0.01, 'linear')
		doTweenColor('r776', 'missle1', '666699', 0.01, 'linear')
		doTweenColor('r777', 'missle2', '666699', 0.01, 'linear')
		setObjectOrder('lamp',8)

end
function onBeatHit()

	if battle then
		objectPlayAnimation('pico','monochrome',false)
	else
		objectPlayAnimation('pico','idle',true)
	end

end

function goodNoteHit(id, direction, noteType, isSustainNote)
	--if duet == false then
		if noteType == 'GF Sing' then
			
			triggerEvent('Camera Follow Pos',900,100)
		else
			triggerEvent('Camera Follow Pos','','')
		end
	--else
	--	triggerEvent('Camera Follow Pos',640,420)
	--	setProperty('defaultCamZoom', 1)
	--end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	--if duet == false then
		if noteType == 'GF Sing' then
			triggerEvent('Camera Follow Pos',900,100)
		else
			triggerEvent('Camera Follow Pos','','')
		end
	--else
	--	triggerEvent('Camera Follow Pos',640,420)
	--	setProperty('defaultCamZoom', 1)
	--end
end
