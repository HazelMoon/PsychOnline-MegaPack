local bendyVideoFrames = 0
local bendyVideoDirection = 1

local changeNotes = 0
function onCreate()
  if songName == 'build-our-freaky-machine' then
      precacheImage('bendy/BonusSongs/dabg - Black & White')
      precacheImage('bendy/BonusSongs/reel')
      precacheImage('bendy/BonusSongs/Curtain1 - Black & Whitel')
      precacheImage('bendy/BonusSongs/Curtain2 - Black & White')
      precacheImage('bendy/BonusSongs/dabg - Black & White')
      precacheImage('bendy/BonusSongs/dabg - Black & White')
      precacheImage('bendy/BonusSongs/dabg - Black & White')
      makeLuaSprite('bendyBGBlackWhite','bendy/BonusSongs/dabg - Black & White',-350,50)
      scaleObject('bendyBGBlackWhite',1.3,1.3)
      setProperty('bendyBGBlackWhite.visible',false)

      makeAnimatedLuaSprite('bendyVideoBlackWhite','bendy/BonusSongs/reel',-100,-100)
      addAnimationByPrefix('bendyVideoBlackWhite','bVideo','Bendy',12,true)
      setBlendMode('bendyVideoBlackWhite','add')
      scaleObject('bendyVideoBlackWhite',3,3)

      makeLuaSprite('Curtain1BlackWhite','bendy/BonusSongs/Curtain1 - Black & White',-300,-170)
      scaleObject('Curtain1BlackWhite',1.5,1.5)
      setProperty('Curtain1BlackWhite.visible',false)

      makeLuaSprite('Curtain2BlackWhite','bendy/BonusSongs/Curtain2 - Black & White',600,-170)
      scaleObject('Curtain2BlackWhite',1.5,1.5)

      setProperty('Curtain2BlackWhite.visible',false)
      if not lowQuality then
          makeAnimatedLuaSprite('CupheqdShid', 'cup/CUpheqdshid',-350,-193);
          addAnimationByPrefix('CupheqdShid','dance','Cupheadshit_gif instance 1',24,true);
          objectPlayAnimation('CupheqdShid','Cupheadshit_gif instance',false)
          scaleObject('CupheqdShid',1.6,1.6)
          setObjectCamera('CupheqdShid','other')
          setProperty('CupheqdShid.color','FFFFFF')
          setProperty('CupheqdShid.alpha',0.01)
          
          makeAnimatedLuaSprite('Grain', 'cup/Grainshit',-350,-193);
          addAnimationByPrefix('Grain','dance','Geain instance 1',24,true);
          objectPlayAnimation('Grain','Geain instance 1',false)
          scaleObject('Grain',1.6,1.6)
          setObjectCamera('Grain','other')
          setProperty('Grain.color','FFFFFF')
          setProperty('Grain.alpha',0.01)
        
          makeLuaSprite('BendyVignette', 'bendy/gay/C_07',0,0);
          scaleObject('BendyVignette',0.7,0.7)
          setObjectCamera('BendyVignette','other')
          setProperty('BendyVignette.alpha',0.01)

          addLuaSprite('CupheqdShid', true);
          addLuaSprite('Grain',true)
          addLuaSprite('BendyVignette',true)
      end
      addLuaSprite('bendyBGBlackWhite', false);
      addLuaSprite('bendyVideoBlackWhite',false)
      addLuaSprite('Curtain1BlackWhite', false);
      addLuaSprite('Curtain2BlackWhite', false);
	end

  makeAnimatedLuaSprite('bendyVideo','bendy/reel',-100,-100)
  addAnimationByPrefix('bendyVideo','bVideo','Bendy',12,true)
  setBlendMode('bendyVideo','add')
  scaleObject('bendyVideo',3,3)


  makeLuaSprite('bendyBG','bendy/BonusSongs/dabg',-350,50)
  scaleObject('bendyBG',1.3,1.3)



  makeLuaSprite('Curtain1','bendy/BonusSongs/Curtain1',-300,-170)
  scaleObject('Curtain1',1.5,1.5)

  makeLuaSprite('Curtain2','bendy/BonusSongs/Curtain2',600,-170)
  scaleObject('Curtain2',1.5,1.5)





  addLuaSprite('bendyBG',false)
  addLuaSprite('bendyVideo',false)
  addLuaSprite('Curtain1',false)
  addLuaSprite('Curtain2',false)
