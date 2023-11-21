local BeatPorcent = {0}
local BeatCustomPorcent = {0}

local cannotBeat = {0}
local cannotBeatCustom = {0}

local cannotBeatInverted = {0}

local invertedBeat = {0}
local invertedCustomBeat = {0}


local Section = 0
local InvertedSection = 0
local cannotBeatSection = 0

local cannotBeatInt = false
local cannotBeatIntInverted = false

local BeatStrentghGame = 0.015
local BeatStrentghHUD = 0.03

local BeatStrentghInvertedGame = 0.015
local BeatStrentghInvertedHUD = 0.03

local Beated = false
local BeatedCustom = false
local BeatedInverted = false
local BeatedCustomInverted = false

local enabledBeat = true
local enableInverted = true

function onStepHit()
    if cannotBeat[0] ~= nil then
        for cannotBeatLength = 1,#cannotBeat do
            if cannotBeat[cannotBeatLength] ~= nil and cannotBeat[cannotBeatLength] ~= 0 then
                if cannotBeatInt == true and curBeat % cannotBeat[cannotBeatLength] == 0 or cannotBeatInt == false and (curStep/4) % cannotBeat[cannotBeatLength] == 0 then
                    enabledBeat = false
                else
                    enabledBeat = true
                end
            else
                enabledBeat = true
            end
        end
    end
    for cannotBeatInverLength = 1,#cannotBeatInverted do
        if cannotBeatInverted[cannotBeatInverLength] ~= nil and cannotBeatInverted[cannotBeatInverLength] ~= 0 then
            if cannotBeatIntInverted == true and curBeat % cannotBeatInverted[cannotBeatInverLength] == 0 or cannotBeatIntInverted == false and (curStep/4) % cannotBeatInverted[cannotBeatInverLength] == 0 then
                enableInverted = false
            else
                enableInverted = true
            end
        else
            enableInverted = true
        end
    end
    if enabledBeat == true then
        for BeatsHit = 1,#BeatPorcent do
            if BeatPorcent[BeatsHit] ~= nil and Beated == false then
                if (curStep/4) % BeatPorcent[BeatsHit] == 0 then
                    runTimer('enabledBeat',0.01)
                    triggerEvent('Add Camera Zoom',BeatStrentghGame,BeatStrentghHUD)
                    Beated = true
                else
                    Beated = false
                end
            else
                Beated = false
            end
        end
        for BeatsCustomHit = 1,#BeatCustomPorcent do
            if BeatCustomPorcent[BeatsCustomHit] ~= nil and BeatedCustom == false then
                if (curStep/4) % Section == BeatCustomPorcent[BeatsCustomHit] then
                    BeatedCustom = true
                    runTimer('enableBeatCustom',0.01)
                    triggerEvent('Add Camera Zoom',BeatStrentghGame,BeatStrentghHUD)
                else
                    BeatedCustom = false
                end
            else
                BeatedCustom = false
            end
        end
    end
    if enableInverted == true then
        for invertedHit = 1,#invertedBeat do
            if invertedBeat[invertedHit] ~= nil and BeatedInverted == false then
                if (curStep/4) % invertedBeat[invertedHit] == 0 then
                    runTimer('enableInverted',0.01)
                    triggerEvent('Add Camera Zoom',BeatStrentghInvertedGame * -1,BeatStrentghInvertedHUD * -1)
                    BeatedInverted = true
                else
                    BeatedInverted = false
                end
            else
                BeatedInverted = false
            end
        end
        for invertedCustomHit = 1,#invertedCustomBeat do
            if invertedCustomBeat[invertedCustomHit] ~= nil and invertedCustomBeat[invertedCustomHit] ~= 0 then
                if BeatedCustomInverted == false then
                    if (curStep/4) % InvertedSection == invertedCustomBeat[invertedCustomHit] then
                        runTimer('enableCustomInverted',0.01)
                        triggerEvent('Add Camera Zoom',BeatStrentghInvertedGame * -1,BeatStrentghInvertedHUD * -1)
                        BeatedCustomInverted = true
                    else
                        BeatedCustomInverted = false
                    end
                end
            else
                BeatedCustomInverted = false
            end
        end
    end
    --songs
    if songName == 'too-slow' then
        if curStep == 793 or curStep == 1432 then
            replaceArrayBeat(1,1)
        end
        if curStep == 1304 then
            clearBeat()
            clearCustomBeat()
        end
    elseif songName == 'too-slow-encore' then
        if curStep == 416 then
            replaceArrayBeat(1,1)
        end
        if curStep == 1888 then
            replaceArrayBeat(1,0)
        end
    elseif songName == 'you-cant-run' or songName == 'you-cant-run-encore' or songName == 'you-cant-run-encore-new' then
        if curStep == 15 then
            replaceArrayBeat(1,2)
        end
    elseif songName == 'cycles' or songName == 'cycles-old' then
        if curStep == 128 or curStep == 320 or curStep == 1392 or curStep == 1424 then
            replaceArrayBeat(1,2)
        end
        if curStep == 832 or curStep == 1104 then
            clearBeat()
            replaceArrayCustomBeat(1,1)
            replaceArrayCustomBeat(2,2.5)
            replaceArrayCustomBeat(3,3)
        end
        if curStep == 256 or curStep == 1088 or curStep == 1376 or curStep == 1408 or curStep == 1488 then
            clearBeat()
            clearCustomBeat()
        end

    elseif songName == 'fate' then
        if curStep == 288 or curStep == 1216 or curStep == 2448 then
            replaceArrayBeat(1,2)
        end
        if curStep == 544 or curStep == 1472 then
            replaceArrayBeat(1,1)
        end
        if curStep == 800 or curStep == 1728 then
            replaceArrayBeat(1,0)
        end
        
    elseif songName == 'triple-trouble' then
        if curStep == 80 or curStep == 464 or curStep == 1104 or curStep == 1680 or curStep == 1936 or curStep == 2896 or curStep == 3472 or curStep == 3216 or curStep == 4048 then
            clearBeat()
            clearCustomBeat()
            replaceArrayBeat(1,2)
        elseif curStep == 112 or curStep == 456 or curStep == 496 or curStep == 740 or curStep == 912 or curStep == 1136 or curStep == 1920 or curStep == 2927 or curStep == 2960 or curStep == 3728 or curStep == 4080 then
            clearBeat()
            clearCustomBeat()
            replaceArrayBeat(1,1)
        elseif curStep == 128 or curStep == 512 or curStep == 1152 then
            replaceArrayBeat(1,0.5)
        elseif curStep == 134 or curStep == 400 or curStep == 518 or curStep == 1030 or curStep == 1159 or curStep == 1287 or curStep == 2312 or curStep == 2952 or curStep == 3216 or curStep == 3719 or curStep == 3975 or curStep == 5128 then
            clearBeat()
            clearCustomBeat()
        elseif curStep == 144 or curStep == 528 or curStep == 1168 or curStep == 1424 then
            clearBeat()
            clearCustomBeat()
            replaceArrayCustomBeat(1,1)
            replaceArrayCustomBeat(2,1.5)
            replaceArrayCustomBeat(3,2.5)
            replaceArrayCustomBeat(4,3)
        end
    elseif songName == 'endless' or songName == 'endless-og' then
        if curStep == 7 then
            replaceArrayBeat(1,1)
        end
    elseif songName == 'endless-encore' then
        if curStep == 7 or curStep == 1328 then
            replaceArrayBeat(1,1)
        end
        if curStep == 1584 then
            replaceArrayBeat(1,2)
        end
        if curStep == 1312 or curStep == 1616 then
            clearBeat()
        end
    elseif songName == 'milk' then
        if curStep == 96 or curStep == 144 then
            replaceArrayBeat(1,1)
        end
        if curStep == 119 or curStep == 1694 then
           clearBeat()
        end
    elseif songName == 'milk-old' then
        if curStep == 0 then
            replaceArrayBeat(1,2)
        end
        if curStep == 48 or curStep == 2273 then
            replaceArrayBeat(1,0)
        end
        if curStep == 96 then
            replaceArrayBeat(1,1)
        end
    elseif songName == 'black-sun' then
        if curStep == 128 or curStep == 512 or curStep == 976 or curStep == 1344 then
            clearBeat()
            clearCustomBeat()
            replaceArrayBeat(1,1)
        end
        if curStep == 400 then
            clearBeat()
            clearCustomBeat()
            replaceArrayBeat(1,2)
        end
        if curStep == 128 or curStep == 896 or curStep == 1207 or curStep == 1595 then
           clearBeat()
            clearCustomBeat()
        end
    elseif songName == 'prey' then
        if curStep == 254 then
            clearCustomBeat()
            Section = 8
            replaceArrayCustomBeat(1,7)
        end
        if curStep == 1280 then
            clearCustomBeat()
            Section = 8
            replaceArrayCustomBeat(1,5)
        end
        if curStep == 384 or curStep == 1024 or curStep == 2560 then
            clearBeat()
            clearCustomBeat()
            replaceArrayInvertedBeat(1,2)
            replaceArrayInvertedCannotBeat(1,4)
            BeatStrentghInvertedGame = 0.015
            BeatStrentghInvertedHUD = 0.02
        end
        if curStep == 512 or curStep == 1536 or curStep == 2328 or curStep == 3072 then
            clearBeat()
            clearInvertedBeat()
            clearCustomBeat()
            replaceArrayCustomBeat(1,1)
            replaceArrayCustomBeat(2,2.5)
            replaceArrayCustomBeat(3,3)
            BeatStrentghGame = 0.025
            BeatStrentghHUD = 0.04
        end
        if curStep == 2304 or curStep == 3328 then
            clearAllArrays()
        end
    elseif songName == 'Fight or Flight' then
        if curStep == 384 or curStep == 1312 then
            replaceArrayBeat(1,2)
        end
        if curStep == 640 or curStep == 1184 or curStep == 1472 then
            replaceArrayBeat(1,1)
        end
        if curStep == 1152 or curStep == 1296 or curStep == 1440 or curStep == 1952 then
            replaceArrayBeat(1,2)
        end
    elseif songName == 'soulless-orycover' then
        if curStep == 272 then
            replaceArrayBeat(1,1)
        end
        if curStep == 1552 then
            replaceArrayBeat(1,0)
        end
    elseif songName == 'soulless-nikocover' then
        if curStep == 272 or curStep == 672 then
            replaceArrayBeat(1,2)
        end
        if curStep == 400 or curStep == 1312 then
            replaceArrayBeat(1,1)
        end
        if curStep == 656 or curStep == 1184 or curStep == 1952 then
            replaceArrayBeat(1,0)
        end
    --Unused Songs
    elseif songName == 'Forestall-Desire' then
        if curStep == 16 then
            replaceArrayBeat(1,2)
            replaceArrayCannotBeat(1,4)
        end
        if curStep == 144 or curStep == 1056 then
            clearBeat()
            clearCustomBeat()
            clearCannotBeat()
            replaceArrayCustomBeat(1,1)
            replaceArrayCustomBeat(2,2.5)
            replaceArrayCustomBeat(3,3)
        end
        if curStep == 788 then
            clearBeat()
            clearCustomBeat()
        end
    elseif songName == 'forced' then
        if curStep == 496 or curStep == 1191 or curStep == 1392 or curStep == 1776 then
            clearBeat()
            clearCustomBeat()
            BeatStrentghInvertedGame = 0.015
            BeatStrentghInvertedHUD = 0.02
            replaceArrayCustomBeat(1,1)
            replaceArrayCustomInvertedBeat(2,1.5)
            replaceArrayCustomBeat(3,2.5)
            replaceArrayCustomBeat(4,3)
        end
        if curStep == 1264 then
            clearCustomBeat()
            clearInvertCustomBeat()
            replaceArrayBeat(1,2)
        end
        if curStep == 1136 or curStep == 1200 or curStep == 1520 or curStep == 1904 then
            clearBeat()
            clearCustomBeat()
            clearInvertCustomBeat()
            clearCustomBeat()
        end
    elseif songName == 'malediction' then
        if curStep == 15 or curStep == 272 or curStep == 431 or curStep == 496 or curStep == 560 then
            clearBeat()
            clearCustomBeat()
            SectionPorcent = 4
            cannotBeatInt = true
            replaceArrayCustomBeat(1,1)
            replaceArrayCustomBeat(2,2.5)
            replaceArrayCustomBeat(3,3)
        end
        if curStep == 144 or curStep == 720 then
            clearBeat()
            clearCustomBeat()
            clearCannotBeat()
            replaceArrayBeat(1,1)
            replaceArrayCannotBeat(1,4)
        end
        if curStep == 388 or curStep == 463 or curStep == 528 or curStep == 688 then
            clearBeat()
            clearCustomBeat()
            clearCannotBeat()
        end
    elseif songName == 'Burning' then
        if curStep == 384 or curStep == 1280 then
            replaceArrayBeat(1,1)
            replaceArrayCannotBeat(1,4)
        elseif curStep == 128 then
            replaceArrayBeat(1,1)
        end
    elseif songName == 'Mania' then
        if curStep == 1 or curStep == 736 or curStep == 1472 then
            clearCustomBeat()
            clearInvertCustomBeat()
            replaceArrayCustomBeat(1,3)
        elseif  curStep == 126 or curStep == 816 or curStep == 824 then
            SectionPorcent = 0
            clearCustomBeat()
            clearInvertCustomBeat()
            replaceArrayCustomBeat(1,1)
            replaceArrayCustomBeat(2,3)
            replaceArrayInvertedBeat(1,4)
        elseif curStep == 384 or curStep == 832 or curStep == 1216 then
            clearBeat()
            clearInvertCustomBeat()
            replaceArrayCustomBeat(1,2)
        elseif curStep == 376 or curStep == 1204 or curStep == 1464 then
            clearCustomBeat()
            clearInvertCustomBeat()
            
        end
    elseif songName == 'sunshine-encore' then
        if curStep == 51 or curStep == 952 or curStep == 1195 then
            replaceArrayBeat(1,1)
            replaceArrayCannotBeat(1,4)
        elseif curStep == 916 or curStep == 1174 or curStep == 1310 then
            replaceArrayBeat(1,0)
        end
    --fan made songs    
    elseif songName == 'unresponsive' then
        if curStep == 64 or curStep == 384  then
            clearCustomBeat()
            replaceArrayBeat(1,1)
            replaceArrayCustomBeat(1,4)
        end
        if curStep == 128 or curStep == 511 then
            clearBeat()
            clearCustomBeat()
            replaceArrayCustomBeat(1,1)
            replaceArrayCustomBeat(2,1.5)
            replaceArrayCustomBeat(3,2.5)
            replaceArrayCustomBeat(4,3)
        end
        if curStep == 1097 then
            replaceArrayCustomBeat(1,1)
            replaceArrayCustomBeat(2,1.5)
            replaceArrayCustomBeat(3,2.5)
            replaceArrayCustomBeat(4,3)
        end
        if curStep == 912 then
            replaceArrayCustomBeat(1,2)
        end
        if curStep == 118 or curStep == 494 or curStep == 768 then
            clearCustomBeat()
            clearBeat()
            clearCustomCannotBeat()
        end
    elseif songName == 'hollow' then
        if curStep == 128 or curStep == 1024 or curStep == 1552 then
            clearInvertCustomBeat()
            clearInvertedBeat()
            clearBeat()
            clearCustomBeat()
            replaceArrayBeat(1,1)
        end
        if curStep == 254 then
            replaceArrayBeat(1,1)
            replaceArrayCannotBeat(1,2)
            replaceArrayInvertedBeat(1,2)
            BeatStrentghInvertedGame = 0.03
            BeatStrentghInvertedHUD = 0.06
            BeatStrentghGame = 0.03
            BeatStrentghHUD = 0.03
        end
        if curStep == 384 or curStep == 768 or curStep == 1056 or curStep == 1296 then
            clearBeat()
            replaceArrayCustomBeat(1,1)
            replaceArrayCustomBeat(2,2.5)
            replaceArrayInvertedBeat(1,4)
            BeatStrentghInvertedGame = 0.015
            BeatStrentghInvertedHUD = 0.03

        end
        if curStep == 630 or curStep == 1047 or curStep == 1152 or curStep == 1872 then
            clearBeat()
            clearInvertCustomBeat()
            clearInvertedBeat()
            clearCustomBeat()
        end
    end
