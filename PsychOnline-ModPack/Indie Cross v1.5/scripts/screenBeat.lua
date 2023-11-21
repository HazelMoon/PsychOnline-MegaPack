local BeatPorcent = {0}
local BeatCustomPorcent = {0}

local cannotBeat = {0}
local cannotBeatCustom = {0}

local cannotBeatInverted = {0}
local cannotBeatCustomInverted = {0}

local invertedBeat = {0}
local invertedCustomBeat = {0}


local Section = 0
local InvertedSection = 0
local cannotBeatSection = 0

local cannotBeatInt = false
local cannotBeatIntInverted = false

local BeatStrentghGame = 0.015
local BeatStrentghHUD = 0.03

local BeatStrentghCustomGame = 0.015
local BeatStrentghCustomHUD = 0.03


local BeatStrentghInvertedGame = 0.015
local BeatStrentghInvertedHUD = 0.03


local BeatStrentghInvertedCustomGame = 0.015
local BeatStrentghInvertedCustomHUD = 0.03

local enabledBeat = true
local enableCustomBeat = true
local enableInverted = true
local enableCustomInverted = true

local enabledSystem = true

function onCreate()
    if songName == 'Bad-Time' then
        setBeatValue(0.025,0.05,true,true)
        BeatStrentghInvertedCustomGame = BeatStrentghGame/6
        BeatStrentghInvertedCustomHUD = BeatStrentghCustomHUD/6
    end
    if songName == 'Ritual' then
        BeatStrentghInvertedCustomGame = BeatStrentghGame/3
        BeatStrentghInvertedCustomHUD = BeatStrentghCustomHUD/3
    end
end
function onCreatePost()
    if getProperty('cameraSpeed') == 1 then
        setProperty('cameraSpeed',1.1)
    end
