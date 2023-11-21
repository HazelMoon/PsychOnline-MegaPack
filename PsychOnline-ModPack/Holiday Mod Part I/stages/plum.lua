local charsloaded = 6;
local bfx = 536;
local bfy = -83;
local gfx = 846.95;
local gfy = -287;
local xx = 126
local yy = 268
local xx2 = 536
local yy2 = 283
local xx3 = 146
local yy3 = 103
local xx4 = 96.05
local yy4 = -87.1
local ofs = 40
local zoomshit = 0;
local followchars = true
local camSpeed = 4;
local camInt = 1;
function onCreate()

		makeLuaSprite('bg','plum/bg',-665.35, -726.15)
		makeLuaSprite('coinsbg','plum/coinsbg',-872.5, 25)
		makeLuaSprite('coins','plum/coins',-1215, 352.8)
		makeLuaSprite('safe','plum/safe',753.6, 233)
		makeLuaSprite('moneybag','plum/moneybag',-617.1, 231.25)
		makeLuaSprite('moneybag2','plum/moneybag2',-294.4, 890.45)
		makeLuaSprite('coinsfg','plum/coinsfg',-123.65, 509.9)
		makeLuaSprite('shad','plum/shadow',-938.25, -881)
		makeAnimatedLuaSprite('onepercent','plum/onepercent',241.1, 242.5)
		addAnimationByPrefix('onepercent','bop','onepercent',24,false);

		makeAnimatedLuaSprite('secondDad','characters/sunday',96.05, -87.1)
		addAnimationByPrefix('secondDad','idle','sunday idle',24,false);
		addAnimationByPrefix('secondDad','singLEFT','sunday left',24,false);
		addAnimationByPrefix('secondDad','singRIGHT','sunday right',24,false);
		addAnimationByPrefix('secondDad','singUP','sunday up',24,false);
		addAnimationByPrefix('secondDad','singDOWN','sunday down',24,false);
		objectPlayAnimation('secondDad','idle',true);

		addLuaSprite('bg',false)
		addLuaSprite('coinsbg',false)
		addLuaSprite('coins',false)
		addLuaSprite('safe',false)
		addLuaSprite('secondDad',false)
		addLuaSprite('onepercent',false)
		addLuaSprite('moneybag',true)
		addLuaSprite('moneybag2',true)
		addLuaSprite('shad',false)
		addLuaSprite('coinsfg',true)
		setBlendMode('shad','multiply')



		setLuaSpriteScrollFactor('bg', 0.3, 0.3);
		setLuaSpriteScrollFactor('coinsbg', 0.4, 0.4);
		setLuaSpriteScrollFactor('coinsfg', 1.4, 1.4);

end

function onStepHit()

	if curStep % camSpeed == 0 then
		triggerEvent('Add Camera Zoom',0.015*camInt,0.03*camInt)
	end

end

function onBeatHit()
	if getProperty('dad.animation.curAnim.name') == 'idle' then
		characterPlayAnim('dad','idle',true)
	end
	if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
		characterPlayAnim('boyfriend','idle',true)
	end
	objectPlayAnimation('onepercent','bop',true);

	if mustHitSection then
		objectPlayAnimation('secondDad','idle',true)

                setProperty('secondDad.offset.x',0)
                setProperty('secondDad.offset.y',0)
	else

		if getProperty('secondDad.animation.curAnim.name') == 'idle' then
			objectPlayAnimation('secondDad','idle',true)

	        setProperty('secondDad.offset.x',0)
	        setProperty('secondDad.offset.y',0)
		end

	end


	if mustHitSection then
		setProperty('defaultCamZoom',0.57);
	else
		setProperty('defaultCamZoom',1);

	end
end

