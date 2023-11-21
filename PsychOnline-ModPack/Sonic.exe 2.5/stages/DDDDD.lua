function onCreate()
    makeLuaSprite('TailsBG','TailsBG',-400,-250)
    scaleObject('TailsBG',1.4,1.4)
    addLuaSprite('TailsBG')
    initLuaShader('VCRDistortionShader')
end
function onCreatePost()
    makeLuaSprite('VCRLua',nil)
    runHaxeCode(
        [[
            var VCRShader = game.createRuntimeShader('VCRDistortionShader');
            var VCRFilter = new ShaderFilter(VCRShader);
            game.camGame.setFilters([VCRFilter]);
            game.camHUD.setFilters([VCRFilter]);
            game.getLuaObject('VCRLua').shader = VCRShader;
        ]]
    )
    setShaderFloat('VCRLua','glitchModifier',0)
end
function onStepHit()
    if songName == 'sunshine' then
        if curStep == 588 then
            setProperty('TailsBG.visible',false)
            setProperty('boyfriend.visible',false)
        end
        if curStep == 860 then
            setProperty('TailsBG.visible',true)
            setProperty('boyfriend.visible',true)
        end
    end
end
--[[local elap = 0
function onUpdate(el)
    elap = elap + el
    setShaderFloat('VCRLua','iTime',elap)
end]]--