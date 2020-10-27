function HST:NewSession(broadcast)
    HST.db.char.LootTimerStart = 0;
    HST.db.char.KillStart = GetStatistic(1197)

    HST.db.char.MoneyStart = GetMoney();
    HST:PrintText("A new session has been started.");
    HST.db.char.SessionStartTime = GetServerTime()
    HST.DisplayStartTime = date("%I:%M %p", HST.db.char.SessionStartTime)
    HST:BroadcastSession(broadcast);
end

function HST:EndSession()
    local sessionStart = HST.DisplayStartTime
    local sessionEnd = date("%I:%M %p", GetServerTime())
    local sessionDuration = HST.GetSessionDuration()
    local sessionKills = HST.GetEarnedKills()
    local sessionMoney = HST.BuildMoneyString()
    HST:PrintText("Session Ended Summary");
    HST:PrintText("Time: " .. sessionStart .. " - " .. sessionEnd);
    HST:PrintText("Duration: " .. sessionDuration)
    HST:PrintText("Kills: " .. sessionKills)
    HST:PrintText("Money: " .. sessionMoney)
end

function HST:ProcessSlash(command)
    if (command == "help") then
        HST:PrintText("Here is a list of all available slash commands.")
        print("    /hst - toggles the control visibility.")
        print("    /hst sound - tests the audio level of alerts.")
        print("    /hst help - shows this help menu.")
    elseif (command == "sound") then
        HST:PlaySound(8959)
    else
        if (HST.Frame_Panel:IsShown()) then
            HST.Frame_Panel:Hide();
            HST.db.char.showPanel = false;
        else
            HST.Frame_Panel:Show();
            HST.db.char.showPanel = true;
        end
    end
end

-- Helper Functions --
function HST:GetLootTimer()
    local lootTimerEnd = HST.db.char.LootTimerStart + 120;
    local lootTimer = lootTimerEnd - GetServerTime();
    if (lootTimer < 0) then
        return -1;
    else
        return lootTimer
    end
end

function HST:GetEpicLootTimer()
    local lootTimerEnd = HST.db.char.LootTimerStart + 900;
    local lootTimer = lootTimerEnd - GetServerTime();
    if (lootTimer < 0) then
        return -1;
    else
        return lootTimer
    end
end

function HST:BuildMoneyString()
    local moneyCurrent = GetMoney();
    local moneyEarned = moneyCurrent - HST.db.char.MoneyStart;

    local goldVal = math.floor(moneyEarned / 100 / 100);
    local silverVal = math.floor((moneyEarned / 100) % 100);
    local copperVal = math.floor(moneyEarned % 100);

    return "|cFFC9B037" .. HST:CommaSeparatedNum(goldVal) .. " " .. "|cFF808080" .. HST:CommaSeparatedNum(silverVal) ..
               " " .. "|cFF976D5C" .. HST:CommaSeparatedNum(copperVal)
end

function HST:GetEarnedKills()
    local currentKills = GetStatistic(1197)
    currentKills = tonumber(currentKills);

    if currentKills then
        return currentKills - HST.db.char.KillStart
    else
        return 0;
    end
end

function HST:BroadcastSession(broadcast)

    if (HST.db.profile.general_SessionPrompt and broadcast and UnitInParty("player") and
        (HST.LastBroadcastSent == nil or (GetServerTime() - HST.LastBroadcastSent) > HST.BroadcastCooldown)) then
        HST.LastBroadcastSent = GetServerTime();
        SendChatMessage(HST.SessionPromptString, "SAY", "COMMON");
    end
end

function HST:GetSessionDuration()
    if (tonumber(HST.db.char.SessionStartTime)) then
        HST.SessionDuration = GetServerTime() - HST.db.char.SessionStartTime
        local sessionDurationHours = string.format("%1.f", math.floor(HST.SessionDuration / 3600));
        local sessionDurationMinutes = string.format("%02.f",
                                           math.floor(HST.SessionDuration / 60 - (sessionDurationHours * 60)));
        return sessionDurationHours .. ":" .. sessionDurationMinutes;
    else
        return "00:00";
    end
end

function HST:GetRemainingBagSpace()
    local bag1 = GetContainerNumFreeSlots(0);
    local bag2 = GetContainerNumFreeSlots(1);
    local bag3 = GetContainerNumFreeSlots(2);
    local bag4 = GetContainerNumFreeSlots(3);
    local bag5 = GetContainerNumFreeSlots(4);
    return (bag1 + bag2 + bag3 + bag4 + bag5)
end
