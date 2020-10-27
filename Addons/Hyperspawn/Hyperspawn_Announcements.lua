
---------------
-- Variables --
---------------

Hyperspawn_Annoucement_interval = 1
Hyperspawn_Annoucement_tapBool = false
Hyperspawn_Annoucement_lootBool = false

-------------------
-- Create Frames --
-------------------

Hyperspawn_Annoucement_Event = CreateFrame("Frame");
Hyperspawn_Annoucement_Update = CreateFrame("Frame");

---------------
-- Functions --
---------------

function Hyperspawn_Annoucement_OnEvent(self, event, ...)
-- Spell Announcements
	if event == "UNIT_SPELLCAST_SUCCEEDED" then
	local unitTarget, _, spellID = ...
	local link = GetSpellLink(spellID)
		if unitTarget == "player" then
		-- Grand Expedition Yak
			if spellID == 122708 then
				if V_AN_CB:GetChecked() == true then
					SendChatMessage("has summoned a "..link..".", "EMOTE")
				end
		-- Jeeves
			elseif spellID == 49040 then
				if V_AN_CB:GetChecked() == true then
					SendChatMessage("has summoned a "..link..".", "EMOTE")
				end
		-- Mighty Caravan Brutosaur
			elseif spellID == 264058 then
				if AH_AN_CB:GetChecked() == true then
					SendChatMessage("has summoned a "..link..".", "EMOTE")
				end
		-- MOLL-E
			elseif spellID == 40768 then
				if M_AN_CB:GetChecked() == true then
					SendChatMessage("has summoned a "..link..".", "EMOTE")
				end
		-- Stampwhistle
			elseif spellID == 261602 then
				if M_AN_CB:GetChecked() == true then
					SendChatMessage("has summoned a "..link..".", "EMOTE")
				end
		-- Traveler's Tundra Mammoth (Alliance)
			elseif spellID == 61425 then
				if V_AN_CB:GetChecked() == true then
					SendChatMessage("has summoned a "..link..".", "EMOTE")
				end
		-- Traveler's Tundra Mammoth (Horde)
			elseif spellID == 61447 then
				if V_AN_CB:GetChecked() == true then
					SendChatMessage("has summoned a "..link..".", "EMOTE")
				end
			end
		end
-- Tap Announcement
	elseif event == "PLAYER_REGEN_ENABLED" then
		Hyperspawn_Annoucement_tapBool = false
	end
end

function Hyperspawn_Annoucement_OnUpdate(self, elapsed)
-- OnUpdate
self.TimeSinceLastUpdate = self.TimeSinceLastUpdate - elapsed
	if self.TimeSinceLastUpdate > 0 then
		return
	end
self.TimeSinceLastUpdate = Hyperspawn_Annoucement_interval
-- Tap Announcement
	if T_AN_CB:GetChecked() == true then
		if UnitIsTapDenied("target") == true then
			if Hyperspawn_Annoucement_tapBool == false then
				Hyperspawn_Annoucement_tapBool = true
				SendChatMessage("has observed a tapped target (gray mob)!", "EMOTE")
			end
		end
	end
end

-----------
-- Other --
-----------

Hyperspawn_Annoucement_Update.TimeSinceLastUpdate = Hyperspawn_Annoucement_interval

---------------------
-- Register Events --
---------------------

Hyperspawn_Annoucement_Event:RegisterEvent("CHAT_MSG_LOOT");
Hyperspawn_Annoucement_Event:RegisterEvent("MAIL_CLOSED");
Hyperspawn_Annoucement_Event:RegisterEvent("MAIL_SHOW");
Hyperspawn_Annoucement_Event:RegisterEvent("PLAYER_REGEN_ENABLED");
Hyperspawn_Annoucement_Event:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
Hyperspawn_Annoucement_Event:RegisterEvent("ZONE_CHANGED");

-----------------
-- Set Scripts --
-----------------

Hyperspawn_Annoucement_Event:SetScript("OnEvent", Hyperspawn_Annoucement_OnEvent)
Hyperspawn_Annoucement_Update:SetScript("OnUpdate", Hyperspawn_Annoucement_OnUpdate)