end
function onStepHit()
    if enabledSystem then
        enableCustomBeat = true
        enabledBeat = true
        enableInverted = true
        enableCustomInverted = true
        if cannotBeat[1] ~= nil then
            for cannotBeatLength = 1,#cannotBeat do
                if cannotBeat[cannotBeatLength] ~= nil then
                    if cannotBeatInt == true and curBeat % cannotBeat[cannotBeatLength] == 0 or cannotBeatInt == false and (curStep/4) % cannotBeat[cannotBeatLength] == 0 then
                        enabledBeat = false
                    end
                end
            end
        end
        if cannotBeatCustom[1] ~= nil then
            for cannotBeatCustomLength = 1,#cannotBeatCustom do
                if cannotBeatCustom[cannotBeatCustomLength] ~= nil then
                    if (curStep/4) % cannotBeatSection == cannotBeatCustom[cannotBeatCustomLength] then
                        enableCustomBeat = false
                    end
                end
            end
        end
        if cannotBeatInverted[1] ~= nil then
            for cannotBeatInverLength = 1,#cannotBeatInverted do
                if cannotBeatInverted[cannotBeatInverLength] ~= nil then
                    if cannotBeatIntInverted == true and curBeat % cannotBeatInverted[cannotBeatInverLength] == 0 or cannotBeatIntInverted == false and (curStep/4) % cannotBeatInverted[cannotBeatInverLength] == 0 then
                        enableInverted = false
                    end
                end
            end
        end
        if cannotBeatCustomInverted[1] ~= nil then
            for cannotBeatCustomInvertedLength = 1,#cannotBeatInverted do
                if cannotBeatCustomInverted[cannotBeatCustomInvertedLength] ~= nil then
                    if cannotBeatIntInverted == true and curBeat % cannotBeatSection == cannotBeatCustomInverted[cannotBeatCustomInvertedLength] or cannotBeatIntInverted == false and (curStep/4) % cannotBeatSection == cannotBeatCustomInverted[cannotBeatCustomInvertedLength] then
                        enableCustomInverted = false
                    end
                end
            end
        end
        if enabledBeat == true and BeatPorcent[1] ~= nil then
            for BeatsHit = 1,#BeatPorcent do
                if BeatPorcent[BeatsHit] ~= nil then
                    if (curStep/4) % BeatPorcent[BeatsHit] == 0 then
                        triggerEvent('Add Camera Zoom',BeatStrentghGame,BeatStrentghHUD)
                    end
                end
            end
        end
        if enableCustomBeat == true and BeatCustomPorcent[1] ~= nil then
            for BeatsCustomHit = 1,#BeatCustomPorcent do
                if BeatCustomPorcent[BeatsCustomHit] ~= nil then
                    if (curStep/4) % Section == BeatCustomPorcent[BeatsCustomHit] then
                        triggerEvent('Add Camera Zoom',BeatStrentghCustomGame,BeatStrentghCustomHUD)
                    end
                end
            end
        end
        if enableInverted == true and invertedBeat[1] ~= nil then
            for invertedHit = 1,#invertedBeat do
                if invertedBeat[invertedHit] ~= nil then
                    if (curStep/4) % invertedBeat[invertedHit] == 0 then
                        triggerEvent('Add Camera Zoom',BeatStrentghInvertedGame * -1,BeatStrentghInvertedHUD * -1)
                    end
                end
            end
        end
        if enableCustomInverted == true and invertedCustomBeat[1] ~= nil then
            for invertedCustomHit = 1,#invertedCustomBeat do
                if invertedCustomBeat[invertedCustomHit] ~= nil then
                    if (curStep/4) % InvertedSection == invertedCustomBeat[invertedCustomHit] then
                        triggerEvent('Add Camera Zoom',BeatStrentghInvertedCustomGame * -1,BeatStrentghInvertedCustomHUD * -1)
                    end
                end
            end
        end
        --Songs
        if songName == 'Snake-Eyes' then
            if curStep == 128 or curStep == 384 or curStep == 1024 or curStep == 1280 then
                replaceArrayCustomBeat(1,2)
            elseif curStep == 368 or curStep == 896 or curStep == 1264 or curStep == 1792 then
                clearCustomBeat()
            end
        
        elseif songName == 'Technicolor-Tussle' then
            if curStep == 128 then
                replaceArrayBeat(1,1)
                replaceArrayCannotBeat(1,4)
            elseif curStep == 1376 then
                clearBeat()
                clearCannotBeat()
            end
        elseif songName == 'Knockout' then
            if curStep == 143 or curStep == 528 or curStep == 1215 or curStep == 1535 then
                replaceArrayBeat(1,1)
            elseif curStep == 512 or curStep == 1168 or curStep == 1520 or curStep == 1600 then
                clearBeat()
            end
        elseif songName == 'Sansational' then
            if curStep == 96 then
                replaceArrayBeat(1,2)
            elseif curStep == 144 or curStep == 536  then
                clearBeat()
            elseif curStep == 159 or curStep == 416 or curStep == 542 then
                replaceArrayBeat(1,1)
            elseif curStep == 412 or curStep == 667 or curStep == 795 then
                replaceArrayBeat(1,0.25)
            elseif curStep == 671 then
                Section = 8
                replaceArrayBeat(1,1)
                replaceArrayCustomBeat(1,2.5)
            elseif curStep == 783 or curStep == 1056 then
                clearBeat()
                clearCustomBeat()
            elseif curStep == 800 then
                replaceArrayBeat(1,1)
                replaceArrayCustomBeat(1,2.5)
            end
        elseif songName == 'Burning-In-Hell' then
            if curStep == 127  then
                setProperty('camZooming',true)
                replaceArrayBeat(1,2)
                replaceArrayCannotBeat(1,4)
            elseif curStep == 256 or curStep == 1152 then
                clearBeat()
                clearCannotBeat()
                replaceArrayInvertedBeat(1,4)
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,3)
            elseif curStep == 368 or curStep == 1376 then
                clearCustomBeat()
            elseif curStep == 384 or curStep == 1399 or curStep == 1535 then
                replaceArrayBeat(1,1)
            elseif curStep == 1520 then
                clearBeat()
            elseif curStep == 1664 then
                clearBeat()
                Section = 4
                InvertedSection = 8
                BeatStrentghInvertedCustomGame = BeatStrentghCustomGame/3
                BeatStrentghInvertedCustomHUD =  BeatStrentghCustomHUD/3
                replaceArrayCustomBeat(1,1)
                replaceArrayInvertedCustomBeat(1,1.5)
                replaceArrayCustomBeat(2,2)
                replaceArrayCustomBeat(3,3)
                replaceArrayInvertedCustomBeat(2,6.5)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 1790 then
                clearCustomBeat()
                clearInvertedBeat()
                clearInvertedCustomBeat()
                InvertedSection = 8
                BeatStrentghInvertedCustomGame = 0.015
                BeatStrentghInvertedCustomHUD =  0.03
                replaceArrayInvertedCustomBeat(1,4)
            elseif curStep == 1902 then
                InvertedSection = 4
            end
        elseif songName == 'Terrible-Sin' then
            if curStep == 1 then
                replaceArrayBeat(1,2)
            elseif curStep == 184 then
                replaceArrayBeat(1,0.5)
            elseif curStep == 192 or curStep == 1728 then
                replaceArrayBeat(1,1)
            elseif curStep == 384 or curStep == 1920 then
                clearBeat()
            end
        elseif songName == 'Last-Reel' then
            if curStep == 1 then
                replaceArrayBeat(1,4)
            elseif curStep == 128 or curStep == 1024 or curStep == 1792 then
                clearBeat()
                replaceArrayCustomBeat(1,0.5)
                replaceArrayCustomBeat(2,1)
                replaceArrayCustomBeat(3,2)
                replaceArrayCustomBeat(4,2.5)
                replaceArrayCustomBeat(5,3)
            elseif curStep == 896 or curStep == 1518 then
                clearCustomBeat()
            elseif curStep == 992 then
                replaceArrayBeat(1,2)
            elseif curStep == 1008 or curStep == 1520 then
                replaceArrayBeat(1,1)
            elseif curStep == 1016 then
                replaceArrayBeat(1,0.5)
            elseif curStep == 1020 or curStep == 1532 then
                replaceArrayBeat(1,0.25)
            elseif curStep == 1504 then
                clearCustomBeat()
                replaceArrayCustomBeat(1,0.75)
                replaceArrayCustomBeat(2,3)
            elseif curStep == 2287 then
                clearCustomBeat()
                replaceArrayBeat(1,1)
            elseif curStep == 1536 then
                clearBeat()
            elseif curStep == 2304 then
                clearBeat()
                replaceArrayInvertedBeat(1,4)
            end
        elseif songName == 'Nightmare-Run' then
            if curStep == 164 or curStep == 416 or curStep == 798 or curStep == 1312 or curStep == 1696 then
                clearBeat()
                replaceArrayCustomBeat(1,0.5)
                replaceArrayCustomBeat(2,1)
                replaceArrayCustomBeat(3,2)
                replaceArrayCustomBeat(4,2.5)
                replaceArrayCustomBeat(5,3)
            elseif curStep == 288 or curStep == 672 or curStep == 1055 or curStep == 1568 or curStep == 1949 then
                clearCustomBeat()
                replaceArrayBeat(1,1)
            elseif curStep == 408 or curStep == 2070 then
                replaceArrayBeat(1,0.5)
            elseif curStep == 736 or curStep == 768 or curStep == 1664 or curStep == 2078 then
                clearBeat()
            elseif curStep == 763 or curStep == 1659 then
                replaceArrayBeat(1,0.25)
            elseif curStep == 1040 or curStep == 1934 then
                clearCustomBeat()
            elseif curStep == 1933 then
                clearCustomBeat()
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 1942 then
                Section = 1
                replaceArrayBeat(1,0.75)
            elseif curStep == 2077 then
                clearBeat()
            end
        elseif songName == 'Bad-Time' then
            if curStep == 1 then
                Section = 8
                replaceArrayCustomBeat(1,5.5)
            elseif curStep == 96 then
                clearCustomBeat()
                replaceArrayBeat(1,2)
            elseif curStep == 112 or curStep == 1280 then
                replaceArrayBeat(1,1)
            elseif curStep == 120 or curStep == 1296 then
                replaceArrayBeat(1,0.5)
            elseif curStep == 124 or curStep == 496 or curStep == 924 or curStep == 1171 or curStep == 1304 or curStep == 1424 then
                replaceArrayBeat(1,0.25)
            elseif curStep == 128 then
                clearBeat()
                Section = 8
                replaceArrayInvertedBeat(1,4)
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,1.75)
                replaceArrayCustomBeat(3,2.5)
                replaceArrayCustomBeat(4,3)
                replaceArrayCustomBeat(5,4)
                replaceArrayCustomBeat(6,5)
                replaceArrayCustomBeat(7,5.75)
                replaceArrayCustomBeat(8,6.5)
                replaceArrayCustomBeat(9,7)
                replaceArrayCustomBeat(10,7.5)
                replaceArrayCustomBeat(11,8)
            elseif curStep == 384 then
                clearCustomBeat()

            elseif curStep == 448 or curStep == 1375 then
                replaceArrayInvertedCustomBeat(1,0.75)
                replaceArrayCustomBeat(1,1)
                replaceArrayInvertedCustomBeat(2,1.5)
                replaceArrayCustomBeat(2,2)
                replaceArrayInvertedCustomBeat(3,2.75)
                replaceArrayCustomBeat(3,3)
                replaceArrayInvertedCustomBeat(4,3.5)
                replaceArrayCustomBeat(4,4)
            elseif curStep == 480 or curStep == 920 or curStep == 1408 then
                clearCustomBeat()
                clearInvertedCustomBeat()
                replaceArrayBeat(1,0.5)
            elseif curStep == 512  or curStep == 931 then
                clearBeat()
                Section = 8
                replaceArrayInvertedBeat(1,4)
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,1.75)
                replaceArrayCustomBeat(3,2.5)
                replaceArrayCustomBeat(4,3)
                replaceArrayCustomBeat(5,4)
                replaceArrayCustomBeat(6,4.5)
                replaceArrayCustomBeat(7,5)
                replaceArrayCustomBeat(8,5.75)
                replaceArrayCustomBeat(9,6.5)
                replaceArrayCustomBeat(10,7)
                replaceArrayCustomBeat(11,7.5)
                replaceArrayCustomBeat(12,8)
            elseif curStep == 768 then
                clearCustomBeat()
                replaceArrayBeat(1,2)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 896 or curStep == 1184 or curStep == 1431 then
                clearBeat()
            elseif curStep == 912 then
                Section = 0.75
                replaceArrayCustomBeat(1,0)
                replaceArrayCustomBeat(2,0.25)
            elseif curStep == 1168 then
                clearCustomBeat()
                replaceArrayBeat(1,0.5)
            elseif curStep == 1247 or curStep == 1440 then
                replaceArrayBeat(1,2)
            elseif curStep == 1311 or curStep == 1946 then
                clearBeat()
                replaceArrayInvertedBeat(1,4)
            end
        elseif songName == 'Freaky-Machine' then
            if curStep == 224 or curStep == 384 or curStep == 511 or curStep == 986 then
                replaceArrayBeat(1,1)
            elseif curStep == 344 then
                clearBeat()
                replaceArrayCustomBeat(1,2.75)
                replaceArrayCustomBeat(2,3.75)
            elseif curStep == 352 then
                clearCustomBeat()
            elseif curStep == 495 or curStep == 665 or curStep == 976 or curStep == 1264 then
                clearBeat()
            elseif curStep == 656 then
                replaceArrayBeat(1,0.25)
            elseif curStep == 704 then
                Section = 8
                replaceArrayCustomBeat(1,3.5)
                replaceArrayCustomBeat(2,6)
                replaceArrayCustomBeat(3,7)
            elseif curStep == 752 then
                clearCustomBeat()
                replaceArrayBeat(1,1)
            end
        elseif songName == 'build-our-freaky-machine' then
            if curStep == 224 or curStep == 607 or curStep == 768 or curStep == 894 or curStep == 1600 then
                replaceArrayBeat(1,1)
            end
            if curStep == 320 or curStep == 400 or curStep == 482 or curStep == 623 or curStep == 642 or curStep == 1072 or curStep == 1098 or curStep == 1520 or curStep == 1712 or curStep == 1840 then
                replaceArrayBeat(1,2)
            end
            if curStep == 342 or curStep == 350 or curStep == 464 or curStep == 634 or curStep == 1008 or curStep == 1088 or curStep == 1502 or curStep == 1646 or curStep == 1776 or curStep == 2048 then
                clearBeat()
            end
        elseif songName == 'Ritual' then
            if curStep == 384 or curStep == 768 then
                replaceArrayBeat(1,1)
                replaceArrayCannotBeat(1,4)
            elseif curStep == 512 or curStep == 1152 then
                clearBeat()
                clearCannotBeat()
                Section = 8
                replaceArrayCustomBeat(1,1.5)
                replaceArrayInvertedCustomBeat(1,2)
                replaceArrayBeat(1,4)
                replaceArrayCustomBeat(2,7)
            elseif curStep == 896 then
                clearBeat()
                replaceArrayCustomBeat(1,2)
                replaceArrayCustomBeat(2,4)
                replaceArrayInvertedCustomBeat(1,1)
                replaceArrayInvertedCustomBeat(2,3)
                replaceArrayInvertedCustomBeat(3,4)
            elseif curStep == 669 or curStep == 1022 or curStep == 1280 then
                clearBeat()
                clearCustomBeat()
                clearInvertedCustomBeat()
            elseif curStep == 1279 then
                replaceArrayInvertedBeat(1,4)
            end
        elseif songName == 'Saness' then
            if curStep == 384 or curStep == 1408  then
                replaceArrayBeat(1,1)
            elseif curStep == 512 or curStep == 1536 then
                replaceArrayBeat(1,2)
            elseif curStep == 1024 or curStep == 1920 then
                clearBeat()
            end
            
        elseif songName == 'Gose' then
            if curStep == 128 or curStep == 256 or curStep == 1124 or curStep == 1152 then
                replaceArrayBeat(1,1)
            elseif curStep == 192 or curStep == 1088 then
                replaceArrayBeat(1,0.5)
            elseif curStep == 224 or curStep == 1120 then
                replaceArrayBeat(1,0.25)
            elseif curStep == 240 or curStep == 768 or curStep == 1136 or curStepp == 1662 then
                clearBeat()
            end
        end
    end
