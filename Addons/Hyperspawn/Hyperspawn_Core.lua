-- /dump C_Club.GetSubscribedClubs()

---------------
-- Variables --
---------------

Hyperspawn_muteChat = true
Hyperspawn_ToggleOptions = true

-------------------
-- Create Frames --
-------------------

Hyperspawn_Core_Event = CreateFrame("Frame");

---------------
-- Functions --
---------------

function Hyperspawn_Core_OnEvent(self, event, ...)
	if event == "PLAYER_LOGIN" then
		ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, "Community:357944461:1");
		ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, "Community:359059031:1");
		Hyperspawn_specCurrent = GetSpecialization()
		Hyperspawn_specName = Hyperspawn_specCurrent and select(2, GetSpecializationInfo(Hyperspawn_specCurrent)) or "None"
		Hyperspawn_Tracker_totalKillsLogin = GetStatistic(1197)
		moneyStart = GetMoney();
		MuteSoundFile(18871)
		MuteSoundFile(12867)
		MuteSoundFile(12889)
		print("|c0000ff00 [|c00A020F0Hyperspawn|c0000ff00]: Type |r/hshelp |c0000ff00for a list of all slash commands.|r");
		print("|c0000ff00 [|c00A020F0Hyperspawn|c0000ff00]: Join our in-game community, checkout Discord for more information (https://discord.gg/SMzjRVT).|r");
		StopwatchFrame:Hide()
		if not Hyperspawn_Options then
			Hyperspawn_Options = {}
		end
	end
end

---------------------
-- Register Events --
---------------------

Hyperspawn_Core_Event:RegisterEvent("PLAYER_LOGIN");

-----------------
-- Set Scripts --
-----------------

Hyperspawn_Core_Event:SetScript("OnEvent", Hyperspawn_Core_OnEvent)

--------------------
-- Slash Commands --
--------------------

-- Fix
SLASH_HSFIX1 = "/hsfix"
SlashCmdList["HSFIX"] = function()
	if IsInRaid() then
		ConvertToParty()
		print("|c00ffff00 [|c00A020F0Hyperspawn|c00ffff00]: The addon has attempted to convert the raid into a party.|r")
	else
		print("|c00ffff00 [|c00A020F0Hyperspawn|c00ffff00]: You're not in a raid.|r")
	end
end

-- Help
SLASH_HSHELP1 = "/hshelp"
SlashCmdList["HSHELP"] = function()
	print("|c0000ff00 [|c00A020F0Hyperspawn|c0000ff00]: Here is a list of all available slash commands.|r")
	print("|c0000ff00 - Command: |r/hsfix")
	print("|c0000ff00   Action: attempts to convert the raid into a party|r")
	print(" ")
	print("|c0000ff00 - Command: |r/hsmute")
	print("|c0000ff00   Action: toggles the Hyperspawn community chat|r")
	print(" ")
	print("|c0000ff00 - Command: |r/hsshow")
	print("|c0000ff00   Action: shows the tracker frame|r")
end

-- Mute
SLASH_HSMUTE1 = "/hsmute"
SlashCmdList["HSMUTE"] = function()
	if Hyperspawn_muteChat == false then
		Hyperspawn_muteChat = true
		ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, "Community:357944461:1");
		ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, "Community:359059031:1");
		print("|c0000ff00 [Hyperspawn]: Community chat has been unmuted.|r");
	else
		Hyperspawn_muteChat = false
		ChatFrame_RemoveChannel(DEFAULT_CHAT_FRAME, "Community:357944461:1");
		ChatFrame_RemoveChannel(DEFAULT_CHAT_FRAME, "Community:359059031:1");
		print("|c00ffff00 [Hyperspawn]: Community chat has been muted.|r");
	end
end

-- Show
SLASH_HSSHOW1 = "/hsshow"
SlashCmdList["HSSHOW"] = function()
	Hyperspawn_TrackerFrame:Show()
end