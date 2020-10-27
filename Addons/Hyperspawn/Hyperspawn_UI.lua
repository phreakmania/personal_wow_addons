
---------------
-- Interface --
---------------

-- Interface Panel
Hyperspawn_UI = {};
Hyperspawn_UI.panel = CreateFrame("Frame", nil, UIParent);
Hyperspawn_UI.panel.name = "Hyperspawn"
InterfaceOptions_AddCategory(Hyperspawn_UI.panel);

	-- General Information Font String
		GI_HUI_FS = Hyperspawn_UI.panel:CreateFontString()
		GI_HUI_FS:SetFont("Fonts\\FRIZQT__.TTF", 10)
		GI_HUI_FS:SetPoint("TOPLEFT", 10, -10)
		GI_HUI_FS:SetText("This addon enables useful features to help make hyperspawn farming more convenient.")

------------------------
-- Alerts Child Panel --
------------------------

	Hyperspawn_UI.childpanel_Alerts = CreateFrame("Frame", nil, Hyperspawn_UI.panel);
	Hyperspawn_UI.childpanel_Alerts.name = "Alerts";
	Hyperspawn_UI.childpanel_Alerts.parent = Hyperspawn_UI.panel.name;
	InterfaceOptions_AddCategory(Hyperspawn_UI.childpanel_Alerts);

	-- Black Ox Statue Alert Check Button
		BOS_AL_CB = CreateFrame("CheckButton", nil, Hyperspawn_UI.childpanel_Alerts, "UICheckButtonTemplate")
		BOS_AL_CB:SetPoint("TOPLEFT", 10, -10)

		-- Black Ox Statue Alert Font String
			BOS_AL_FS = Hyperspawn_UI.childpanel_Alerts:CreateFontString()
			BOS_AL_FS:SetFont("Fonts\\FRIZQT__.TTF", 10)
			BOS_AL_FS:SetPoint("TOPLEFT", 41, -38)
			BOS_AL_FS:SetText("Alerts the player when their Black Ox Statue is about to despawn and when it has been destroyed.")

	-- Group Size Alert Check Button
		GS_AL_CB = CreateFrame("CheckButton", nil, Hyperspawn_UI.childpanel_Alerts, "UICheckButtonTemplate")
		GS_AL_CB:SetPoint("TOPLEFT", 10, -60)
		GS_AL_CB.text:SetText("Group Size")

		-- Group Size Alert Font String
			GS_AL_FS = Hyperspawn_UI.childpanel_Alerts:CreateFontString()
			GS_AL_FS:SetFont("Fonts\\FRIZQT__.TTF", 10)
			GS_AL_FS:SetPoint("TOPLEFT", 41, -88)
			GS_AL_FS:SetText("Alerts the party leader when their group has more than four members.")

	-- Loot Alert Check Button
		L_AL_CB = CreateFrame("CheckButton", nil, Hyperspawn_UI.childpanel_Alerts, "UICheckButtonTemplate")
		L_AL_CB:SetPoint("TOPLEFT", 10, -110)
		L_AL_CB.text:SetText("Loot")

		-- Loot Alert Font String 1
			L_AL_FS1 = Hyperspawn_UI.childpanel_Alerts:CreateFontString()
			L_AL_FS1:SetFont("Fonts\\FRIZQT__.TTF", 10)
			L_AL_FS1:SetPoint("TOPLEFT", 41, -138)
			L_AL_FS1:SetText("Alerts the player when the loot timer is about to expire and when it has expired.")

