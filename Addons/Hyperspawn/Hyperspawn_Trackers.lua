
---------------
-- Variables --
---------------

Hyperspawn_Tracker_interval = 0.125

-------------------
-- Create Frames --
-------------------

Hyperspawn_TrackerFrame = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
Hyperspawn_TrackerFrame:EnableMouse(true)
Hyperspawn_TrackerFrame:RegisterForDrag("LeftButton")
Hyperspawn_TrackerFrame:SetBackdrop({
	bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
    tile = true, 
	tileSize = 16, 
	edgeSize = 8, 
    insets = { left = 1, right = 1, top = 1, bottom = 1 },
})
Hyperspawn_TrackerFrame:SetBackdropColor(0,0,0,1);
Hyperspawn_TrackerFrame:SetHeight(111)
Hyperspawn_TrackerFrame:SetMovable(true)
Hyperspawn_TrackerFrame:SetPoint("CENTER",0,0)
Hyperspawn_TrackerFrame:SetWidth(128)
Hyperspawn_TrackerFrame:Show()
Hyperspawn_TrackerFrame.texture = Hyperspawn_TrackerFrame:CreateTexture()
Hyperspawn_TrackerFrame.texture:SetAllPoints(Hyperspawn_TrackerFrame)
Hyperspawn_TrackerFrame.texture:SetColorTexture(0.0,0.0,0.0,0.0)

	-- Hide Tracker Frame Button
		H_TF_B = CreateFrame("Button", nil, Hyperspawn_TrackerFrame, "UIPanelButtonTemplate")
		H_TF_B:SetHeight(20)
		H_TF_B:SetPoint("TOPRIGHT", 1, 14)
		H_TF_B:SetWidth(38)
		H_TF_B:SetText("EXT")
		
	-- Tracker Frame Font String
		T_TF_FS = Hyperspawn_TrackerFrame:CreateFontString()
		T_TF_FS:SetFont("Fonts\\FRIZQT__.TTF", 16)
		T_TF_FS:SetPoint("TOP", 0, -6)
		T_TF_FS:SetText("Hyperspawn")
		
	-- Kills Font String 1
		K_TF_FS1 = Hyperspawn_TrackerFrame:CreateFontString()
		K_TF_FS1:SetFont("Fonts\\FRIZQT__.TTF", 12)
		K_TF_FS1:SetPoint("TOPLEFT", 7, -28)
		K_TF_FS1:SetText("Kills:")
		
		-- Kills Font String 2
			K_TF_FS2 = Hyperspawn_TrackerFrame:CreateFontString()
			K_TF_FS2:SetFont("Fonts\\FRIZQT__.TTF", 14)
			K_TF_FS2:SetPoint("CENTER", 0, 2)
			
	-- Kills Reset Button
		KR_TF_B = CreateFrame("Button", nil, Hyperspawn_TrackerFrame, "UIPanelButtonTemplate")
		KR_TF_B:SetHeight(20)
		KR_TF_B:SetPoint("TOPRIGHT", 1, -25)
		KR_TF_B:SetWidth(38)
		KR_TF_B:SetText("RST")
		
	-- Money Font String 1
		M_TF_FS1 = Hyperspawn_TrackerFrame:CreateFontString()
		M_TF_FS1:SetFont("Fonts\\FRIZQT__.TTF", 12)
		M_TF_FS1:SetPoint("TOPLEFT", 7, -67)
		M_TF_FS1:SetText("Money:")
		
		-- Money Font String 2
			M_TF_FS2 = Hyperspawn_TrackerFrame:CreateFontString()
			M_TF_FS2:SetFont("Fonts\\FRIZQT__.TTF", 14)
			M_TF_FS2:SetPoint("CENTER", 0, -37)
			
	-- Money Reset Button
		MR_TF_B = CreateFrame("Button", nil, Hyperspawn_TrackerFrame, "UIPanelButtonTemplate")
		MR_TF_B:SetHeight(20)
		MR_TF_B:SetPoint("TOPRIGHT", 1, -64)
		MR_TF_B:SetWidth(38)
		MR_TF_B:SetText("RST")

Hyperspawn_Tracker_Update = CreateFrame("Frame");
LFM_M_B = CreateFrame("Button", nil, Hyperspawn_TrackerFrame, "UIPanelButtonTemplate")
LFM_M_B:SetHeight(20)
LFM_M_B:SetPoint("BOTTOMRIGHT", 2, -12)
LFM_M_B:SetText("LFM")
LFM_M_B:SetWidth(38)

---------------
-- Functions --
---------------

