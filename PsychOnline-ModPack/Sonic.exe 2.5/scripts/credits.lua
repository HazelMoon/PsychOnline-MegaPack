local time = 2.6
local stepApperar = 5
local textPos = {}
function onCreate()
	local coders = ''
	local musicians = ''
	local artists = ''
	local charters = ''
	if songName == 'too-slow' or songName == 'too-slow-encore' then
		coders = 'Jackie.exe'
		artists = [[
			   GoshaCher360
			   Congaming
			   CherribunFutagami
			   Irmel(animated the part "I am god!")
		]]
		musicians = 'MarStarBro'
		charters = 'Wilde'


	elseif songName == 'endless' or songName == 'endless-og' then
		artists = 'Congaming_Nz'
		musicians = 'MarStarBro'


	elseif songName == 'fate' then
		coders = 'nMyt'
		artists = 'Sonic06 and Sonic Logo = Sonic Team'
		musicians = [[
			   Vania
			   MarStarBro
			   Uptaunt
		]]
		charters = '<p>goldenfoxy2604'

	elseif songName == 'Chaos' then
		coders = [[
			   Avery
			   Nebula
			   CryBit
		]]
		artists = [[
			   Rightburst Ultra
			   Zekuta
			   Comgaming_Nz
		]]
		musicians = 'Jacaris'
		charters = 'Wilde'
		time = 5

	elseif songName == 'sunshine' then
		coders = [[
			   Jackie.exe
			   CryBit
		]]
		artists = [[
			   Zekuta
			   CryBit
		]]
		musicians = [[
			   MarStarBro
			   UpTaunt
		]]
		charters = 'Niffirg'

	elseif songName == 'Round-a-bout' then
		coders = 'Avery'
		artists = [[
			   ShutUpJojo
			   Erick Animations
		]]
		musicians = 'SimplyCrispy'
		charters = 'VentiVR'
		
	elseif songName == 'milk' then
		coders = 'Jackie.exe'
		charters = 'Niffirg'
		artists = [[
			   Comgaming_nz
			   Stankfield
		]]
		musicians = 'Squeak'

	elseif songName == 'Too-Fest' then
		coders = [[
			   Jackie.exe
			   Avery
			   Nebula
		]]
		artists = [[
			   Comgaming_nz
			   Madzilla
		]]
		charters = 'VentiVR'

	elseif songName == 'Fatality' then
		coders = [[
			   Jackie.exe
			   Avery
			   Nebula
			   Crybit
		]]
		musicians = 'Saster'
		artists = 'AnarakWarriors'
		charters = 'niffirg'

	elseif songName == 'prey' then
		coders = [[
			   CryBit
			   Avery
		]]
		artists = 'AnarakWarriors'
		musicians = 'Armydillo'
		charters = 'VentyVR'
		stepApperar = 256

	elseif songName == 'personel' then
		ChartersName = 'Others'
		coders = 'Jackie.exe'
		artists = [[
			   Aaybeff
			   Congaming_Nz
		]]
		musicians = 'Adam Mchummus'
		charters = 'Jackie.exe'
		stepApperar = 35

	elseif songName == 'cycles-old' or songName == 'cycles' then
		coders = 'Jackie.exe'
		artists = [[
			   JoeDoughBoi
			   Congaming_Nz
			   Arthur / ADJ
		]]
		musicians = [[
			   Uptaunt
			   Vania
		]]
		charters = '???'
	elseif songName == 'endless-encore' then
		coders = 'Matikpl168'
		musicians = [[
			   MarStarBro
			   Laztrix
		]]

	elseif songName == 'Mania' then
		artists = [[
			   Cartoon Cat
			   Secret Histories Team
		]]
		charters = 'nMyt'

	elseif songName == 'malediction' then
		musicians = [[
			   bbpanzu
			   Uptaunt
			   illuztriouz
			   x_guttedangel
		]]
		charters = 'nMyt'

	elseif songName == 'forced' then
		artists = 'Vortex(Made the Background)'
		musicians = [[
			   DanlyDaMusicant
			   Reporter Anonymous 23
		]]
		charters = 'nMyt'

	elseif songName == 'faker' then
		artists = [[
			   Revie
			   Devide(Rest in Peace)
		]]
		musicians = [[
			MarStarBro
			Uptaunt
		]]

	elseif songName == 'Forestall-Desire' then
		charters = '<p>nMyt'
		artists = 'MLPDimon'
		musicians = 'Armydillo'
	elseif songName == 'digitalized' then
		musicians = '???'
		charters = 'UnculteredGamer'
	--[[else
		musicians = '???'
		artists = '???'
		coders = '???'
		charters = '???']]--
	end
	makeLuaSprite('CreditsBoxMain', 'box', 400, -1300)
	setObjectCamera('CreditsBoxMain', 'other')
	scaleObject('CreditsBoxMain',1.1,1)
	addLuaSprite('CreditsBoxMain', true)

	local textWidth = getProperty('CreditsBoxMain.width')
	local textX = getProperty('CreditsBoxMain.x')
	makeLuaText('CreditsText', 'CREDITS', textWidth, textX, getProperty('CreditsBoxMain.y') + 100)
	setTextAlignment('CreditsText', 'center')
	setTextSize('CreditsText', 25)
	setObjectCamera('CreditsText', 'other')
	setTextBorder('CreditsText',1,'000000')
	setTextFont('CreditsText','PressStart2P.ttf')
	addLuaText('CreditsText')
	if coders ~= '' then
		table.insert(textPos,'CODERText')
		makeLuaText('CODERTextBig', 'CODE', textWidth, textX, -1000)
		makeLuaText('CODERText', coders, textWidth, textX, -1000)
	end
	if artists ~= '' then
		table.insert(textPos,'ARTISTText')
		makeLuaText('ARTISTTextBig', 'ARTWORK', textWidth, textX, -1000)
		makeLuaText('ARTISTText', artists, textWidth, textX, -1000)
	end
	if musicians ~= '' then
		table.insert(textPos,'MUSICIANText')
		makeLuaText('MUSICIANTextBig', 'MUSIC', textWidth, textX, -1000)
		makeLuaText('MUSICIANText', musicians, textWidth, textX, -1000)
	end
	if charters ~= '' then
		table.insert(textPos,'CHARTERText')
		makeLuaText('CHARTERTextBig', 'CHARTING', textWidth, textX, -1000)
		makeLuaText('CHARTERText', charters, textWidth, textX, -1000)
	end
	if #textPos == 0 then
		setTextString('CreditsText',[[
			   CREDITS

			   unfinished
		]])
	else
		for texts = 1,#textPos do
			local text = textPos[texts]
			setTextAlignment(text, 'center')
			setObjectCamera(text, 'other')
			setTextAlignment(text..'Big', 'center')
			setObjectCamera(text..'Big', 'other')
			setTextSize(text, 18)
			setTextSize(text..'Big', 20)
			setTextFont(text,'PressStart2P.ttf')
			setTextFont(text..'Big','PressStart2P.ttf')
			setTextBorder(text,1,'000000')
			setTextBorder(text..'Big',1,'000000')
			addLuaText(text,true)
			addLuaText(text..'Big',true)
		end
	end
