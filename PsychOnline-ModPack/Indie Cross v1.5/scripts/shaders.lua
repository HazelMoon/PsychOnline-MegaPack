
local defaultChrom = 0.001
local chromVal = 0.001
local hudShader = "true"
local pewdmg = 0
local enableShader = true
local tweenEnabled = false
local tween2enabled = false
local nightmareStage = false
function onCreate()
    enableShader = getPropertyFromClass('ClientPrefs','shaders')
    if enableShader == true then
        if songName == 'Snake-Eyes' or songName == 'Technicolor-Tussle' or songName == 'Knockout' then
            defaultChrom = 0.0015
            chromVal = 0.001
            pewdmg = 0.0225
        elseif songName == 'Bad-Time' or songName == 'Despair' then
            defaultChrom = 0
            nightmareStage = true
        elseif songName == 'Whoopee' or songName == 'Sansational' or songName == 'Final-Stretch' then
            enableShader = false
            defaultChrom = 0
        elseif songName == 'Burning-In-Hell' then
            defaultChrom = 0
        elseif songName == 'Devils-Gambit' then
            defaultChrom = 0.0015
            pewdmg = 0.03
            nightmareStage = true
        else
            enableShader = false
        end
        chromVal = defaultChrom
        if pewdmg == 0 then
            pewdmg = defaultChrom + 0.005
        end
    end
end
function onUpdate()
    if tweenEnabled or tween2enabled then
        chromVal = getProperty('chromTween.x')
        setChromShader(chromVal)
    end
end
function setChromShader(value)
    setShaderFloat('chromShader','rOffset',value)
    setShaderFloat('chromShader','bOffset',value * -1)
end
function onCreatePost()
    if enableShader == true then
        initLuaShader('ChromaticAberration')
        makeLuaSprite('chromShader')
        makeGraphic('chromGraphic',screenWidth,screenHeight)
        setSpriteShader('chromGraphic','chromShader')
        runHaxeCode(
            [[
                var chromShader = game.createRuntimeShader('ChromaticAbberation');
                var hudEnabled = "]]..hudShader..[[";
                var shader = new ShaderFilter(chromShader);
                game.camGame.setFilters([shader]);
                game.getLuaObject('chromShader').shader = chromShader;
                if(hudEnabled == "true"){
                    game.camHUD.setFilters([shader]);
                };
                return;
            ]]
        )
        setShaderFloat('chromShader','rOffset',chromVal)
        setShaderFloat('chromShader','bOffset',chromVal * -1)
    end
end
function shaderTween(shader,speed,easing,obrigatory)
    if enableShader then
        if obrigatory then
            tweenEnabled = true
            tween2enabled = false
        else
            if not tweenEnabled then
                tween2enabled = true
            else
                return
            end
        end
        cancelTween('chromTweenShader')
        makeLuaSprite('chromTween',nil,shader,0)
        chromVal = shader
        doTweenX('chromTweenShader','chromTween',defaultChrom,speed,easing)
    end
end
function onTimerCompleted(tag)
    if string.match(tag,'gasSound') then--timer used in SansGastar script, in Burning in Hell song
        shaderTween(0.025,0.4,'circOut',true)
    end
end
function onTweenCompleted(tag)
    if string.match(tag,'chromTweenShader') then
        chromVal = defaultChrom
        setChromShader(defaultChrom)
        tweenEnabled = false
        tween2enabled = false
        removeLuaSprite('chromTween',true)
    end
end
function opponentNoteHit(id,dir,type,sus)
    if nightmareStage then
        local force = math.random((defaultChrom + 0.05)*100,((defaultChrom + 0.08)*100))/1100
        if sus then
            force = force - 0.002
        end
        shaderTween(force,0.15,'linear',false)
    end
end
function onEvent(name,v1,v2)
    if name == 'CupheadAttack' or name == 'CupheadDoubleAttack' then
        shaderTween(pewdmg,0.3,'linear',true)
    end
end