local BfFrames = 0
local DadFrames = 0
local EnableDadBendyFrames = false
local EnableBFBendyFrames = false
local BfMaxFrames = 10
local DadMaxFrames = 10

local frameRate = 0

function onCreatePost()
    detectCharacter()
end
function detectCharacter()
    EnableBFBendyFrames = false
    EnableDadBendyFrames = false
    if getProperty('boyfriend.curCharacter') == 'bf-bendy-run' or getProperty('boyfriend.curCharacter') == 'bf-bendy-run-dark' then
        EnableBFBendyFrames = true
    end
    if getProperty('dad.curCharacter') == 'bendy-run' or getProperty('dad.curCharacter') == 'bendy-run-dark' then
        EnableDadBendyFrames = true
    end
end
function onGameOver()
    EnableBFBendyFrames = false
    EnableDadBendyFrames = false
end
function onUpdate(el)
    if EnableBFBendyFrames or EnableDadBendyFrames then
        frameRate = frameRate + el
        if frameRate >= 1/120 then
            frameRate = 0
            if (EnableBFBendyFrames == true) then
                BfFrames = (BfFrames + 0.4)%BfMaxFrames
                setProperty('boyfriend.animation.curAnim.curFrame',BfFrames)
                setProperty('boyfriend.animation.curAnim.frameRate',0)
                if (getProperty('boyfriend.animation.curAnim.name') ~= 'idle-alt') then
                    BfMaxFrames = 12
                else
                    BfMaxFrames = 10
                end
            end
            if EnableDadBendyFrames then
                DadFrames = (DadFrames + 0.4)%DadMaxFrames
                setProperty('dad.animation.curAnim.curFrame',DadFrames)
                setProperty('dad.animation.curAnim.frameRate',0)
            end
        end
    end
end
function onEvent(name,v1,v2)
    if name == 'Change Character' then
        detectCharacter()
    end
end
function goodNoteHit(id, direction, noteType, isSustainNote)
    if EnableBFBendyFrames then
        setProperty('boyfriend.animation.curAnim.curFrame',BfFrames)
    end
    if (isSustainNote) then
        setProperty('health', getProperty('health') + 0.01)
    else
        setProperty('health', getProperty('health') + 0.02)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if EnableDadBendyFrames then
        setProperty('dad.animation.curAnim.curFrame',DadFrames)
    end
    if (getProperty('health') > 0.4) then
        if (isSustainNote) then
            setProperty('health', getProperty('health') - 0.0375)
        else
            setProperty('health', getProperty('health') - 0.045)
        end
    end
end