end

--------TIME FOR THE MOVEMENT SHIT BABEY WOOOOOOOO!!!--------
function onCreditsTween()
	local creditsY = getProperty('CreditsBoxMain.y')
	setProperty('CreditsText.y',creditsY + 50)
	if #textPos >= 1 then
		for texts = 1,#textPos do
			local text = textPos[texts]
			if luaTextExists(text)then
				setProperty(text..'Big.y',creditsY + (140 * texts) - 30)
				setProperty(text..'.y',getProperty(text..'Big.y') + 50)
				setProperty(text..'Big.offset.y',0)
				setProperty(text..'..offset.y',0)
			end
		end
	end
end
function onStepHit()
	if curStep == stepApperar then
		startTween('CreditsBoxY', 'CreditsBoxMain', {y = 0}, 0.7, {ease = 'quartOut',onUpdate = 'onCreditsTween'})
		runTimer('byeCredits', time)
	end
end

function onTimerCompleted(tag)
	if tag == 'byeCredits' then
		startTween('CreditsBoxY', 'CreditsBoxMain', {y = getProperty('CreditsBoxMain.height')*-1}, 0.7, {ease = 'quartOut',onUpdate = 'onCreditsTween'})
	end
end
function onTweenCompleted(tag)
	if tag == 'ByeCreditsBox' then
		removeLuaText('CreditsText',true)
		removeLuaSprite('CreditsBoxMain',true)
		if #textPos > 0 then
			for texts = 1,#textPos do
				removeLuaText(textPos[texts],true)
			end
		end
	end
end
