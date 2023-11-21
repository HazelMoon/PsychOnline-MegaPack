function onCreate()
    addLuaScript('custom_events/objectAlpha')
end
function onEvent(name,v1,v2)
    if name == 'Fade Cameras' then
        triggerEvent('objectAlpha','camGame,'..v1,v2)
        triggerEvent('objectAlpha','camHUD,'..v1,v2)
    end
end