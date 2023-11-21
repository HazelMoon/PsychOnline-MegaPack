local speed = 90
local i =0
local inTunnel = true

local momshow = false


function onCreate()

	makeLuaSprite('sky','coketruck/sky',-1050,-800)
	addLuaSprite('sky',false)
    setLuaSpriteScrollFactor('sky',0.1,0.1)
	scaleObject('sky',1.3,1.3)

	makeLuaSprite('moon','coketruck/moon',-500,-360)
	addLuaSprite('moon',false)
    setLuaSpriteScrollFactor('moon',0.1,0.1)

	makeLuaSprite('tree','coketruck/tree',-998.2,-265.2)
	addLuaSprite('tree',false)
    setLuaSpriteScrollFactor('tree',0.8,0.8)
    

	makeLuaSprite('branch','coketruck/branch',70.35,-860)
	addLuaSprite('branch',false)
    setLuaSpriteScrollFactor('branch',0.8,0.8)


	makeAnimatedLuaSprite('tunnel','coketruck/tunnel',-451.1,-694.3)
	addAnimationByIndices('tunnel','in','tunnel','0,1,2',24)
	addAnimationByIndices('tunnel','out','tunnel','3,4,5',24)
	objectPlayAnimation('tunnel','in',false)
	addLuaSprite('tunnel',false)
    setLuaSpriteScrollFactor('tunnel',0.9,0.9)


	makeLuaSprite('truck','coketruck/truck',-763.55,451.25)
	addLuaSprite('truck',false)
    






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

		doTweenX('ss','moon',500,songLength/1000,'linear')
end

function onEvent(n,v1,v2)

	if n == "tunnel shit" then
		inTunnel = false
		objectPlayAnimation('tunnel','out',false)
		doTweenColor('rrr', 'boyfriend', '666699', 0.1, 'linear')
		doTweenColor('rr5r', 'gf', '666699', 0.1, 'linear')
		doTweenColor('rr1r', 'dad', '666699', 0.1, 'linear')
	end

end
function onUpdate(elapsed)
i = i + 1

	DALAPSED = elapsed/0.016
	speed = 90*DALAPSED

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

	if inTunnel then
		objectPlayAnimation('tunnel','in',false)

		doTweenColor('rrr', 'boyfriend', '555533', 0.1, 'linear')
		doTweenColor('rr5r', 'gf', '555533', 0.1, 'linear')
		doTweenColor('rr1r', 'dad', '555533', 0.1, 'linear')
	end

		setProperty('truck.y',451+math.random(-5,5))
		
end


function goodNoteHit(id, direction, noteType, isSustainNote)
	
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	
end
