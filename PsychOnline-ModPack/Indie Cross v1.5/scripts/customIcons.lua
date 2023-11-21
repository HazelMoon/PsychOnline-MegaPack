local enabled = false
local offsetX = 0
local offsetY = 0
local animOffsetX = 0
local animOffsetY = 0
local iconAnim = 'Normal'
local animsOffset = {}
function onCreatePost()
    detectCharacter()
end
function detectCharacter()
    local dad = getProperty('dad.curCharacter')
    if dad == 'Nightmare-Bendy' then
        createIcon('icons/icon-nightmare-bendy(animated)',{{'Normal','nightmare bendy normal',24,true},{'Losing','nightmare bendy win',24,true,55,40}},0,0)
    elseif dad == 'Nightmare-Sans' then
        --createIcon('icons/icon-nightmare-sans(animated)',{{'Normal','normal',24,true,0,0},{'Losing','loss',24,true,-120,-50}},-60,-60)
    else
        removeIcon()
    end
end
function createIcon(file,anims,offX,offY)
    makeAnimatedLuaSprite('icon-nightmare',file,0,0)
    enabled = true
    for animsArray = 1,#anims do
        local animOffX = anims[animsArray][5]
        local animOffY = anims[animsArray][6]
        if animOffX == nil then
            animOffX = 0
        end
        if animOffY == nil then
            animOffY = 0
        end
        addAnimationByPrefix('icon-nightmare',anims[animsArray][1],anims[animsArray][2],anims[animsArray][3],anims[animsArray][4])
        table.insert(animsOffset,{anims[animsArray][1],animOffX,animOffY})
    end
    objectPlayAnimation('icon-nightmare','Normal',true)
    setObjectCamera('icon-nightmare','hud')
    addLuaSprite('icon-nightmare',false)
    setObjectOrder('icon-nightmare',getObjectOrder('iconP2'))
    setProperty('iconP2.alpha',0)
    offsetX = offX
    offsetY = offY
end
function removeIcon()
    if enabled then
        removeLuaSprite('icon-nightmare',true)
        setProperty('iconP2.alpha',1)
        enabled = false
    end
end
function onEvent(name)
    if name == 'Change Character' then
        detectCharacter()
    end
end
function iconPlayAnim(anim,force)
    if anim ~= iconAnim then
        for offsets = 1,#animsOffset do
            if animsOffset[offsets][1] == anim then
                animOffsetX = (animsOffset[offsets][2]) * -1
                animOffsetY = (animsOffset[offsets][3]) * -1
                setProperty('icon-nightmare.offset.x',animOffsetX - offsetX)
                setProperty('icon-nightmare.offset.y',animOffsetY - offsetY)
            end
        end
        iconAnim = anim
    end
    objectPlayAnimation('icon-nightmare',anim,force)
end
function onUpdate()
    if enabled then
        local iconOffX = getProperty('iconP2.offset.x') - offsetX - animOffsetX
        local iconOffY = getProperty('iconP2.offset.y') - offsetY - animOffsetY
        setProperty('icon-nightmare.x',getProperty('iconP2.x'))
        setProperty('icon-nightmare.y',getProperty('iconP2.y'))
        setProperty('icon-nightmare.offset.x',iconOffX)
        setProperty('icon-nightmare.offset.y',iconOffY)
        setProperty('icon-nightmare.scale.x',getProperty('iconP2.scale.x'))
        setProperty('icon-nightmare.scale.y',getProperty('iconP2.scale.y'))
        setProperty('icon-nightmare.angle',getProperty('iconP2.angle'))
        if getProperty('health') > 1.3 then
            if iconAnim ~= 'Losing' then
                iconPlayAnim('Losing',false)
            end
        else
            if iconAnim ~= 'Normal' then
                iconPlayAnim('Normal',false)
            end
        end
    end
end