-- Script made by XTihX https://gamebanana.com/members/2066788
-- Edited by Kaite#1102 for easier use

--[[ The variable that stores the amount of characters that you want. altho, i advice you don't touch this
example character:
{ 
    charName = 'pico1', -- The name of your character that can be used in functions like "setProperty('pico.scale.x', 400)" or "doTweenX('tag', 'pico', 300, 2.5, 'linear')"
    characterName = 'pico-player', -- The name of your .json character in the folder "characters"
    x = 300, -- The X Pos of your character
    y = 225, -- The Y Pos of your character
    group = 'boyfriendGroup', -- The Group of your character, can be 'boyfriendGroup', 'dadGroup' or 'gfGroup' (DONT LEAVE THIS VALUE IN BLANK)
    noteTypes = { -- The note types of your characters, to add a new one make like the exemple down here.
        { name = 'char_Sing',    animSuffix = '' }, -- put the name of the notetype on the value "name"
        { name = 'char Sing',    animSuffix = '' }, -- put "-alt" on the animSuffix value if you want your character making alt animations or any other suffix, leave it in blank to disable it.
        { name = 'my char Sing', animSuffix = '' },
        { name = 'Pico Sing',    animSuffix = '' }
    } 
}
]]--
local characters = {}

-- `var` = var name of your character (mom by default), can be used in functions like "setProperty('pico.scale.x', 400)"
-- `char` = character .json in the folder "characters"
-- `x` and `y` are self-explanatory
-- `group` is group of your character, can be 'boyfriendGroup', 'dadGroup' or 'gfGroup' (dadGroup by default)
-- `noteTypes` is the note types your character will respond to,
-- formatted like `{{ name = 'Pico Sing',    animSuffix = '' }, { name = ... }}` (uses vs impostor's notes by default)
--
--  t
-- all the trail stuff only works with characters of `mom` variables.
-- still useful though as in the old script you had to have this ctrl-c'd everywhere, while this works as a global script
-- just do callOnLuas() to use this
function newChar(var, char, x, y, group, noteTypes)
    var = var or 'mom'
    group = group or 'dadGroup'
    noteTypes = noteTypes or {{ name = 'Opponent 2 Sing', animSuffix = '' }, { name = 'Both Opponents Sing', animSuffix = '' }}
    table.insert(characters, {
        charName = var,
        characterName = char,
        ['x'] = x,
        ['y'] = y,
        ['group'] = group,
        ['noteTypes'] = noteTypes
    })
    runHaxeCode([[
        game.variables[']]..var..[['] = new Character(]]..x..[[, ]]..y..[[, ']]..char..[[');
        game.]]..group..[[.add(game.variables[']]..var..[[']);
    ]]);
    -- debugPrint(characters, #characters)
    -- debugPrint(getProperty('mom.alpha'))
    -- triggerEvent('Camera Follow Pos', tostring(getGraphicMidpointX('mom')), tostring(getGraphicMidpointY('mom')))
end

--DONT CHANGE ANYTHING DOWN HERE UNLESS YOU KNOW WHAT YOU ARE DOING!!--------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------

--indeed i do -kaite

local opp2 = false
local oppBoth = false

function onCreatePost()
    luaDebugMode = true;

    addHaxeLibrary('Note');
    addHaxeLibrary('FlxMath', 'flixel.math');
    addHaxeLibrary('Math');
    addHaxeLibrary('Std');

    local curEvent = ''
    local strummy = 0
    local lastStrummy = 0
    local oppEvents = {}

    for i = 0, getProperty('eventNotes.length')-1 do
        curEvent = getPropertyFromGroup('eventNotes', i, 'event')
        strummy = getPropertyFromGroup('eventNotes', i, 'strumTime')
        if (curEvent == 'Both Opponents' or curEvent == 'Opponent Two') and strummy ~= lastStrummy then
            lastStrummy = strummy
            oppEvents[#oppEvents+1] = {curEvent, strummy}
        end
    end

    local event = {}
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
            if #oppEvents > 0 then
                event = oppEvents[1]
                if getPropertyFromGroup('unspawnNotes', i, 'strumTime') >= event[2] then
                    if event[1] == 'Both Opponents' then
                        oppBoth = not oppBoth
                    else
                        oppBoth = false
                        opp2 = not opp2
                    end
                    table.remove(oppEvents, 1)
                end
            end

            if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Both Opponents Sing' or oppBoth then
                setPropertyFromGroup('unspawnNotes', i, 'noteType', 'Both Opponents Sing')
            elseif getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Opponent 2 Sing' then
                if opp2 then
                    setPropertyFromGroup('unspawnNotes', i, 'noteType', 'Disabled Opponent 2 Sing')
                else
                    setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
                end
            else
                if opp2 then
                    setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
                    setPropertyFromGroup('unspawnNotes', i, 'noteType', 'Opponent 2 Sing')
                end
            end
        end
    end

    oppBoth = false
    opp2 = false
end

function onStartCountdown()
    runTimer('startTimer', crochet / 1000 / playbackRate, 5);
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'startTimer' then
        if #characters > 0 then
            for i, char in ipairs(characters) do
                runHaxeCode([[
                    if (]]..loopsLeft..[[ % game.variables[']]..char.charName..[['].danceEveryNumBeats == 0 && game.variables[']]..char.charName..[['].animation.curAnim != null && !StringTools.startsWith(game.variables[']]..char.charName..[['].animation.curAnim.name, 'sing') && !game.variables[']]..char.charName..[['].stunned)
                    {
                        game.variables[']]..char.charName..[['].dance();
                    }
                ]]);
            end
        end
    end
end

function onBeatHit()
    if #characters > 0 then
        for i, char in ipairs(characters) do
            runHaxeCode([[
                if (game.curBeat % game.variables[']]..char.charName..[['].danceEveryNumBeats == 0 && game.variables[']]..char.charName..[['].animation.curAnim != null && !StringTools.startsWith(game.variables[']]..char.charName..[['].animation.curAnim.name, 'sing') && !game.variables[']]..char.charName..[['].stunned)
                {
                    game.variables[']]..char.charName..[['].dance();
                }
            ]]);
        end
    end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    characterNoteHit(id, noteData, noteType, isSustainNote)
end


function opponentNoteHit(id, noteData, noteType, isSustainNote)
    characterNoteHit(id, noteData, noteType, isSustainNote)
end

function getIconColor(chr)
	return rgbToHex(getProperty(chr .. ".healthColorArray"))
end

function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end

function changeIcons(checkBoth)
    if checkBoth and oppBoth then
        runHaxeCode([[
            PlayState.instance.iconP2.changeIcon("]] .. getProperty('dad.healthIcon') .. getProperty('mom.healthIcon') .. [[");
        ]])
        setHealthBarColors(getIconColor('mom'), getIconColor('boyfriend'))
    else
        if opp2 then
            runHaxeCode([[
                PlayState.instance.iconP2.changeIcon("]] .. getProperty('mom.healthIcon') .. [[");
            ]])
            setHealthBarColors(getIconColor('mom'), getIconColor('boyfriend'))
        else
            runHaxeCode([[
                PlayState.instance.iconP2.changeIcon("]] .. getProperty('dad.healthIcon') .. [[");
            ]])
            setHealthBarColors(getIconColor('dad'), getIconColor('boyfriend'))
        end
    end
end

function onEvent(eventName, value1, value2)
    if eventName == 'Both Opponents' then
        oppBoth = not oppBoth
        changeIcons(true)
    elseif eventName == 'Opponent Two' then
        oppBoth = false
        opp2 = not opp2
        changeIcons(false)
    end
end

function characterNoteHit(id, noteData, noteType, isSustainNote)
    if #characters > 0 then
        for i, char in ipairs(characters) do
            for j, note in ipairs(char.noteTypes) do
                if noteType == note.name then
                    runHaxeCode([[
                        var animToPlay:String = game.singAnimations[Std.int(Math.abs(]]..noteData..[[))];
        
                        game.variables[']]..char.charName..[['].playAnim(animToPlay + ']]..note.animSuffix..[[', true);
                        game.variables[']]..char.charName..[['].holdTimer = 0;
                    ]]);
                end
            end
        end
    end
end
function noteMiss(id, noteData, noteType, isSustainNote)
    if #characters > 0 then
        for i, char in ipairs(characters) do
            for j, note in ipairs(char.noteTypes) do
                if noteType == note.name then
                    runHaxeCode([[
                        if (game.variables[']]..char.charName..[['].hasMissAnimations) {
                            var animToPlay:String = game.singAnimations[Std.int(Math.abs(]]..noteData..[[))] + 'miss';
                            game.variables[']]..char.charName..[['].playAnim(animToPlay + ']]..note.animSuffix..[[', true);
                        }
                    ]]);
                end
            end
        end
    end
end
function noteMissPress(direction)
    if #characters > 0 then
        for i, char in ipairs(characters) do
            for j, note in ipairs(char.noteTypes) do
                if noteType == note.name then
                    runHaxeCode([[
                        if (game.variables[']]..char.charName..[['].hasMissAnimations) {
                            game.variables[']]..char.charName..[['].playAnim(game.singAnimations[Std.int(Math.abs(]]..direction..[[))] + 'miss' + ']]..note.animSuffix..[[', true);
                        }
                    ]]);
                end
            end
        end
    end
end

local Keys = {0, 1, 2, 3};
local Released = false;
function onKeyPress(key)
    for i, v in ipairs(Keys) do
        if key == v then
            Released = false;
            return;
        end
    end
end
function onKeyRelease(key)
    for i, v in ipairs(Keys) do
        if key == v then
            Released = true;
            return;
        end
    end
end

function onUpdate(elapsed)
    if #characters > 0 then
        for i, char in ipairs(characters) do
            if char.group == 'boyfriendGroup' then
                if not botPlay then
                    runHaxeCode([[
                        var released = ]]..tostring(Released)..[[;
        
                        if (!released) {
                            game.variables[']]..char.charName..[['].holdTimer = 0;
                        } else {
                            game.variables[']]..char.charName..[['].holdTimer += ]]..elapsed..[[;
                        }
                    ]]);
                end
            end
        end
    end
end