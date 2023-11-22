function onCreate()
    makeLuaSprite('sky', 'polus/polus_custom_sky', -800, -600)
	setScrollFactor('sky', 0.5, 0.5)
    scaleObject('sky', 1.4, 1.4)
    addLuaSprite('sky', false)

    makeLuaSprite('rocks', 'polus/polusrocks', -700, -300)
	setScrollFactor('rocks', 0.6, 0.6)
    addLuaSprite('rocks', false)

    makeLuaSprite('hills', 'polus/polusHills', -1050, -180.55)
	setScrollFactor('hills', 0.9, 0.9)
    addLuaSprite('hills', false)

    makeLuaSprite('warehouse', 'polus/polus_custom_lab', 50, -400)
    addLuaSprite('warehouse', false)

    makeLuaSprite('ground', 'polus/polus_custom_floor', -1350, 80)
    addLuaSprite('ground', false)

    makeAnimatedLuaSprite('snow', 'polus/snow', -470, -600)
    addAnimationByPrefix('snow', 'cum', 'cum')
    playAnim('snow', 'cum')
    scaleObject('snow', 2, 2)
    addLuaSprite('snow', true)

    if string.lower(songName) == 'sabotage' then
        addLuaScript('scripts/bgchars/bgchars')
        setGlobalFromScript('scripts/bgchars/bgchars', 'path', 'polus/')
        setGlobalFromScript('scripts/bgchars/bgchars', 'bgchars', {
            ['1'] = {
                {'speakers lonely', 300, 185, 'speakerlonely', 5, 1}
            }
        })
    elseif string.lower(songName) == 'meltdown' then
        addLuaScript('scripts/bgchars/bgchars')
        setGlobalFromScript('scripts/bgchars/bgchars', 'path', 'polus/')
        setGlobalFromScript('scripts/bgchars/bgchars', 'bgchars', {
            ['1'] = {
                {'speakers lonely', 300, 185, 'speakerlonely', 5, 1}
            },
            ['2'] = {
                {'BoppersMeltdown', -900, 150, 'boppers_meltdown', 14, 1, {1.5, 1.5}}
            }
        })
    end
end

function onBeatHit()
    if curBeat % 2 == 0 and boyfriendName == 'bfg' then
        if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
            playAnim('boyfriend', 'idle', true)
        end
    end
end

local noPause = false

function onEvent(eventName, value1, value2)
    if eventName == 'Meltdown Video' then
        -- debugPrint('help??')
        addHaxeLibrary('MP4Handler','vlc')
        runHaxeCode([[
            var filepath:String = Paths.video("meltdown");
            var video:MP4Handler = new MP4Handler();
            video.playVideo(filepath);
            setVar('ActualVideo',video);
            video.time=12;
            video.finishCallback = function()
            {
               game.callOnLuas("onFinishedVideo",["Meltdown Video"]);
               return;
            }
        ]])
        makeLuaSprite('bgBlock2', '', -100, -100)
        makeGraphic('bgBlock2', screenWidth * 2, screenHeight * 2, '000000')
        setObjectCamera('bgBlock2', 'hud')
        addLuaSprite('bgBlock2', true)
    end
end

function onFinishedVideo()
    noPause = true
end

function onUpdate(elapsed)
    if noPause and keyJustPressed('accept') then
    end
end

function onPause()
    if noPause then
        return Function_Stop
    end
end


local u = false;
local r = 0;
local shot = false;
local agent = 1
local xx =  470;
local yy =  250;
local xx2 = 820;
local yy2 = 250;
local ofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;
function onUpdate()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.75)
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else

            setProperty('defaultCamZoom',0.75)
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
    
end