end

function onTimerCompleted(tag)
    if tag == 'enableBeat' then
        Beated = false
    end
    if tag == 'enableBeatCustom' then
        BeatedCustom = false
    end
    if tag == 'enableInverted' then
        BeatedInverted = false
    end
    if tag == 'enableCustomInverted' then
        BeatedCustomInverted = false
    end
end
function replaceArrayCannotBeat(pos,number)
    if pos == nil then
        table.insert(cannotBeat,#cannotBeat + 1,number)
    else
        if cannotBeat[pos] ~= nil then
            table.remove(cannotBeat,pos)
        end
        table.insert(cannotBeat,pos,number)
    end
end
function clearCannotBeat()
    for clearBeatCannot = 1,#cannotBeat do
        if cannotBeat[clearBeatCannot] ~= nil then
            table.remove(cannotBeat,clearBeatCannot)
        end
        table.insert(cannotBeat,clearBeatCannot,0)
    end
end

function replaceArrayCustomCannotBeat(pos,number)
    if cannotBeatSection == 0 then
        cannotBeatSection = 4
    end
    if pos == nil then
        table.insert(cannotBeatCustom,#cannotBeatCustom + 1,number)
    else
        if cannotBeatCustom[pos] ~= nil then
            table.remove(cannotBeatCustom,pos)
        end
        table.insert(cannotBeatCustom,pos,number)
    end
end
function removeArrayCustomCannotBeat(pos)
    table.remove(cannotBeatCustom,pos)
end
function clearCustomCannotBeat()
    cannotBeatSection = 0
    for clearBeatCustomCannot = 1,#cannotBeatCustom do
        if cannotBeatCustom[clearBeatCustomCannot] ~= nil then
            table.remove(cannotBeatCustom,clearBeatCustomCannot)
        end
        table.insert(cannotBeatCustom,clearBeatCustomCannot,0)
    end
end
function replaceArrayBeat(pos,number)
    if pos == nil then
        table.insert(BeatPorcent,#BeatPorcent + 1,number)
    else
        if BeatPorcent[pos] ~= nil then
            table.remove(BeatPorcent,pos)
        end
        table.insert(BeatPorcent,pos,number)
    end
end
function clearBeat()
    for clearCanBeat = 1,#BeatPorcent do
        table.remove(BeatPorcent,clearCanBeat)
        table.insert(BeatPorcent,clearCanBeat,0)
    end
end
function replaceArrayCustomBeat(pos,number)
    if Section == 0 then
        Section = 4
    end
    if pos == nil then
        table.insert(BeatCustomPorcent,#BeatCustomPorcent + 1,number)
    else
        if BeatCustomPorcent[pos] ~= nil then
            table.remove(BeatCustomPorcent,pos)
        end
        table.insert(BeatCustomPorcent,pos,number)
    end
end
function clearCustomBeat()
    Section = 0
    for clearCanBeatCustom = 1,#BeatCustomPorcent do
        table.remove(BeatCustomPorcent,clearCanBeatCustom)
        table.insert(BeatCustomPorcent,clearCanBeatCustom,0)
    end
end

function replaceArrayInvertedBeat(pos,number)
    if pos == nil then
        table.insert(invertedBeat,#invertedBeat + 1,number)
    else
        if invertedBeat[pos] ~= nil then
            table.remove(invertedBeat,pos)
        end
        table.insert(invertedBeat,pos,number)
    end
end
function clearInvertedBeat()
    for clearCanBeatInveted = 1,#invertedBeat do
        if invertedBeat[clearCanBeatInveted] ~= nil then
            table.remove(invertedBeat,clearCanBeatInveted)
        end
        table.insert(invertedBeat,clearCanBeatInveted,0)
    end
end
function replaceArrayInvertedCannotBeat(pos,number)
    if pos == nil then
        table.insert(cannotBeatInverted,#cannotBeatInverted + 1,number)
    else
        if cannotBeatInverted[pos] ~= nil then
            table.remove(cannotBeatInverted,pos)
        end
        table.insert(cannotBeatInverted,pos,number)
    end
end
function clearInvertedCannotBeat()
    for clearBeatCannotCustom = 1,#cannotBeatInverted do
        if cannotBeatInverted[clearBeatCannotCustom] ~= nil then
            table.remove(cannotBeatInverted,clearBeatCannotCustom)
        end
        table.insert(cannotBeatInverted,clearBeatCannotCustom,0)
    end
end

function replaceArrayCustomInvertedBeat(pos,number)
    if InvertedSection == 0 then
        if Section == 0 then
            InvertedSection = 4
        else
            InvertedSection = Section
        end
    end
    if pos == nil then
        table.insert(invertedCustomBeat,#invertedCustomBeat + 1,number)
    else
        if invertedCustomBeat[pos] ~= nil then
            table.remove(invertedCustomBeat,pos)
        end
        table.insert(invertedCustomBeat,pos,number)
    end
end
function clearInvertCustomBeat()
    InvertedSection = 0
    for clearCustomInverted = 1,#invertedCustomBeat do
        if invertedCustomBeat[clearCustomInverted] ~= nil then
            table.remove(invertedCustomBeat,clearCustomInverted)
        end
        table.insert(invertedCustomBeat,clearCustomInverted,0)
    end
end
function backBeat()
    BeatStrentghGame = 0.015
    BeatStrentghHUD = 0.03
end
function backInvertedBeat()
    BeatStrentghInvertedGame = 0.015
    BeatStrentghInvertedHUD = 0.03
end
function clearAllArrays()
    clearCannotBeat()
    clearCustomCannotBeat()
    clearInvertedCannotBeat()
    clearBeat()
    clearCustomBeat()
    clearInvertedBeat()
    clearInvertCustomBeat()
end