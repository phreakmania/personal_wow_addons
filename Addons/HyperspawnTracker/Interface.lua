--- VARIABLES-----
HST.UIUpdateInterval = 0.125;
HST.DisplayStartTime = "--";
HST.PlayingSound = 0;

-- Create Panel UI --
HST.Frame_Panel = CreateFrame("Frame", "trackerFrame", UIParent, "TooltipBorderedFrameTemplate" or nil)
HST.Frame_Panel:EnableMouse(true)
HST.Frame_Panel:RegisterForDrag("LeftButton")
HST.Frame_Panel:SetHeight(120)
HST.Frame_Panel:SetMovable(true)
HST.Frame_Panel:SetPoint("CENTER", 0, 0)
HST.Frame_Panel:SetWidth(200)
HST.Frame_Panel.texture = HST.Frame_Panel:CreateTexture()
HST.Frame_Panel.texture:SetAllPoints(HST.Frame_Panel)
HST.Frame_Panel.TimeSinceLastUpdate = HST.UIUpdateInterval

-- Session Button
HST.Btn_ToggleSession = CreateFrame("Button", nil, HST.Frame_Panel, "UIPanelButtonTemplate")
HST.Btn_ToggleSession:SetHeight(32)
HST.Btn_ToggleSession:SetPoint("TOPLEFT", 3, 32)
HST.Btn_ToggleSession:SetWidth(160)
HST.Btn_ToggleSession:SetScript("OnClick", function(box)
    HST.db.char.SessionActive = HST.db.char.SessionActive == false;
    if (HST.db.char.SessionActive == true) then
        HST:NewSession(HST.db.profile.general_SessionPrompt)
    else
        HST:EndSession();
    end
end)

HST.Btn_ToggleSession_Text = HST.Btn_ToggleSession:CreateFontString()
HST.Btn_ToggleSession_Text:SetFont("Fonts\\FRIZQT__.TTF", HST.FontSize)
HST.Btn_ToggleSession_Text:SetText("Session Start")
HST.Btn_ToggleSession_Text:SetPoint("TOPLEFT", HST.Btn_ToggleSession, "TOPLEFT", 0, 0)
HST.Btn_ToggleSession_Text:SetPoint("BOTTOMRIGHT", HST.Btn_ToggleSession, "BOTTOMRIGHT", 0, 0)

-- Close Button
HST.Btn_CloseFrame = CreateFrame("Button", nil, HST.Frame_Panel, "UIPanelButtonTemplate")
HST.Btn_CloseFrame:SetHeight(32)
HST.Btn_CloseFrame:SetPoint("TOPRIGHT", -1, 32)
HST.Btn_CloseFrame:SetWidth(32)
HST.Btn_CloseFrame:SetScript("OnClick", function(box)
    HST.Frame_Panel:Hide()
    HST:PrintText("Type /hst to show the control.")
    HST.db.char.showPanel = false;
end)

HST.Btn_CloseFrame_Text = HST.Btn_CloseFrame:CreateFontString()
HST.Btn_CloseFrame_Text:SetFont("Fonts\\FRIZQT__.TTF", HST.FontSize)
HST.Btn_CloseFrame_Text:SetText("X")
HST.Btn_CloseFrame_Text:SetPoint("TOPLEFT", HST.Btn_CloseFrame, "TOPLEFT", 1, 0)
HST.Btn_CloseFrame_Text:SetPoint("BOTTOMRIGHT", HST.Btn_CloseFrame, "BOTTOMRIGHT", 0, 0)

-- Session Time Info
HST.Label_SessionStart = HST.Frame_Panel:CreateFontString()
HST.Label_SessionStart:SetFont("Fonts\\FRIZQT__.TTF", HST.FontSize)
HST.Label_SessionStart:SetPoint("TOPLEFT", HST.LeftPadding, -HST.TopPadding)

-- Kills Label
HST.Label_Kills = HST.Frame_Panel:CreateFontString()
HST.Label_Kills:SetFont("Fonts\\FRIZQT__.TTF", HST.FontSize)
HST.Label_Kills:SetPoint("TOPLEFT", HST.LeftPadding, -HST.TopPadding + (1 * (-HST.LineHeight)))
HST.Label_Kills:SetText("Kills:")

-- Money Label
HST.Label_Money = HST.Frame_Panel:CreateFontString()
HST.Label_Money:SetFont("Fonts\\FRIZQT__.TTF", HST.FontSize)
HST.Label_Money:SetPoint("TOPLEFT", HST.LeftPadding, -HST.TopPadding + (2 * (-HST.LineHeight)))
HST.Label_Money:SetText("Money:")

-- Loot Timer Label
HST.Label_LootTimer = HST.Frame_Panel:CreateFontString()
HST.Label_LootTimer:SetFont("Fonts\\FRIZQT__.TTF", HST.FontSize)
HST.Label_LootTimer:SetPoint("TOPLEFT", HST.LeftPadding, -HST.TopPadding + (3 * (-HST.LineHeight)))

