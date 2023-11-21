local flashCreated = false
function onEvent(name,v1,v2)
	if name == 'flash' then
		local flashColor = 'FFFFFF'
		local easing = 'linear'
		local layer = 'other'
		local duration = 0.7
		local blendMode = ''
		local alpha = 1
		local ahead = false

		
		if v1 ~= '' then
			local commaStartV1 = 0
			local commaEndV1 = 0
			local commaStart2V1 = 0
			local commaEnd2V1 = 0
			commaStartV1,commaEndV1 = string.find(v1,',',0,true)
			if commaStartV1 ~= nil then
				commaStart2V1,commaEnd2V1 = string.find(v1,',',commaStartV1 + 1,true)
			end

			if commaStartV1 ~= nil then 
				flashColor = string.sub(v1,0,commaStartV1 - 1)
				if commaEnd2V1 == nil then
					blendMode = string.sub(v1,commaStartV1 + 1)
				else
					blendMode = string.sub(v1,commaStartV1 + 1,commaStart2V1 - 1)
					alpha = string.sub(v1,commaStart2V1 + 1)
				end
			else
				flashColor = v1
			end
		end
		if v2 ~= '' then
			if string.find(string.lower(v2),'ahead:true',0,true) ~= nil then
				ahead = true
			end

			local commaStartV2 = 0
			local commaEndV2 = 0
			
			local commaStart2V2 = 0
			local commaEnd2V2 = 0
			commaStartV2,commaEndV2 = string.find(v2,',',0,true)
			if commaStartV2 ~= nil then
				commaStart2V2,commaEnd2V2 = string.find(v2,',',commaStartV2 + 1,true)
			end
			if commaStartV2 ~= nil then
				duration = string.sub(v2,0,commaStartV2 - 1)
				if commaEnd2V2 == nil then
					easing = string.sub(v2,commaStartV2 + 1)
				else
					easing = string.sub(v2,commaStartV2 + 1,commaStart2V2 - 1)
					layer = string.sub(v2,commaStart2V2 + 1)
				end
			else
				duration = v2
			end
		end
		cancelTween('byeFlashE')
		if not flashCreated then
			makeLuaSprite('flashEvent',nil,0,0)
			makeGraphic('flashEvent',screenWidth,screenHeight,flashColor)
			addLuaSprite('flashEvent', ahead);
		end
		setProperty('flashEvent.alpha',alpha)
		setObjectCamera('flashEvent',layer)
		
		if blendMode ~= nil and blendMode ~= '' then
			setBlendMode('flashEvent',blendMode)
		end
		doTweenAlpha('byeFlashE','flashEvent',0,duration,easing)
	end
end
function onTweenCompleted(name)
	if tag == 'byeFlashE' then
		removeLuaSprite('flashEvent',true)
		flashCreated = false
	end
end