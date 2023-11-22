function onEvent(e, v1, v2)
    if e == 'setChrom' then
        local theAmount = tonumber(v1)
        if theAmount == nil then theAmount = 0 end
        local theSpeed = tonumber(v2)
        if theSpeed == nil then theSpeed = 0 end

        runHaxeCode([[
            setVar('amount', getVar('ChromaticAbberation').getFloat('amount'));
            if (getVar('chromTween') != null)
                getVar('chromTween').cancel;
            setVar('chromTween', FlxTween.num(getVar('amount'), ]]..theAmount..[[, ]]..theSpeed..[[, {ease: FlxEase.sineOut},
            function(num){
                getVar('ChromaticAbberation').setFloat('amount', num); setVar('amount', num);
            }));
        ]]);

        -- startTween('chromTween', 'chromTween', {x = theAmount}, theSpeed, {onUpdate = function(num) runHaxeCode([[
        --     getVar('ChromaticAbberation').setFloat('amount', num)
        -- ]]) end})
        -- if(chromTween != null) chromTween.cancel();
        -- chromTween = FlxTween.tween(caShader, {amount: theAmount}, theSpeed, {ease: FlxEase.sineOut});
    end
end