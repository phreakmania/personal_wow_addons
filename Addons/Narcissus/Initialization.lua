--[[
Saved Variables:
1. NarcissusDB (primary)
2. NarciCreatureOptions (creature database)
3. NarcissusDB_PC (per character)
--]]

Narci = {};

local DefaultValue = {
    ["DetailedIlvlInfo"] = true,
    ["IsSortedByCategory"] = true,
    ["EnableGrainEffect"] = false,
    ["FontHeightItemName"] = 10,
    ["GlobalScale"] = 0.8,
    ["AutoColorTheme"] = true,
    ["ColorChoice"] = 0,
    ["EnableDoubleTap"] = false,
    ["CameraOrbit"] = true,
    ["CameraSafeMode"] = true,
    ["BorderTheme"] = "Bright",
    ["TooltipTheme"] = "Bright",
    ["TruncateText"] = false,
    ["ItemNameWidth"] = 180,
    ["FadeButton"] = false,
    ["WeatherEffect"] = true,
    ["VignetteStrength"] = 0.5,
    ["FadeMusic"] = false,
    ["AlwaysShowModel"] = false,
    ["DefaultLayout"] = 2,
    ["LetterboxEffect"] = false,
    ["LetterboxRatio"] = 2.35,
    ["AFKScreen"] = false,
    ["AFKAutoStand"] = false,                       --Do /stand emote now and then when you go AFK
    ["GemManager"] = true,                          --Enable gem manager for Blizzard item socketing frame
    ["DressingRoom"] = true,                        --Enable dressing room module
    ["DressingRoomUseTargetModel"] = true,          --Replace the the dressing room room with your targeted player
    ["DressingRoomIncludeItemID"] = false,          --Show Item ID in the clipboard
    ["UseEntranceVisual"] = true,
    ["ModelPanelScale"] = 1,
    ["BaseLineOffset"] = 0,                         --Ultra-wide
    ["ShrinkArea"] = 0,                             --Reduce the width of the area where you can control the model
    ["AutoPlayAnimation"] = true,                   --Play recommended animation when clicking a spell visual entry
    ["EyeColor"] = 1,                               --Corruption Indicator Orange
    ["CorruptionBar"] = true,
    ["CorruptionTooltip"] = false,
    ["CorruptionTooltipModel"] = true,
    ["UseEscapeButton"] = true,                     --Use Escape button to exit
    ["ShowMinimapButton"] = true,
    ["ShowModulePanelOnMouseOver"] = true,          --Mouseover to show Module panel while mouseover minimap button
    ["IndependentMinimapButton"] = false,           --Set Minimap Button Parent to Minimap or UIParent; Handle by other addons like MBB
    ["AnchorToMinimap"] = true,                     --Anchor the mini button to Minimap
    ["CameraTransition"] = true,                    --(2nd you use the Character Pane) Camera moves smoothly bewtween presets
    ["UseBustShot"] = true,                         --Zoom in to the upper torso

    --Internal Hotkey
    ["SearchRelativesHotkey"] = "TAB",              --The key you press to begin/cycle relative search
    
    --Deprecated
    --["UseExitConfirmation"] = true,               --Show exit confirmation dialog upon leaving group photo mode
    --["ShowFullBody"] = true,                      --Show entire body in Xmog Mode
};

local CreatureDatabaseOptions = {
    ["LoadOnDemand"] = true,                        --Don't load until database is required
    ["SearchRelatives"] = false,                    --Search for NPCs with the same last name
    ["TranslateName"] = false,                      --Show NPC localized name
    ["ShowTranslatedNameOnNamePlate"] = false,      --Show translated name on tooltip
    ["NamePlateNameOffset"] = 0,                    --Y Offset
    ["NamePlateLanguage"] = nil,                    --The localized name on NamePlate  (only one)
    ["Languages"] = {},                             --Enabled localized names on tooltip
};

local AchievementOptions = {
    ["UseAsDefault"] = false,
    ["Scale"] = 1,
    ["Theme"] = 1,
    ["IncompleteFirst"] = true,
    ["ShowRedMark"] = false,                        --Mark achievement that was not earned by me with a red cross
};

local TutorialInclude = {
    "SpellVisualBrowser", "EquipmentSetManager", "Movement", "ExitConfirmation",    --"IndependentMinimapButton"
    "NPCBrowserEntance", "NPCBrowser", 
};

local function Initialize_NarcissusDB()
    NarcissusDB = NarcissusDB or {};                            --Account-wide Variables
    NarciCreatureOptions = NarciCreatureOptions or {};          --Creature Database
    NarciAchievementOptions = NarciAchievementOptions or {};    --Achievement Settings
    NarcissusDB_PC = NarcissusDB_PC or {};                      --Character-specific Variables
    NarcissusDB_PC.EquipmentSetDB = NarcissusDB_PC.EquipmentSetDB or {};

    NarcissusDB.MinimapButton = NarcissusDB.MinimapButton or {};
    NarcissusDB.MinimapButton.Position = NarcissusDB.MinimapButton.Position or rad(150);

    if (not NarcissusDB.Version) or (type(NarcissusDB.Version) ~= "number") then    --Used for showing patch notes when opening Narcissus after an update
        NarcissusDB.Version = 10000;
    end

    if (not NarcissusDB.PhotoModeButton) or (type(NarcissusDB.PhotoModeButton) ~= "table") then
        NarcissusDB.PhotoModeButton = {};
    end

    if NarcissusDB.PhotoModeButton.HideTexts == nil then
        NarcissusDB.PhotoModeButton.HideTexts =  true;
    end

    ---------------------
    ------Preference-----
    ---------------------    
    for k, v in pairs(DefaultValue) do
        if NarcissusDB[k] == nil then
            NarcissusDB[k] = v;
        end
    end

    ---------------------
    ----Creature Data----
    ---------------------
    for k, v in pairs(CreatureDatabaseOptions) do
        if NarciCreatureOptions[k] == nil then
            NarciCreatureOptions[k] = v;
        end
    end

    ---------------------
    --Achievement Data---
    ---------------------
    for k, v in pairs(AchievementOptions) do
        if NarciAchievementOptions[k] == nil then
            NarciAchievementOptions[k] = v;
        end
    end


    ---------------------
    ----Per Character----
    ---------------------
    if NarcissusDB_PC.UseAlias == nil then
        NarcissusDB_PC.UseAlias = false;
    end

    if NarcissusDB_PC.PlayerAlias == nil then
        NarcissusDB_PC.PlayerAlias = "";
    end

    --
    NarcissusDB.Tutorials = NarcissusDB.Tutorials or {};
    local Tutorials = NarcissusDB.Tutorials;
    for _, v in pairs(TutorialInclude) do
        if Tutorials[v] == nil then
            Tutorials[v] = true;   --True ~ will show tutorial
        end
    end
end

local initialize = CreateFrame("Frame");
initialize:RegisterEvent("ADDON_LOADED");
--initialize:RegisterEvent("PLAYER_ENTERING_WORLD");
initialize:SetScript("OnEvent",function(self,event,...)
    if event == "ADDON_LOADED" then
        local name = ...
        if name == "Narcissus" then
            self:UnregisterEvent("ADDON_LOADED");
            Initialize_NarcissusDB();
            if (not NarciCreatureOptions.LoadOnDemand) or NarciCreatureOptions.SearchRelatives or NarciCreatureOptions.TranslateName then
                C_Timer.After(0, function()
                    LoadAddOn("Narcissus_Database");
                end)
            end
        end
    end
end)