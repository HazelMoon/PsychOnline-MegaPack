function onCreatePost()
    setProperty('healthBar.angle',90)
    setProperty('healthBar.x',screenWidth - 450)
    setProperty('healthBar.y',screenHeight/2 + (getProperty('healthBar.height')/2))
end
function onUpdatePost()
    setProperty('iconP1.x',getProperty('healthBar.x') + (getProperty('healthBar.height')/2) + 215)
    setProperty('iconP2.x',getProperty('healthBar.x') + (getProperty('healthBar.height')/2) + 215)
    if getProperty('health') > 0 and getProperty('health') < 2 then
        setProperty('iconP1.y',getProperty('healthBar.width')/2 - getHealth() * 300 + 200 + 150 - 20)
        setProperty('iconP2.y',getProperty('healthBar.width')/2 - getHealth() * 300 + 200 + 60)
    end
end