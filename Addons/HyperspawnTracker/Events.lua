local function HST_Core_OnEvent(self, event, ...)
    -- Spell Announcements
    if event == "PLAYER_LOGIN" then
        HST:PrintText("Type '/hst help' for a list of all commands.")
        -- Spec Grab for Brewmaster checks
        local specIndex = GetSpecialization()
        HST.db.char.currentSpec = specIndex and select(2, GetSpecializationInfo(specIndex)) or "None"
    elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
        local specIndex = GetSpecialization()
        HST.db.char.currentSpec = specIndex and select(2, GetSpecializationInfo(specIndex)) or "None"
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        if (HST.db.char.SessionActive) then
            local unitTarget, _, spellID = ...
            local link = GetSpellLink(spellID)
            if unitTarget == "player" then
                -- Auction House Announcement
                if (HST.db.profile.publicAlert_AuctionHouse and HST.AuctionHouseList[spellID]) then
                    SendChatMessage("summoned a " .. link .. ".", "EMOTE")
                    -- Vendor Announcement
                elseif (HST.db.profile.publicAlert_Vendor and HST.VendorList[spellID]) then
                    SendChatMessage("summoned a " .. link .. ".", "EMOTE")
                    -- Mailbox Announcement
                elseif (HST.db.profile.publicAlert_MailBox and HST.MailboxList[spellID]) then
                    SendChatMessage("summoned a " .. link .. ".", "EMOTE")
                end
            end
        end
        -- Tap Announcement
    elseif event == "PLAYER_REGEN_ENABLED" then
        HST.db.char.tappedMobSent = false
    elseif event == "CHAT_MSG_LOOT" then
        if (HST.db.char.SessionActive and HST.db.profile.publicAlert_LootedEpic and UnitInParty("player")) then
            local lootstring, player1, _, _, player = ...
            local itemLink = string.match(lootstring, "|%x+|Hitem:.-|h.-|h|r")
            local itemString = string.match(itemLink, "item[%-?%d:]+")
            local _, _, quality, _, _, class, subclass, _, equipSlot, texture, _, ClassID, SubClassID =
                GetItemInfo(itemString)
            local playerName = GetUnitName("player");
            local realmName = GetRealmName();
            if player == (playerName .. "-" .. realmName) then
                if (quality >= 4) then
                    SendChatMessage("Has looted an epic: " .. itemLink, "EMOTE")
                end
            end
        end
    elseif event == "CHAT_MSG_SAY" then
        if (HST.db.char.SessionActive and HST.db.profile.general_SessionPrompt) then
            local msg, sender, _ = ...
            if HST:PlayerSentMessage(sender) then
                return;
            elseif string.match(msg, HST.SessionPromptString) ~= nil then
                if (HST.LastBroadcastReceived == nil or (GetServerTime() - HST.LastBroadcastReceived) >
                    HST.BroadcastCooldown) then
                    HST.LastBroadcastReceived = GetServerTime();
                    StaticPopup_Show("HST_SessionPrompt")
                end
            end
        end
    elseif event == "PLAYER_TOTEM_UPDATE" then
        if HST.db.profile.blackOx_ExpireAlert then
            if HST.specName == "Brewmaster" then
                local haveTotem1, _, _, _, _ = GetTotemInfo(1)
                local haveTotem2, _, _, _, _ = GetTotemInfo(2)
                if haveTotem1 == false and haveTotem2 == false then
                    HST:PlaySound(8960);
                    HST:PrintText("Your Black Ox Statue has despawned. Summon it now!")
                end
            end
        end
        -- reset Loot timer
    elseif event == "LOOT_CLOSED" then
        if HST.db.profile.lootTimer_enabled or HST.db.profile.lootTimer_enableEpicTimer then
            HST.db.char.LootTimerStart = GetServerTime();
        end
        if (HST.db.profile.personalAlert_BagSpace) then
            local space = HST:GetRemainingBagSpace();
            if (space ~= HST.db.char.BagSpace) then
                HST.db.char.BagSpace = space;
                if (space < 5) then
                    HST:PrintText("You only have " .. space .. " spaces remaining.", "warning");
                end
            end
        end
    end
end

-- Events
HST.CoreFrame = CreateFrame("frame");
-- Set Event Scripts
HST.CoreFrame:SetScript("OnEvent", HST_Core_OnEvent)
-- Register Events
HST.CoreFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
HST.CoreFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
HST.CoreFrame:RegisterEvent("CHAT_MSG_LOOT");
HST.CoreFrame:RegisterEvent("CHAT_MSG_SAY");
HST.CoreFrame:RegisterEvent("LOOT_CLOSED");
HST.CoreFrame:RegisterEvent("PLAYER_TOTEM_UPDATE");
HST.CoreFrame:RegisterEvent("PLAYER_LOGIN");
HST.CoreFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED");

