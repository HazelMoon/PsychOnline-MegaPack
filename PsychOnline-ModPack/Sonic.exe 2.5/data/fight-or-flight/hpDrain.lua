local currentBarPorcent = 0
function onCreatePost()
    makeLuaSprite('FearBarImage','fearbar',screenWidth - 100,100)
    scaleObject('FearBarImage',1.2,1.1)
    setObjectCamera('FearBarImage','hud')
    addLuaSprite('FearBarImage',true)


    makeLuaSprite('FearBarBg','fearbarBG',getProperty('FearBarImage.x') + 15,getProperty('FearBarImage.y'))
    setObjectCamera('FearBarBg','hud')
    scaleObject('FearBarBg',0.82,1.1)
    addLuaSprite('FearBarBg',false)
    
    makeLuaSprite('FearBarBar','',getProperty('FearBarImage.x') + 20,getProperty('FearBarImage.y'))
    setObjectCamera('FearBarBar','hud')
    makeGraphic('FearBarBar',getProperty('FearBarBg.width')/2,getProperty('FearBarBg.height'),'FF0000')

    addLuaSprite('FearBarBar',false)
end
function onUpdate()
    setGraphicSize('FearBarBar',getProperty('FearBarBg.width')/1.8 * getProperty('FearBarBg.scale.x'),math.max(1,getProperty('FearBarBg.height')/1.132 * currentBarPorcent))
    setProperty('FearBarBar.x',getProperty('FearBarBg.x') + 20)
    setProperty('FearBarBar.x',getProperty('FearBarBg.x') + 20)
    setProperty('FearBarBar.y',getProperty('FearBarImage.y') + 305 - getProperty('FearBarBar.height'))

    if currentBarPorcent > 1 then
        currentBarPorcent  = 1
    end
end
function opponentNoteHit()
    if currentBarPorcent < 1 then
        currentBarPorcent = currentBarPorcent + 0.0028
    end
end
function goodNoteHit()
    if currentBarPorcent > 0 then
        currentBarPorcent = currentBarPorcent - 0.0026
    end
end
function noteMiss(id,dir,type,sustain)
    if type == '' then
        if currentBarPorcent < 1 then
            currentBarPorcent = currentBarPorcent + 0.0028
        end
    end
end
function onBeatHit()
    if currentBarPorcent > 0.53 and curStep < 2144 then
        if getHealth() > 0.08 and currentBarPorcent < 1  then
            addHealth(-0.046)
        end
    end
end