-------------------------------
-- Announcements Child Panel --
-------------------------------

	Hyperspawn_UI.childpanel_Announcements = CreateFrame("Frame", nil, Hyperspawn_UI.panel);
	Hyperspawn_UI.childpanel_Announcements.name = "Announcements";
	Hyperspawn_UI.childpanel_Announcements.parent = Hyperspawn_UI.panel.name;
	InterfaceOptions_AddCategory(Hyperspawn_UI.childpanel_Announcements);

	-- Auction House Announcement Check Button
		AH_AN_CB = CreateFrame("CheckButton", nil, Hyperspawn_UI.childpanel_Announcements, "UICheckButtonTemplate")
		AH_AN_CB:SetPoint("TOPLEFT", 10, -10)
		AH_AN_CB.text:SetText("Auction House")

		-- Auction House Announcement Font String
			AH_AN_FS = Hyperspawn_UI.childpanel_Announcements:CreateFontString()
			AH_AN_FS:SetFont("Fonts\\FRIZQT__.TTF", 10)
			AH_AN_FS:SetPoint("TOPLEFT", 41, -38)
			AH_AN_FS:SetText("Sends an emote when the player has summoned an auction house.")

	-- Mailbox Announcement Check Button
		M_AN_CB = CreateFrame("CheckButton", nil, Hyperspawn_UI.childpanel_Announcements, "UICheckButtonTemplate")
		M_AN_CB:SetPoint("TOPLEFT", 10, -60)
		M_AN_CB.text:SetText("Mailbox")

		-- Mailbox Announcement Font String
			M_AN_FS = Hyperspawn_UI.childpanel_Announcements:CreateFontString()
			M_AN_FS:SetFont("Fonts\\FRIZQT__.TTF", 10)
			M_AN_FS:SetPoint("TOPLEFT", 41, -88)
			M_AN_FS:SetText("Sends an emote when the player has summoned a mailbox.")

	-- Tap Announcement Check Button
		T_AN_CB = CreateFrame("CheckButton", nil, Hyperspawn_UI.childpanel_Announcements, "UICheckButtonTemplate")
		T_AN_CB:SetPoint("TOPLEFT", 10, -110)
		T_AN_CB.text:SetText("Tap")

		-- Tap Announcement Font String
			T_AN_FS = Hyperspawn_UI.childpanel_Announcements:CreateFontString()
			T_AN_FS:SetFont("Fonts\\FRIZQT__.TTF", 10)
			T_AN_FS:SetPoint("TOPLEFT", 41, -138)
			T_AN_FS:SetText("Sends an emote when the player has detected a tapped target (gray mob).")

	-- Vendor Announcement Check Button
		V_AN_CB = CreateFrame("CheckButton", nil, Hyperspawn_UI.childpanel_Announcements, "UICheckButtonTemplate")
		V_AN_CB:SetPoint("TOPLEFT", 10, -160)
		V_AN_CB.text:SetText("Vendor")
		
		-- Vendor Announcement Font String
			V_AN_FS = Hyperspawn_UI.childpanel_Announcements:CreateFontString()
			V_AN_FS:SetFont("Fonts\\FRIZQT__.TTF", 10)
			V_AN_FS:SetPoint("TOPLEFT", 41, -188)
			V_AN_FS:SetText("Sends an emote when the player has summoned a vendor.")

-------------------------------
-- Miscellaneous Child Panel --
-------------------------------

Hyperspawn_UI.childpanel_Miscellaneous = CreateFrame("Frame", nil, Hyperspawn_UI.panel);
Hyperspawn_UI.childpanel_Miscellaneous.name = "Miscellaneous";
Hyperspawn_UI.childpanel_Miscellaneous.parent = Hyperspawn_UI.panel.name;
InterfaceOptions_AddCategory(Hyperspawn_UI.childpanel_Miscellaneous);
			
	-- Black Ox Statue Raid Icon Check Button
		BOS_M_CB = CreateFrame("CheckButton", nil, Hyperspawn_UI.childpanel_Miscellaneous, "UICheckButtonTemplate")
		BOS_M_CB:SetPoint("TOPLEFT", 10, -10)
		BOS_M_CB.text:SetText("Black Ox Statue Raid Target Icon")

		-- Black Ox Statue Raid Icon Font String 1
			BOS_M_FS1 = Hyperspawn_UI.childpanel_Miscellaneous:CreateFontString()
			BOS_M_FS1:SetFont("Fonts\\FRIZQT__.TTF", 10)
			BOS_M_FS1:SetPoint("TOPLEFT", 41, -38)
			BOS_M_FS1:SetText("Automatically places a raid icon on a Black Ox Statue when targeted.")

------------------------
-- Timers Child Panel --
------------------------

	Hyperspawn_UI.childpanel_Timers = CreateFrame("Frame", nil, Hyperspawn_UI.panel);
	Hyperspawn_UI.childpanel_Timers.name = "Timers";
	Hyperspawn_UI.childpanel_Timers.parent = Hyperspawn_UI.panel.name;
	InterfaceOptions_AddCategory(Hyperspawn_UI.childpanel_Timers);

	-- Loot Timer Check Button
		LT_TI_CB = CreateFrame("CheckButton", nil, Hyperspawn_UI.childpanel_Timers, "UICheckButtonTemplate")
		LT_TI_CB:SetPoint("TOPLEFT", 10, -10)
		LT_TI_CB.text:SetText("Loot")

		-- Loot Timer Font String
			LT_TI_FS = Hyperspawn_UI.childpanel_Timers:CreateFontString()
			LT_TI_FS:SetFont("Fonts\\FRIZQT__.TTF", 10)
			LT_TI_FS:SetPoint("TOPLEFT", 41, -38)
			LT_TI_FS:SetText("Enables the loot timer when checked.")

