
---------------
-- Variables --
---------------

Hyperspawn_Alert_bosWarningTime = 75
Hyperspawn_Alert_groupSizeBool = true
Hyperspawn_Alert_interval = 1

-------------------
-- Create Frames --
-------------------

Hyperspawn_Alert_Event = CreateFrame("Frame");
Hyperspawn_Alert_Update = CreateFrame("Frame");

---------------
-- Functions --
---------------

function Hyperspawn_Alert_OnEvent(self, event, ...)
-- Black Ox Statue Alert
	if event == "PLAYER_TOTEM_UPDATE" then
		if BOS_AL_CB:GetChecked() == true then
			if Hyperspawn_specName == "Brewmaster" then
			local haveTotem1, _, _, _, _ = GetTotemInfo(1)
			local haveTotem2, _, _, _, _ = GetTotemInfo(2)
				if haveTotem1 == false and haveTotem2 == false then
					PlaySound(8960, "master")
					print("|cffff0000 [|c00A020F0Hyperspawn|cffff0000]: Your Black Ox Statue has despawned. Summon it now!|r ")
				end
			end
		end
	end
end

function Hyperspawn_Alert_OnUpdate(self, elapsed)
-- OnUpdate
self.TimeSinceLastUpdate = self.TimeSinceLastUpdate - elapsed
	if self.TimeSinceLastUpdate > 0 then
		return
	end
self.TimeSinceLastUpdate = Hyperspawn_Alert_interval
-- Black Ox Statue Warning
	if BOS_AL_CB:GetChecked() == true then
		if Hyperspawn_specName == "Brewmaster" then
		local duration1 = GetTotemTimeLeft(1)
		local duration2 = GetTotemTimeLeft(2)
		local haveTotem1, _, _, _, _ = GetTotemInfo(1)
		local haveTotem2, _, _, _, _ = GetTotemInfo(2)
			if duration1 < Hyperspawn_Alert_bosWarningTime and duration2 < Hyperspawn_Alert_bosWarningTime then
				if haveTotem1 == true or haveTotem2 == true then
					print("|c00ffff00 [|c00A020F0Hyperspawn|c00ffff00]: Your Black Ox Statue is about to despawn. Summon it now!|r")
				end
			end
		end
	end
-- Group Size Alert
	if GS_AL_CB:GetChecked() == true then
		if UnitIsGroupLeader("player") == true then
		local groupSize = GetNumSubgroupMembers()
			if Hyperspawn_Alert_groupSizeBool == true then
				if groupSize > 3 then
					Hyperspawn_Alert_groupSizeBool = false
					print("|c00ffff00 [|c00A020F0Hyperspawn|c00ffff00]: You have more than four members in your group. Fix now!|r")
				end
			else
				if groupSize <= 3 then
					Hyperspawn_Alert_groupSizeBool = true
				end
			end
		end
	end
-- Loot Alert
	if L_AL_CB:GetChecked() == true then
		if L_AL_CB:IsEnabled() == true then
			if StopwatchTicker:IsVisible() == true then
				if StopwatchTicker.timer == 0 then
					PlaySound(8959, "master")
					print("|cffff0000 [|c00A020F0Hyperspawn|cffff0000]: The loot timer has expired. Loot now!|r")
					StopwatchFrame:Hide()
				end
			end
		end
	end
-- Loot Warning
	if L_AL_CB:GetChecked() == true then
		if L_AL_CB:IsEnabled() == true then
			if StopwatchTicker:IsVisible() == true then
				if StopwatchTicker.timer < 10 then
					print("|c00ffff00 [|c00A020F0Hyperspawn|c00ffff00]: The loot timer is about to expire. Loot now!|r")
				end
			end
		end
	end
end

-----------
-- Other --
-----------

Hyperspawn_Alert_Update.TimeSinceLastUpdate = Hyperspawn_Alert_interval

---------------------
-- Register Events --
---------------------

Hyperspawn_Alert_Event:RegisterEvent("PLAYER_LOGIN");
Hyperspawn_Alert_Event:RegisterEvent("PLAYER_TOTEM_UPDATE");

-----------------
-- Set Scripts --
-----------------

Hyperspawn_Alert_Event:SetScript("OnEvent", Hyperspawn_Alert_OnEvent)
Hyperspawn_Alert_Update:SetScript("OnUpdate", Hyperspawn_Alert_OnUpdate)