function onUpdate()
	if charsloaded == 2 then --see i did this before onCreatePost existed
		setProperty('boyfriend.scrollFactor.x', 1.4);
		setProperty('boyfriend.scrollFactor.y', 1.4);
		setObjectOrder('boyfriend',getObjectOrder('dad'));
		setProperty('gf.visible', false);
		--setObjectOrder('shad',getObjectOrder('dad'));

		



	end



	for i = 0, getProperty('notes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('notes', i, 'noteType') == 'Second Dad Sing' then

			if getPropertyFromGroup('notes', i, 'mustPress') then
				if getPropertyFromGroup('notes', i, 'strumTime') <= getSongPosition() then --Doesn't let Dad/Opponent notes get ignored
					nd = getPropertyFromGroup('notes', i, 'noteData')
					triggerEvent('dad2sing',nd,'')
					--objectPlayAnimation('secondDad',nd,true)
				end
			end
		end
	end





	charsloaded = charsloaded-1;
--3d lookin shit
	zoomshit = (getProperty('camGame.zoom')/0.57);
	setCharacterX('boyfriend',bfx*zoomshit)
	setCharacterY('boyfriend',bfy*zoomshit)
	setProperty('boyfriend.scale.x',zoomshit)
	setProperty('boyfriend.scale.y',zoomshit)
	setProperty('gf.scale.x',zoomshit)
	setProperty('gf.scale.y',zoomshit)
	setCharacterX('gf',gfx*zoomshit)
	setCharacterY('gf',gfy*zoomshit)
	setProperty('coinsfg.scale.x',zoomshit)
	setProperty('coinsfg.scale.y',zoomshit)
	
	setProperty('coinsfg.x',-123.65*zoomshit)
	setProperty('coinsfg.y',509.9*zoomshit)
--



    if followchars == true then
        if mustHitSection == false then
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else

            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    end

end


local  u = 0

function goodNoteHit(id, noteData, noteType, isSustainNote)

	followchars = true
	setProperty('gf.x', 846.95);
	setProperty('gf.y', -287);
	setScrollFactor('gf', 1,1);

end
function opponentNoteHit(id, noteData, noteType, isSustainNote)

	followchars = true
	if noteType == 'Both Dads Sing' or noteType == 'Second Dad Sing' then
		followchars = false
		triggerEvent('dad2sing',noteData,'')

	end
end


function onTimerCompleted(t,l,ll)
	if t == 'dadhold' .. u then
			objectPlayAnimation('secondDad','idle',true)

                setProperty('secondDad.offset.x',0)
                setProperty('secondDad.offset.y',0)
	end
end
function onEvent( name, value1,value2)
	if name == 'Camera Zoom Speed' then
		camSpeed = value1
		camInt = value2
	end
	if name == 'Set GF Speed' then
	setProperty('gf.visible', true);
	end
	if name == 'stopbf' then
	setProperty('boyfriend.stunned', true);
	end
	if name == 'gobf' then
	setProperty('boyfriend.stunned', false);
	end
	if name == "dad2sing" then

		cancelTimer('dadhold' .. u, 0.3, 1)
		u = u + 1
		runTimer('dadhold' .. u, 0.3, 1)

		if value1 == '0' then
			objectPlayAnimation('secondDad','singLEFT',true)
                setProperty('secondDad.offset.x',40)
                setProperty('secondDad.offset.y',-22)
                triggerEvent('Camera Follow Pos',xx3-ofs,yy3)
		end
		if value1 == '1' then
			objectPlayAnimation('secondDad','singDOWN',true)
                setProperty('secondDad.offset.x',38)
                setProperty('secondDad.offset.y',-52)
                triggerEvent('Camera Follow Pos',xx3,yy3+ofs)
		end
		if value1 == '2' then
			objectPlayAnimation('secondDad','singUP',true)
                setProperty('secondDad.offset.x',-29)
                setProperty('secondDad.offset.y',11)
                triggerEvent('Camera Follow Pos',xx3,yy3-ofs)
		end
		if value1 == '3' then
			objectPlayAnimation('secondDad','singRIGHT',true)
                setProperty('secondDad.offset.x',-52)
                setProperty('secondDad.offset.y',1)
                triggerEvent('Camera Follow Pos',xx3+ofs,yy3)
		end
	end
end
           