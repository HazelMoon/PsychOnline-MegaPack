local zooming = false
local curZoom = nil
function onEvent(name,value1,value2)
    if name == "Set Cam Zoom" then
		local easing = 'sineInOut'
		local duration = 0
		if string.find(value2,',',0,true) ~= nil then
			local comma1,comma2 = string.find(value2,',',0,true)
			easing = string.sub(value2,comma2 + 1)
			duration = string.sub(value2,0,comma1 - 1)
		else
			duration = value2
		end
		if string.match(value1,'cur') == 'cur' and string.find(value1,',',0,true) ~= nil then
			local comma1,comma2 = string.find(value1,',',0,true)
			if curZoom == nil then
				curZoom = getProperty('defaultCamZoom') + string.sub(value1,comma2 + 1)
			else
				 curZoom = curZoom + string.sub(value1,comma2 + 1)
			end
		else
			curZoom = value1
		end
		cancelTween('camz')
		if value2 ~= '' then
			if duration ~= 0 then
				doTweenZoom('camz','camGame',curZoom,duration,easing)
			else
				setProperty('camGame.zoom',curZoom)
				setProperty('defaultCamZoom',curZoom)
			end
		else
			setProperty('defaultCamZoom',curZoom)
		end
		zooming = true
	elseif name == 'Add Camera Zoom' and zooming then
		local zoom = value1
		if zoom == '' then
			zoom = 0.015
		end
		setProperty('camGame..zoom',getProperty('camGame.zoom')-zoom)
	end
end
function onBeatHit()
	if curBeat % 4 == 0 and getProperty('camZooming') == true and zooming == true then
		setProperty('camGame.zoom',getProperty('camGame.zoom') - 0.015)
	end
end
function onTweenCompleted(name)
	if name == 'camz' then
		setProperty("defaultCamZoom",getProperty('camGame.zoom'))
		curZoom = nil
		zooming = false
	end
end