------------------
-- Create Frame --
------------------

Hyperspawn_UI_Event = CreateFrame("Frame");

---------------
-- Functions --
---------------

function Hyperspawn_UI_OnEvent(self, event, ...)
	if event == "PLAYER_LOGIN" then
		AH_AN_CB:SetChecked(Hyperspawn_Options.AH_AN_CB)
		AH_AN_CB:SetScript("OnClick", function(self)
			Hyperspawn_Options.AH_AN_CB = AH_AN_CB:GetChecked()
		end)
		BOS_AL_CB:SetChecked(Hyperspawn_Options.BOS_AL_CB)
		BOS_AL_CB:SetScript("OnClick", function(self)
			Hyperspawn_Options.BOS_AL_CB = BOS_AL_CB:GetChecked()
		end)
		BOS_M_CB:SetChecked(Hyperspawn_Options.BOS_M_CB)
		BOS_M_CB:SetScript("OnClick", function(self)
			Hyperspawn_Options.BOS_M_CB = BOS_M_CB:GetChecked()
		end)
		GS_AL_CB:SetChecked(Hyperspawn_Options.GS_AL_CB)
		GS_AL_CB:SetScript("OnClick", function(self)
			Hyperspawn_Options.GS_AL_CB = GS_AL_CB:GetChecked()
		end)
		-- Hyperspawn_TrackerFrame:SetShown()(Hyperspawn_Options.Hyperspawn_TrackerFrame)
		L_AL_CB:SetChecked(Hyperspawn_Options.L_AL_CB)
		L_AL_CB:SetScript("OnClick", function(self)
			Hyperspawn_Options.L_AL_CB = L_AL_CB:GetChecked()
		end)
		LT_TI_CB:SetChecked(Hyperspawn_Options.LT_TI_CB)
		LT_TI_CB:SetScript("OnClick", function(self)
		Hyperspawn_Options.LT_TI_CB = LT_TI_CB:GetChecked()
			if LT_TI_CB:GetChecked() == false then
				L_AL_CB:Disable()
				L_AL_CB:SetChecked(true)
				L_AL_CB.text:SetText("Loot (Requires Loot Timer)")
				StopwatchFrame:Hide()
			else
				L_AL_CB:Enable()
				L_AL_CB.text:SetText("Loot")
			end
		end)
		M_AN_CB:SetChecked(Hyperspawn_Options.M_AN_CB)
		M_AN_CB:SetScript("OnClick", function(self)
			Hyperspawn_Options.M_AN_CB = M_AN_CB:GetChecked()
		end)
		T_AN_CB:SetChecked(Hyperspawn_Options.T_AN_CB)
		T_AN_CB:SetScript("OnClick", function(self)
			Hyperspawn_Options.T_AN_CB = T_AN_CB:GetChecked()
		end)
		V_AN_CB:SetChecked(Hyperspawn_Options.V_AN_CB)
		V_AN_CB:SetScript("OnClick", function(self)
			Hyperspawn_Options.V_AN_CB = V_AN_CB:GetChecked()
		end)
		if LT_TI_CB:GetChecked() == false then
			L_AL_CB:Disable()
			L_AL_CB.text:SetText("Loot (Requires Loot Timer)")
		end	
		if Hyperspawn_specName == "Brewmaster" then
			BOS_AL_CB:Enable()
			BOS_AL_CB.text:SetText("Black Ox Statue")
		else
			BOS_AL_CB:Disable()
			BOS_AL_CB.text:SetText("Black Ox Statue (Requires Brewmaster Monk)")
		end		
	end
end

---------------------
-- Register Events --
---------------------

Hyperspawn_UI_Event:RegisterEvent("PLAYER_LOGIN");

-----------------
-- Set Scripts --
-----------------

Hyperspawn_UI_Event:SetScript("OnEvent", Hyperspawn_UI_OnEvent)	

------------------------------
-- Widget Naming Convention --
------------------------------

-- Example:
-- FEATURE_PANEL_WIDGET#
-- LFM_M_CB2 is "Looking For More Miscellaneous Check Button 2"
-- See code comment for the number definition (font strings do not have a definition)
-- In this case "2" is "Bind On Equip"

-- Panel
-- AL = Alerts
-- AN = Announcements
-- M  = Miscellaneous
-- TI = Timers
-- TR = Trackers

-- Widget
-- CB = Check Button
-- DD = Drop Down Menu
-- EB = Edit Box
-- FS = Font String