local currentLayer = 'hud'
function onCreate()
	createFlash(0.001,'hud',false)--for not lag
end
function createFlash(alpha,layer,front)
	makeLuaSprite('flashEvent',nil,0,0)
	setFlashLayer(layer)
	makeGraphic('flashEvent',screenWidth,screenHeight,'FFFFFF')
	setProperty('flashEvent.alpha',alpha)
	addLuaSprite('flashEvent',front)
end
function onEvent(name,v1,v2)
	if name == 'flash' then
		local speed = 0.4
		local color = 'FFFFFF'
		local layer = 'hud'
		local front = true
		local alphaStart = 1
		if v1 ~= '' and string.len(v1) >= 6 then
			if string.find(v1,',',0,true) ~= nil then
				local comma1, comma2 = string.find(v1,',',0,true)
				color = string.sub(v1,0,comma1 - 1)
				alphaStart = tonumber(string.sub(v1,comma2 + 1))
			else
				color = v1
			end
		end
		if v2 ~= '' then
			local comma1,comma2 = string.find(v2,',',0,true)
			if comma1 ~= nil then
				speed = tonumber(string.sub(v2,0,comma1 - 1))
				local comma3, comma4 = string.find(v2,',',comma2 + 1,true)
				if comma3 ~= nil then
					layer = string.sub(v2,comma2 + 1,comma3 - 1)
					front = (string.sub(v2,comma4 + 1) == true)
				else
					layer = string.sub(v2,comma2 + 1)
				end
				
			else
				speed = tonumber(v2)
			end
		end
		if layer ~= currentLayer then
			currentLayer = layer
		end
		if luaSpriteExists('flashEvent') then
			setFlashLayer(currentLayer)
			setProperty('flashEvent.alpha',alphaStart)
		else
			createFlash(alphaStart,currentLayer,front)
		end
		if not front then
			setObjectOrder('flashEvent',0)
		end
		setProperty('flashEvent.color',getColorFromHex(color))
		doTweenAlpha('flashEventBye','flashEvent',0,speed,'linear')
	end
end
function setFlashLayer(layer)
    if layer == nil then
        layer = 'hud'
    end
	setObjectCamera('flashEvent',layer)
end
function onTweenCompleted(tag)
	if tag == 'flashEventBye' then
		currentLayer = 'hud'
		removeLuaSprite('flashEvent',true)
	end
end