local chromAmount = 0
local chromFreq = 1
local isChrom = true

function onCreate()
    addLuaScript('custom_events/setChrom')
end

function onEvent(n,v1,v2)
	if n == 'chromToggle' then
		theAmount = tonumber(v1)
		theAmount2 = tonumber(v1)
		if theAmount2 == nil then
			theAmount2 = 0
		end
		if theAmount == nil or theAmount == 0 then
            isChrom = false
			chromAmount = 0
        else
            isChrom = true
			chromAmount = theAmount
			chromFreq = theAmount2
		end
	end
end

function onBeatHit()
    -- debugPrint('hii')
    if curBeat % chromFreq == 0 then
        setShaderFloat('ChromaticAbberation', chromAmount)
        triggerEvent('setChrom', '0', ''..chromFreq)
        -- debugPrint('hi')
    end
end