HST.Label_EpicLootTimer = HST.Frame_Panel:CreateFontString()
HST.Label_EpicLootTimer:SetFont("Fonts\\FRIZQT__.TTF", HST.FontSize)
HST.Label_EpicLootTimer:SetPoint("TOPLEFT", HST.LeftPadding, -HST.TopPadding + (4 * (-HST.LineHeight)))

HST.UIFrameUpdate = CreateFrame("Frame");

function HST.Func_UIOnUpdate(self, elapsed)

    -- OnUpdate
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate - elapsed
    if self.TimeSinceLastUpdate > 0 then
        return
    end
    self.TimeSinceLastUpdate = HST.UIUpdateInterval

    if (HST.db.char.showPanel and not HST.Frame_Panel:IsVisible()) then
        HST.Frame_Panel:Show();
    elseif (not HST.db.char.showPanel and HST.Frame_Panel:IsVisible()) then
        HST.Frame_Panel:Hide();
    end
    
    if HST.db.char.SessionActive == true then
        HST.DisplayStartTime = date("%I:%M %p", HST.db.char.SessionStartTime)
        HST.Btn_ToggleSession_Text:SetText("End Session")
    else
        HST.DisplayStartTime = "--";
        HST.Label_SessionStart:SetText("-- (00:00)")
        HST.Btn_ToggleSession_Text:SetText("Start Session")
    end

    -- Kills Tracker
    HST.Label_Kills:SetText("Kills: " .. HST.GetEarnedKills())

    -- Money Tracker
    HST.Label_Money:SetText("Gold: " .. HST.BuildMoneyString());

    if (HST.db.char.SessionActive == true) then
        HST.Label_SessionStart:SetText(HST.DisplayStartTime .. " (" .. HST.GetSessionDuration() .. ")");

        -- loot timer 
        if HST.db.profile.lootTimer_enabled == true then
            HST.Label_EpicLootTimer:SetPoint("TOPLEFT", HST.LeftPadding, -HST.TopPadding + (4 * (-HST.LineHeight)))
            HST.Label_LootTimer:Show();
            local LootTimer = HST:GetLootTimer();
            if LootTimer == -1 then
                LootTimer = 0
            end
            local minutes = string.format("%1.f", math.floor(LootTimer / 60));
            local seconds = string.format("%02.f", math.floor(LootTimer - minutes * 60));
            -- do coloring and stuff for notifications
            if LootTimer > 30 then
                HST.Label_LootTimer:SetText(HST.Color_White .. "Loot Timer: " .. minutes .. ":" .. seconds)
            elseif LootTimer > 5 then
                HST.Label_LootTimer:SetText(HST.Color_White .. "Loot Timer: " .. HST.Color_Warning .. minutes .. ":" ..
                                                seconds)
            else
                HST.Label_LootTimer:SetText(HST.Color_White .. "Loot Timer: " .. HST.Color_Critical .. minutes .. ":" ..
                                                seconds)
            end
        else
            HST.Label_EpicLootTimer:SetPoint("TOPLEFT", HST.LeftPadding, -HST.TopPadding + (3 * (-HST.LineHeight)))
            HST.Label_LootTimer:Hide();
        end

        -- epic loot timer 
        if HST.db.profile.lootTimer_enableEpicTimer == true then
            HST.Label_EpicLootTimer:Show();
            local LootTimer = HST:GetEpicLootTimer();
            if LootTimer == -1 then
                LootTimer = 0
            end
            local minutes = string.format("%1.f", math.floor(LootTimer / 60));
            local seconds = string.format("%02.f", math.floor(LootTimer - minutes * 60));
            -- do coloring and stuff for notifications
            if LootTimer > 30 then
                HST.Label_EpicLootTimer:SetText("Epic Loot Timer: " .. HST.Color_White .. minutes .. ":" .. seconds)
            elseif LootTimer > 5 then
                HST.Label_EpicLootTimer:SetText("Epic Loot Timer: " .. HST.Color_Warning .. minutes .. ":" .. seconds)
            else
                HST.Label_EpicLootTimer:SetText("Epic Loot Timer: " .. HST.Color_Critical .. minutes .. ":" .. seconds)
            end
        else
            HST.Label_EpicLootTimer:Hide();
        end
    else
        HST.Label_LootTimer:Hide();
        HST.Label_EpicLootTimer:Hide();
    end

end

-- Scripts

HST.Frame_Panel:SetScript("OnDragStart", HST.Frame_Panel.StartMoving)
HST.Frame_Panel:SetScript("OnDragStop", HST.Frame_Panel.StopMovingOrSizing)
HST.Frame_Panel:SetScript("OnUpdate", HST.Func_UIOnUpdate)
