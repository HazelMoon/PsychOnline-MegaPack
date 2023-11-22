function onEvent(eventName, value1, value2)
    if eventName == 'Char Alt Idle Animation' then
        runHaxeCode([[
            if (game.variables[']]..value1..[['] != null)
            {
                game.variables[']]..value1..[['].idleSuffix = ']]..value2..[[';
                game.variables[']]..value1..[['].recalculateDanceIdle();
            }
        ]]);
    end
end