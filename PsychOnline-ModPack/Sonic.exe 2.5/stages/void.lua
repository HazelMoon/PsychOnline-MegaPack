function onCreate()
    setProperty('camGame.bgColor',getColorFromHex('FFFFFF'))
end
function onDestroy()
    setProperty('camGame.bgColor',getColorFromHex('FF0000'))
end