end

function onCreatePost()
  makeLuaSprite('prechaceNote','bendy/BonusSongs/NOTE_assets',0,0)
  setProperty('prechaceNote.visible',false)
end

function onStepHit()
    if songName == 'Freaky-Machine' then
      if curStep==687 then
          makeLuaSprite('black','',0,0)
          makeGraphic('black',screenWidth,screenHeight,'000000')
          setProperty('black.alpha',0)
          setObjectCamera('black','hud')
          addLuaSprite('black',true)
      end

      if curStep== 698 then
        doTweenAlpha('blackTween','black',1,1,'linear')
        setProperty('defaultCamZoom',0.8)
      end
      
      if curStep== 700 then
        removeLuaSprite('black',true)
        doTweenX('Curtain1','Curtain2',1250,1)
        doTweenX('Curtain2','Curtain1',-950,1)
      end
    end
    if songName == 'build-our-freaky-machine' then
      if curStep == 1280 then
          for changeNote = 0,7 do
            setPropertyFromGroup('strumLineNotes',changeNote,'texture','bendy/BonusSongs/NOTE_assets')
          end
          removeLuaSprite('prechaceNote',true)
          changeNotes = 2
          setProperty('bendyBG.visible',false)
          setProperty('Curtain1.visible',false)
          setProperty('Curtain2.visible',false)
          setProperty('bendyVideo.visible',false)
          if not lowQuality then
            setProperty('Grain.alpha',1)
            setProperty('CupheqdShid.alpha',1)
            setProperty('BendyVignette.alpha',1)
          end
          setProperty('Curtain1BlackWhite.alpha',true)
          setProperty('Curtain2BlackWhite.visible',true)
          setProperty('bendyBGBlackWhite.visible',true)
          setProperty('bendyVideoBlackWhite.visible',true)

          doTweenX('Curtain1','Curtain1',-950,1,'QuintInOut')
          doTweenX('Curtain2','Curtain2',1250,1,'QuintInOut')
      elseif curStep == 1536 then
            for changeNote = 0,7 do
              setPropertyFromGroup('strumLineNotes',changeNote,'texture','NOTE_assets')
            end
            changeNotes = 1
            setProperty('bendyBG.visible',true)
            setProperty('Curtain1.visible',true)
            setProperty('Curtain2.visible',true)
            setProperty('bendyVideo.visible',true)
            if not lowQuality then
              removeLuaSprite('Grain',true)
              removeLuaSprite('CupheqdShid',true)
              removeLuaSprite('BendyVignette',true)
            end
            removeLuaSprite('Curtain1BlackWhite',true)
            removeLuaSprite('Curtain2BlackWhite',true)
            removeLuaSprite('bendyBGBlackWhite',true)
            removeLuaSprite('bendyVideoBlackWhite',true)

            doTweenX('Curtain1','Curtain1',-300,1,'QuintInOut')
            doTweenX('Curtain2','Curtain2',600,1,'QuintInOut')
        end
    end
end

function onUpdate()
  if songName == 'build-our-freaky-machine' then
     setProperty('Curtain1BlackWhite.x',getProperty('Curtain1.x'))
     setProperty('Curtain2BlackWhite.x',getProperty('Curtain2.x'))
  end
  if changeNotes == 2 then
    for notesAAA = 0,getProperty('notes.length')-1 do
      if getPropertyFromGroup('notes', notesAAA,'noteType') == '' then
        setPropertyFromGroup('notes', notesAAA,'texture','bendy/BonusSongs/NOTE_assets')
      end
    end
  end
  if changeNotes == 1 then
    for notesAAA = 0,getProperty('notes.length')-1 do
      if getPropertyFromGroup('notes', notesAAA,'noteType') == '' then
        setPropertyFromGroup('notes', notesAAA,'texture','')
      end
    end
    changeNotes = 0
  end
end