end

function replaceArrayBeat(pos,number)
    if pos == nil then
        pos = #BeatPorcent + 1
    end
    if BeatPorcent[pos] ~= number then
        if BeatPorcent[pos] ~= nil then
            table.remove(BeatPorcent,pos)
        end
        table.insert(BeatPorcent,pos,number)
    end
end

function replaceArrayCustomBeat(pos,number)
    if Section == 0 then
        Section = 4
    end
    if number == Section then
        number = 0
    end
    if pos == nil then
        pos = #BeatCustomPorcent + 1
    end
    if BeatCustomPorcent[pos] ~= number then
        if BeatCustomPorcent[pos] ~= nil then
            table.remove(BeatCustomPorcent,pos)
        end
        table.insert(BeatCustomPorcent,pos,number)
    end
end

function replaceArrayInvertedCustomBeat(pos,number)
    if InvertedSection == 0 then
        InvertedSection = 4
    end
    if number == InvertedSection then
        number = 0
    end
    if pos == nil then
        pos = #invertedCustomBeat + 1
    end
    if invertedCustomBeat[pos] ~= number then
        if invertedCustomBeat[pos] ~= nil then
            table.remove(invertedCustomBeat,pos)
        end
        table.insert(invertedCustomBeat,pos,number)
    end
end

