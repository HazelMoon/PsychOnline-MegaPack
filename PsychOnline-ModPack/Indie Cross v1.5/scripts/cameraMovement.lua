local BfOfs = 20
local GfOfs = 20
local DadOfs = 20

local BfOfsX = 0
local BfOfsY = 0

local GfOfsX = 0
local GfOfsY = 0

local DadOfsX = 0
local DadOfsY = 0

local enableSystem = true

local currentTarget = ''

local targetX = 0
local targetY = 0

local targetXMove = 0
local targetYMove = 0
--[[If you want to know the credits:
i got a ideia of the script by Washo789, 
the script is made by BF Myt.]]--
function onCreatePost()
    setProperty('camFollowPos.x',getProperty('dadGroup.x') + (getProperty('boyfriendGroup.x') - getProperty('dadGroup.x')))
    setProperty('camFollowPos.y',getProperty('dadGroup.y'))
end
function onUpdate()
    if enableSystem == true and not getProperty('isCameraOnForcedPos') then
        --[[if curSection ~= nil then
            if gfSection ~= true then
                if mustHitSection == false  then
                    if currentSection ~= 'dad' then
                        currentTarget = 'dad'
                        currentSection = 'dad'
                    end
                else
                    if currentSection ~= 'boyfriend' then
                        currentTarget = 'boyfriend'
                        currentSection = 'boyfriend'
                    end
                end
            else
                if currentSection ~= 'gf' then
                    currentTarget = 'gf'
                    currentSection = 'gf'
                end
            end
        end]]--
        targetXMove = 0
        targetYMove = 0
        if currentTarget == 'boyfriend' then
            local bfAnim = getProperty('boyfriend.animation.curAnim.name')
            targetX = getMidpointX('boyfriend') - 100 - getProperty('boyfriend.cameraPosition[0]') + getProperty('boyfriendCameraOffset[0]') + BfOfsX
            targetY = getMidpointY('boyfriend') - 100 + getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]') + BfOfsY
    
            if string.find(bfAnim,'singLEFT',0,true) ~= nil then
                targetXMove = -BfOfs
    
            elseif string.find(bfAnim,'singDOWN',0,true) ~= nil then
                targetYMove = BfOfs
    
            elseif string.find(bfAnim,'singRIGHT',0,true) ~= nil then
                targetXMove = BfOfs
    
            elseif string.find(bfAnim,'singUP',0,true) ~= nil then
                 targetYMove = -BfOfs
            end
    
        elseif currentTarget == 'dad' then
            local dadAnim = getProperty('dad.animation.curAnim.name')
            targetX = getMidpointX('dad') + 150 + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]') + DadOfsX
            targetY = getMidpointY('dad') - 100 + getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]') + DadOfsY
    
            if string.find(dadAnim,'singLEFT',0,true) ~= nil then
                targetXMove = -DadOfs
    
            elseif string.find(dadAnim,'singDOWN',0,true) ~= nil then
                targetYMove = DadOfs
    
            elseif string.find(dadAnim,'singUP',0,true) ~= nil then
                targetYMove = -DadOfs
    
            elseif string.find(dadAnim,'singRIGHT',0,true) ~= nil then
                targetXMove = DadOfs
            end
        elseif currentTarget == 'gf' then
            local gfAnim = getProperty('gf.animation.curAnim.name')
            targetX = getMidpointX('gf') + getProperty('gf.cameraPosition[0]') + getProperty('girlfriendCameraOffset[0]') + GfOfsX
            targetY = getMidpointY('gf') + getProperty('gf.cameraPosition[1]') + getProperty('girlfriendCameraOffset[1]') + GfOfsY
            if string.find(gfAnim,'singLEFT',0,true) ~= nil then
                targetXMove = -GfOfs
    
            elseif string.find(gfAnim,'singDOWN',0,true) ~= nil then
                targetYMove = GfOfs
    
            elseif string.find(gfAnim,'singUP',0,true) ~= nil then
                targetYMove = -GfOfs
    
            elseif string.find(gfAnim,'singRIGHT',0,true) ~= nil then
                targetXMove = GfOfs
            end
        end
        setProperty('camFollow.x',targetX+targetXMove)
        setProperty('camFollow.y',targetY+targetYMove)
    end
end
function onMoveCamera(focus)
    currentTarget = focus
end