function onCreate()
	makeLuaSprite('BendyBG', 'bendy/BACKBACKgROUND',-220, -100);
	makeLuaSprite('BendyBG2', 'bendy/BackgroundwhereDEEZNUTSfitINYOmOUTH', -600, -150);

	makeLuaSprite('BendyGround', 'bendy/MidGrounUTS', -600, -150);


    precacheImage('bendy/BACKBACKgROUND')
    precacheImage('bendy/BackgroundwhereDEEZNUTSfitINYOmOUTH')
    if not lowQuality then
        precacheImage('bendy/ForegroundEEZNUTS')
        makeLuaSprite('Pillar2', 'bendy/ForegroundEEZNUTS', 1700, -200);
        setScrollFactor('Pillar2',1.2,1)
        precacheImage('bendy/ForegroundEEZNUTS')
    end
end
function onCreatePost()
    setProperty('dad.alpha',0.001)
end
function onStepHit()
    if curStep == 938 then
        startVideo('bendy/bendy1')
    elseif curStep == 1129 then
        addLuaSprite('BendyBG',false)
        setProperty('inCutscene',false)
        addLuaSprite('BendyBG2',false)
        addLuaSprite('BendyGround',false)
        removeLuaSprite('BG',true)
        removeLuaSprite('BendySprite',true)
        if not lowQuality then
         removeLuaSprite('Pillar',true)
         addLuaSprite('Pillar2',true)
        end
        setProperty('defaultCamZoom',0.5)
        removeLuaSprite('Light',true)
        setProperty('boyfriend.x',1150 + getProperty('boyfriend.positionArray[0]'))
        setProperty('boyfriend.y',800 + getProperty('boyfriend.positionArray[1]'))
        setProperty('dad.x',0 + getProperty('dad.positionArray[0]'))
        setProperty('dad.y',800 + getProperty('dad.positionArray[1]'))
        setProperty('dad.alpha',1)
        setProperty('defaultCamZoom',0.5)
    end
end