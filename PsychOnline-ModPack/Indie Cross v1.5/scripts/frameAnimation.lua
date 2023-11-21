local EnabledCharacters = {
    'bf-ic',
    'bf-ic-rain',
    'bf-bendy-ic',
    'bf-bendy-ic-phase2',
    'bf-bendy-ic-phase3',
    'bf-bendy-nm',
    'bf-sammy',
    'bf-sans-bs',
    'bf-chara',
    'bf-sans',
    'bf-sans-nm',
    'bf-christmas-ic',
    'bf-da',
    'bf-da-b&w',
    'bf-NM',
    'UT-bf',
    'UT-bf-chara',
    'UT-sans',
    'bendy-da',
    'bendy-daphase2',
    'bendy-ic',
    'cuphead-pissed',
    'cuphead',
    'devil',
    'Nightmare-Bendy',
    'Nightmare-Cuphead',
    'Nightmare-Sans',
    'papyrus-ic',
    'sammy',
    'sans-ic',
    'sans-ic-wt',
    'sans-phase2-ic',
    'sans-phase3',
    'sans-tired'
}
local foundedBf = false
local foundedDad = false
local anims = {'singLEFT','singDOWN','singUP','singRIGHT'}
function onCreatePost()
    detectCharacter()
end
function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote and foundedBf and string.find(getProperty('boyfriend.animation.curAnim.name'),anims[direction + 1],0,true) ~= nil then
        setProperty('boyfriend.animation.curAnim.curFrame',2)
    end
end
function onEvent(name,v1)
    if name == 'Change Character' then
        detectCharacter()
    end
end
function detectCharacter()
    foundedBf = false
    foundedDad = false
    for Characters = 0,#EnabledCharacters do
        if getProperty('boyfriend.curCharacter') == EnabledCharacters[Characters] then
            foundedBf = true
        end
        if getProperty('dad.curCharacter') == EnabledCharacters[Characters] then
            foundedDad = true
        end
    end
end
function opponentNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote and foundedDad and string.find(getProperty('dad.animation.curAnim.name'),anims[direction + 1],0,true) ~= nil then
        setProperty('dad.animation.curAnim.curFrame',2)
    end
end