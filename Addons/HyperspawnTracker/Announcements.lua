---------------
-- Variables --
---------------
HST.Announcement_interval = 1

-------------------------------
------ ON UPDATE EVENT---------
-------------------------------
local function HST_Annoucement_OnUpdate(self, elapsed)
    -- OnUpdate
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate - elapsed
    if self.TimeSinceLastUpdate > 0 then
        return
    end
    self.TimeSinceLastUpdate = HST.Announcement_interval

    if (HST.db.char.SessionActive) then
        -- Tap Announcement
        if HST.db.profile.publicAlert_TappedMob then
            if UnitIsTapDenied("target") then
                if HST.db.char.tappedMobSent == false then
                    HST.db.char.tappedMobSent = true
                    SendChatMessage("has observed a tapped target (gray mob)!", "EMOTE")
                end
            end
        end

        -- Black Ox Statue Warning
        if HST.db.profile.blackOx_ExpireAlert and HST.CurrentSpec == "Brewmaster" then
            local duration1 = GetTotemTimeLeft(1)
            local duration2 = GetTotemTimeLeft(2)
            local haveTotem1, _, _, _, _ = GetTotemInfo(1)
            local haveTotem2, _, _, _, _ = GetTotemInfo(2)
            if duration1 < HST.Announcement_OxStatueWarningTime and duration2 < HST.Announcement_OxStatueWarningTime then
                if haveTotem1 or haveTotem2 then
                    HST:PrintText("Your black ox statue is about to expire.", "warning")
                end
            end
        end

        -- Group Size Announcement
        if HST.db.profile.personalAlert_GroupSize then
            if UnitIsGroupLeader("player") then
                local groupSize = GetNumSubgroupMembers() + 1;
                if HST.db.char.groupSizeAlertSent == false then
                    if (groupSize > 4) then
                        HST:PrintText("Your group size is over 4 members.", "critical");
                        HST.db.char.groupSizeAlertSent = true;
                    end
                else
                    if (groupSize <= 4) then
                        HST.db.char.groupSizeAlertSent = false;
                    end
                end
            end
        end

        -- Loot Warnings
        if HST.db.profile.lootTimer_enabled then
            local lootTimer = HST:GetLootTimer();
            if (lootTimer == 30) then
                if (HST.db.profile.lootTimer_audioAlerts["thirtysec"]) then
                    HST:PlaySound(8959)
                end
                if (HST.db.profile.lootTimer_chatAlerts["thirtysec"]) then
                    HST:PrintText("Loot timer expires in 30 seconds.", "critical")
                end
            elseif lootTimer > 0 and lootTimer <= 5 then
                if (HST.db.profile.lootTimer_audioAlerts["fivesec"]) then
                    local tempSoundDir = "Interface\\AddOns\\HyperspawnTracker\\Sounds\\" .. lootTimer .. ".ogg"
                    HST:PlaySound(tempSoundDir);
                end
                if (HST.db.profile.lootTimer_chatAlerts["fivesec"]) then
                    HST:PrintText("Loot timer expires in : " .. lootTimer .. "", "critical");
                end

            elseif lootTimer < 1 and lootTimer >= 0 then
                if (HST.db.profile.lootTimer_audioAlerts["expired"]) then
                    HST:PlaySound(8959)
                end
                if (HST.db.profile.lootTimer_chatAlerts["expired"]) then
                    HST:PrintText("Loot timer has expired!", "critical");
                end
            end
        end

        if HST.db.profile.lootTimer_enableEpicTimer then
            local epicLootTimer = HST:GetEpicLootTimer();
            if (epicLootTimer == 30) then
                if (HST.db.profile.lootTimer_audioAlerts["thirtysec"]) then
                    HST:PlaySound(8959)
                end
                if (HST.db.profile.lootTimer_chatAlerts["thirtysec"]) then
                    HST:PrintText("Loot timer expires in 30 seconds.", "critical")
                end
            elseif epicLootTimer > 0 and epicLootTimer <= 5 then
                if (HST.db.profile.lootTimer_audioAlerts["fivesec"]) then
                    local tempSoundDir = "Interface\\AddOns\\HyperspawnTracker\\Sounds\\" .. epicLootTimer .. ".ogg"
                    HST:PlaySound(tempSoundDir);
                end
                if (HST.db.profile.lootTimer_chatAlerts["fivesec"]) then
                    HST:PrintText("Loot timer expires in : " .. epicLootTimer .. "", "critical");
                end

            elseif epicLootTimer < 1 and epicLootTimer >= 0 then
                if (HST.db.profile.lootTimer_audioAlerts["expired"]) then
                    HST:PlaySound(8959)
                end
                if (HST.db.profile.lootTimer_chatAlerts["expired"]) then
                    HST:PrintText("Loot timer has expired!", "critical");
                end
            end
        end
    end
end

-------------------
-- Create Frames --
-------------------
HST.Frame_Annoucement_Update = CreateFrame("Frame");
HST.Frame_Annoucement_Update.TimeSinceLastUpdate = HST.Announcement_interval
HST.Frame_Annoucement_Update:SetScript("OnUpdate", HST_Annoucement_OnUpdate)