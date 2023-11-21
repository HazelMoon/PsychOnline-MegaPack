function onCreate()
    makeLuaSprite('TDP2BG','TDP2/ground',150,350)
    scaleObject('TDP2BG',1.95,1.65)
    addLuaSprite('TDP2BG')

    makeLuaSprite('TDP2Light','TDP2/light',150,350)
    scaleObject('TDP2Light',1.95,1.65)
    addLuaSprite('TDP2Light',true)
end
local bfVisible = 0
function onUpdate()
    if bfVisible == 0 then
        setProperty('boyfriend.visible',false)
        bfVisible = 2
    end
end