function Hyperspawn_Tracker_hideFrame()
	Hyperspawn_TrackerFrame:Hide()
	print("|c0000ff00 [|c00A020F0Hyperspawn|c0000ff00]: Type |r/hsshow |c0000ff00to restore the tracker frame.|r");
end

function Hyperspawn_Tracker_resetKills()
	Hyperspawn_Tracker_totalKillsLogin = GetStatistic(1197)
	print("|c0000ff00 [|c00A020F0Hyperspawn|c0000ff00]: The kill tracker has been reset.|r")
end

function Hyperspawn_Tracker_resetMoney()
	moneyStart = GetMoney();
	print("|c0000ff00 [|c00A020F0Hyperspawn|c0000ff00]: The money tracker has been reset.|r")
end

function Hyperspawn_Miscellaneous_lookingForMore()
	local groupSize = GetNumSubgroupMembers()
	local minimap = GetMinimapZoneText()
	local zone = GetZoneText()
	local openSpots = 3 - groupSize
	ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, "Community:357944461:1");
	ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, "Community:359059031:1");
	if UnitFactionGroup("player") == "Alliance" then
	local id, name, _ = GetChannelName("Community:357944461:1")
		if id > 0 and name ~= nil then
			if openSpots ~= 0 then 
				SendChatMessage("LF"..openSpots.."M "..minimap..", ("..zone..") farm. PST!", "CHANNEL", nil, id);
			else
				SendChatMessage("LFM "..minimap.." ("..zone..") farm. PST!", "CHANNEL", nil, id);
			end
		else
			print("|c00ffff00 [|c00A020F0Hyperspawn|c00ffff00]: You don't appear to be a member of the Hyperspawn community.|r")
		end
	elseif UnitFactionGroup("player") == "Horde" then
	local id, name, _ = GetChannelName("Community:359059031:1")
		if id > 0 and name ~= nil then
			if openSpots ~= 0 then 
				SendChatMessage("LF"..openSpots.."M "..minimap.." ("..zone..") farm. PST!", "CHANNEL", nil, id);
			else
				SendChatMessage("LFM "..minimap.." ("..zone..") farm. PST!", "CHANNEL", nil, id);
			end
		else
			print("|c00ffff00 [|c00A020F0Hyperspawn|c00ffff00]: You don't appear to be a member of the Hyperspawn community.|r")
		end
	end
end

function Hyperspawn_Tracker_OnUpdate(self, elapsed)
-- OnUpdate
self.TimeSinceLastUpdate = self.TimeSinceLastUpdate - elapsed
	if self.TimeSinceLastUpdate > 0 then
		return
	end	
self.TimeSinceLastUpdate = Hyperspawn_Tracker_interval
-- Kills Tracker
Hyperspawn_Tracker_totalKillsCurrent = GetStatistic(1197)
	if Hyperspawn_Tracker_totalKillsCurrent ~= "--" then
		if Hyperspawn_Tracker_totalKillsLogin ~= "--" then
			Hyperspawn_Tracker_totalKills = Hyperspawn_Tracker_totalKillsCurrent - Hyperspawn_Tracker_totalKillsLogin
		end
	else
		Hyperspawn_Tracker_totalKillsLogin = GetStatistic(1197)
	end
-- Money Tracker
	moneyCurrent = GetMoney();
	Hyperspawn_Tracker_totalMoney = moneyCurrent - moneyStart
-- Kills Tracker
	K_TF_FS2:SetText(Hyperspawn_Tracker_totalKills)
-- Money Tracker
	M_TF_FS2:SetText(("%dg %ds %dc"):format(Hyperspawn_Tracker_totalMoney / 100 / 100, (Hyperspawn_Tracker_totalMoney / 100) % 100, Hyperspawn_Tracker_totalMoney % 100));
end

-----------
-- Other --
-----------

Hyperspawn_Tracker_Update.TimeSinceLastUpdate = Hyperspawn_Tracker_interval

-----------------
-- Set Scripts --
-----------------

H_TF_B:SetScript("OnClick", Hyperspawn_Tracker_hideFrame)
Hyperspawn_TrackerFrame:SetScript("OnDragStart", Hyperspawn_TrackerFrame.StartMoving)
Hyperspawn_TrackerFrame:SetScript("OnDragStop", Hyperspawn_TrackerFrame.StopMovingOrSizing)
Hyperspawn_Tracker_Update:SetScript("OnUpdate", Hyperspawn_Tracker_OnUpdate)
LFM_M_B:SetScript("OnClick", Hyperspawn_Miscellaneous_lookingForMore)
KR_TF_B:SetScript("OnClick", Hyperspawn_Tracker_resetKills)
MR_TF_B:SetScript("OnClick", Hyperspawn_Tracker_resetMoney)