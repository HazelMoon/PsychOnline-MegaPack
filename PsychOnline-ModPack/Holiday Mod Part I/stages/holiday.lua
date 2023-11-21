local lastanim = 1;
local newanim = 0;
local ilovewomen = 0;
local ontop = true;
local floor = 15.5;
local floor2 = -88.6;
local floor3 = 237.45;
local grav = 0;
local grav2 = 0;
local grav3 = 0;
local curBe = 0
function onCreate()
	makeLuaSprite('sky', 'holiday/sky', 212.85, -89.4);
	setLuaSpriteScrollFactor('bg', 0.8, 0.9);
	makeLuaSprite('snow', 'holiday/snow', 274.95, -297);
	setLuaSpriteScrollFactor('snow', 0.8, 0.9);
	makeLuaSprite('wall', 'holiday/wall', -329.65, -1016.6);
	setLuaSpriteScrollFactor('wall', 0.8, 0.9);
	makeLuaSprite('present', 'holiday/present', -111.15, 15.5);
	setLuaSpriteScrollFactor('present', 0.9, 0.9);
	makeAnimatedLuaSprite('tree', 'holiday/tree', 875.2, -167);
	addAnimationByIndices('tree','blink0','tree','0',1);
	addAnimationByIndices('tree','blink1','tree','1',1);
	addAnimationByIndices('tree','blink2','tree','2',1);
	addAnimationByIndices('tree','blink3','tree','3',1);
	addAnimationByPrefix('tree','flash','tree',24,true);
	setLuaSpriteScrollFactor('tree', 0.9, 0.9);
	addLuaSprite('sky', false);
	addLuaSprite('snow', false);
	addLuaSprite('wall', false);
	addLuaSprite('present', false);
	addLuaSprite('tree', false);
	lastanim = 0;
	objectPlayAnimation('tree','blink' .. lastanim ,false);
end
function onBeatHit()
curBe = math.floor(curStep/4)
	if ilovewomen == 0 then
		triggerEvent('light','','')
	end

end

function onUpdate(elapsed)
	DALAPSED = elapsed/0.016

	if ilovewomen > 0 then
		ilovewomen = ilovewomen - 1
	end

	setProperty('snow.y',getProperty('snow.y') + 1);

	if getProperty('snow.y') >= 0 then
		setProperty('snow.y',-297);
	end

	if getProperty('present.y') >= floor then
		setProperty('present.y',floor);
		--grav = 0
	else
		grav = grav + 0.9*DALAPSED;
	end
	if getProperty('boyfriend.y') >= floor3 then
		setProperty('boyfriend.y',floor3);
		--grav3 = 0
	else
		grav3 = grav3 + 1*DALAPSED;
	end
	if getProperty('dad.y') >= floor2 then
		setProperty('dad.y',floor2);
		--grav2 = 0
	else
		grav2 = grav2 + 0.8*DALAPSED;
	end
	setProperty('present.y',getProperty('present.y')+grav);
	setProperty('boyfriend.y',getProperty('boyfriend.y')+grav3)
	setProperty('dad.y',getProperty('dad.y')+grav2)


	if curBe >= 68 and curBe <84 then
		setProperty('defaultCamZoom',getProperty('defaultCamZoom')+0.001*DALAPSED);
	end

	if curBe >= 154 and curBe <172  then
		setProperty('defaultCamZoom',getProperty('defaultCamZoom')+0.001*DALAPSED);
	end

	if curBe >= 208 and curBe <212 then
		setProperty('defaultCamZoom',getProperty('defaultCamZoom')+0.001*DALAPSED);
	end
end

function onEvent(name,value1,value2)
	if name == 'light' then
		newanim = math.random(0,3);
		objectPlayAnimation('tree','blink' .. newanim,false);
		if lastanim == newanim then
			triggerEvent('light','','')
		else
			lastanim = newanim
		end
	end
	if name == 'Add Camera Zoom' then
		if value1 == '0.04' or value1 == '0.06' or value1 == '0.1'then
			setProperty('defaultCamZoom',1);
			ilovewomen = math.floor((crochet/1000)*framerate);
			grav = -8;
			grav3 = -8;
			grav2 = -8;
			objectPlayAnimation('tree','flash',false);
		end
	end
	if name == 'Trigger BG Ghouls' then
		typebeat = value1
	end
end



