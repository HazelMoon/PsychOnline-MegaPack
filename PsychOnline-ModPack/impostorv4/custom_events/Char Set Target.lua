local on = true;
local val1;
local val2;
function onEvent(eventName, value1, value2)
    if eventName == 'Char Set Target' then
        val1 = value1;
        val2 = value2;

        if val1 == nil or val1 == '' and val2 == nil or val2 == '' then
            on = false;
        else
            on = true;
        end

        function onUpdate(elapsed)
            if on then
                if val2 == 'dadGroup' then
                    posX1 = getMidpointX(val1) + 150 + getProperty(val1..'.cameraPosition[0]') + getProperty('opponentCameraOffset[0]');
                    posY1 = getMidpointY(val1) - 100 + getProperty(val1..'.cameraPosition[1]') + getProperty('opponentCameraOffset[1]');
        
                    triggerEvent('Camera Follow Pos', posX1, posY1);
        
                elseif val2 == 'boyfriendGroup' then
                    posX2 = getMidpointX(val1) - 100 - getProperty(val1..'.cameraPosition[0]') + getProperty('boyfriendCameraOffset[0]');
                    posY2 = getMidpointY(val1) - 100 + getProperty(val1..'.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]');
        
                    triggerEvent('Camera Follow Pos', posX2, posY2);
        
                elseif val2 == 'gfGroup' then
                    posX3 = getMidpointX(val1) + getProperty(val1..'.cameraPosition[0]') + getProperty('girlfriendCameraOffset[0]');
                    posY3 = getMidpointY(val1) + getProperty(val1..'.cameraPosition[1]') + getProperty('girlfriendCameraOffset[1]');
        
                    triggerEvent('Camera Follow Pos', posX3, posY3);
                end
            else
                triggerEvent('Camera Follow Pos', '', '');
            end
        end
    end
end