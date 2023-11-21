function onStepHit()
  if curStep == 1791 then
    doTweenColor('bfColorTween', 'boyfriend', '000000', 1, 'linear')
    doTweenColor('dadColorTween', 'dad', '000000', 1, 'linear')
  elseif curStep == 2048 then
    setProperty('boyfriend.color',getColorFromHex('FFFFFF'))
    setProperty('dad.color',getColorFromHex('FFFFFF'))
  end
end