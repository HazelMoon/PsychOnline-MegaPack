function onEvent(eventName, value1, value2)
    if eventName == 'Lights Down OFF' then
        setProperty('camGame.visible', false)
    end
end