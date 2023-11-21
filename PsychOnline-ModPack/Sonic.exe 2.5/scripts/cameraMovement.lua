local DadX = 0
local DadY = 0

local BfX = 0
local BfY = 0

local GfX = 0
local GfY = 0

local BfOfs = 50
local GfOfs = 50
local DadOfs = 50

local enableSystem = true

--[[If you want to know the credits:
i got a ideia of the script by Washo789, 
the script is made by BF Myt.]]--
function onCreatePost()
    if curStage == 'execution' then
        BfOfs = 30
        DadOfs = 30
        GfOfs = 30
    end
    if getProperty('dad.curCharacter') == 'true-fatal' then
        DadOfs = 100
    end
end
function onUpdate()
    if enableSystem == true then
        if gfSection == false or gfSection == nil then
            if mustHitSection == false then
                DadX = getMidpointX('dad') + 150 + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]')
                DadY = getMidpointY('dad') - 100 + getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]')
                if getProperty('dad.animation.curAnim.name') == 'singLEFT' or getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                    triggerEvent('Camera Follow Pos',DadX-DadOfs,DadY)

                elseif getProperty('dad.animation.curAnim.name') == 'singRIGHT' or getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                    triggerEvent('Camera Follow Pos',DadX+DadOfs,DadY)

                elseif getProperty('dad.animation.curAnim.name') == 'singUP' or getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                        triggerEvent('Camera Follow Pos',DadX,DadY-DadOfs)

                elseif getProperty('dad.animation.curAnim.name') == 'singDOWN' or getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                    triggerEvent('Camera Follow Pos',DadX,DadY+DadOfs)

                else
                    triggerEvent('Camera Follow Pos',DadX,DadY)

                end
            else
                if curStage ~= 'TDP2' then
                    BfX = getMidpointX('boyfriend') - 100 - getProperty('boyfriend.cameraPosition[0]') + getProperty('boyfriendCameraOffset[0]')
                    BfY = getMidpointY('boyfriend') - 100 + getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]')
                else
                    BfX = getMidpointX('dad') + 150 + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]')
                    BfY = getMidpointY('dad') - 100 + getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]')
                end
                if string.find(getProperty('boyfriend.animation.curAnim.name'),'singLEFT',0,true) ~= nil then
                    triggerEvent('Camera Follow Pos',BfX-BfOfs,BfY)
                elseif string.find(getProperty('boyfriend.animation.curAnim.name'),'singRIGHT',0,true) ~= nil then
                    triggerEvent('Camera Follow Pos',BfX+BfOfs,BfY)

                elseif string.find(getProperty('boyfriend.animation.curAnim.name'),'singUP',0,true) ~= nil then
                    triggerEvent('Camera Follow Pos',BfX,BfY-BfOfs)
                elseif string.find(getProperty('boyfriend.animation.curAnim.name'),'singDOWN',0,true) ~= nil then
                    triggerEvent('Camera Follow Pos',BfX,BfY+BfOfs)
                else
                    triggerEvent('Camera Follow Pos',BfX,BfY)

                end
            end
        else
            GfX = getMidpointX('gf') + getProperty('gf.cameraPosition[0]') + getProperty('girlfriendCameraOffset[0]')
            GfY = getMidpointY('gf') + getProperty('gf.cameraPosition[1]') + getProperty('girlfriendCameraOffset[1]')
            if getProperty('gf.animation.curAnim.name') == 'singLEFT' or getProperty('gf.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',GfX-GfOfs,GfY)

            elseif getProperty('gf.animation.curAnim.name') == 'singRIGHT' or getProperty('gf.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',GfX+GfOfs,GfY)

            elseif getProperty('gf.animation.curAnim.name') == 'singUP' or getProperty('gf.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',GfX,GfY - GfOfs)

            elseif getProperty('gf.animation.curAnim.name') == 'singDOWN' or getProperty('gf.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',GfX,GfY + GfOfs)

            else
                triggerEvent('Camera Follow Pos',GfX,GfY)
            end
        end
    end
end