function replaceArrayInvertedBeat(pos,number)
    if pos == nil then
        pos = #invertedBeat + 1
    end
    if invertedBeat[pos] ~= number then
        if invertedBeat[pos] ~= nil then
            table.remove(invertedBeat,pos)
        end
        table.insert(invertedBeat,pos,number)
    end
end

function replaceArrayCannotBeat(pos,number)
    if pos == nil then
        pos = #cannotBeat + 1
    end
    if cannotBeat[pos] ~= number then
        if cannotBeat[pos] ~= nil then
            table.remove(invertedBeat,pos)
        end
        table.insert(cannotBeat,pos,number)
    end
end

function replaceArrayCustomCannotBeat(pos,number)
    if cannotBeatSection == 0 then
        cannotBeatSection = 4
    end
    if pos == nil then
        table.insert(cannotBeatCustom,#cannotBeatCustom + 1,number)
    else
        if cannotBeatCustom[pos] ~= number then
            if cannotBeatCustom[pos] ~= nil then
                table.remove(cannotBeatCustom,pos)
            end
            table.insert(cannotBeatCustom,pos,number)
        end
        if number == cannotBeatSection then
            number = 0
        end
    end
end
function replaceArrayInvertedCannotBeat(pos,number)
    if pos == nil then
        pos = #cannotBeatInverted + 1
    end
    if cannotBeatInverted[pos] ~= number then
        if cannotBeatInverted[pos] ~= nil then
            table.remove(cannotBeatInverted,pos)
        end
        table.insert(cannotBeatInverted,pos,number)
    end
end

function replaceArrayInvertedCustomCannotBeat(pos,number)
    if pos == nil then
        pos = #cannotBeatCustomInverted + 1
    end
    if cannotBeatCustomInverted[pos] ~= nil then
        if cannotBeatCustomInverted[pos] ~= number then
            if cannotBeatCustomInverted[pos] ~= nil then
                table.remove(cannotBeatCustomInverted,pos)
            end
            table.insert(cannotBeatCustomInverted,pos,number)
        end
        table.remove(cannotBeatCustomInverted,pos)
    end
end

function clearBeat()
    for clearBeat = 1,#BeatPorcent do
        if BeatPorcent[clearBeat] ~= nil then
            table.remove(BeatPorcent,clearBeat)
            table.insert(BeatPorcent,clearBeat,nil)
        end
    end
end

function clearInvertedBeat()
    for clearCanBeatInveted = 1,#invertedBeat do
        if invertedBeat[clearCanBeatInveted] ~= nil then
            table.remove(invertedBeat,clearCanBeatInveted)
        end
        table.insert(invertedBeat,clearCanBeatInveted,nil)
    end
end

function clearCustomBeat()
    Section = 4
    for clearCustom = 1,#BeatCustomPorcent do
        if BeatCustomPorcent[clearCustom] ~= nil then
            table.remove(BeatCustomPorcent,clearCustom)
        end
        table.insert(BeatCustomPorcent,clearCustom,nil)
    end
end

function clearCustomCannotBeat()
    cannotBeatSection = 0
    for clearBeatCustomCannot = 1,#cannotBeatCustom do
        if cannotBeatCustom[clearBeatCustomCannot] ~= nil then
            table.remove(cannotBeatCustom,clearBeatCustomCannot)
        end
        table.insert(cannotBeatCustom,clearBeatCustomCannot,nil)
    end
end

function clearInvertedCustomBeat()
    InvertedSection = 4
    for clearCustomInverted = 1,#invertedCustomBeat do
        if invertedCustomBeat[clearCustomInverted] ~= nil then
            table.remove(invertedCustomBeat,clearCustomInverted)
        end
        table.insert(invertedCustomBeat,clearCustomInverted,nil)
    end
end
function clearCannotBeat()
    for clearBeatCannot = 1,#cannotBeat do
        if cannotBeat[clearBeatCannot] ~= nil then
            table.remove(cannotBeat,clearBeatCannot)
        end
        table.insert(cannotBeat,clearBeatCannot,nil)
    end
end

function clearInvertedCannotBeat()
    for clearBeatCannotCustom = 1,#cannotBeatInverted do
        if cannotBeatInverted[clearBeatCannotCustom] ~= nil then
            table.remove(cannotBeatInverted,clearBeatCannotCustom)
        end
        table.insert(cannotBeatInverted,clearBeatCannotCustom,nil)
    end
end

function setBeatValue(valueGame,valueHUD,normal,custom)
    if normal ~= false then
        if valueGame ~= nil then
            BeatStrentghGame = valueGame
        end
        if valueHUD ~= nil then
            BeatStrentghHUD = valueHUD
        end
    end
    if custom ~= false then
        if valueGame ~= nil then
            BeatStrentghCustomGame = valueGame
        end
        if valueHUD ~= nil then
            BeatStrentghCustomHUD = valueHUD
        end
    end
end
function setInvertedBeat(valueGame,valueHUD,normal,custom)
    if normal ~= false then
        if valueGame ~= nil then
            BeatStrentghInvertedGame = valueGame
        end
        if valueHUD ~= nil then
            BeatStrentghInvertedHUD = valueHUD
        end
    end
    if custom ~= false then
        if valueGame ~= nil then
            BeatStrentghInvertedCustomGame = valueGame
        end
        if valueHUD ~= nil then
            BeatStrentghInvertedCustomHUD = valueHUD
        end
    end
end
function clearAllArrays()
    clearCannotBeat()
    clearCustomCannotBeat()
    clearInvertedCannotBeat()
    clearBeat()
    clearCustomBeat()
    clearInvertedBeat()
    clearInvertedCustomBeat()
end