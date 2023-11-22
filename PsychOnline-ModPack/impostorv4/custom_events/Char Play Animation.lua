function onEvent(eventName, value1, value2)
    if eventName == 'Char Play Animation' then
        runHaxeCode([[
            if (game.variables[']]..value2..[['] != null)
            {
                game.variables[']]..value2..[['].playAnim(']]..value1..[[', true);
                game.variables[']]..value2..[['].specialAnim = true;
            }
        ]]);
    end
end