local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local ICON_QUESTIONMARK = "Interface\\RaidFrame\\ReadyCheck-Waiting"

-- Get the array of saved tasks
if not Altoholic.db.global.Tasks then
    Altoholic.db.global.Tasks = {}
end
local tasks = Altoholic.db.global.Tasks

local function taskPassesLevelFilter(task, character)    
    if not task.MinimumLevel then return true end
    if not DataStore:GetCharacterLevel(character) then return false end
    
    if task.MinimumLevel <= DataStore:GetCharacterLevel(character) then
        return true
    else
        return false
    end
end

local function taskPassesFactionFilter(task, character)
    local characterFaction = DataStore:GetCharacterFaction(character)
    
    if characterFaction == "Neutral" then return false end
    
    if characterFaction == "Horde" then
        if (task.HordeAllowed == false) then return false end
    elseif characterFaction == "Alliance" then
        if (task.AllianceAllowed == false) then return false end
    else
        print("Error 37")
    end
    return true
end

local function taskPassesFilters(taskID, character)
    if taskID == nil then return true end
    
    local task = tasks[taskID]
    if task == nil then return true end
    
    return (taskPassesLevelFilter(task, character) and taskPassesFactionFilter(task, character))
end

local function isTaskComplete(taskID, character)
    if taskID == nil then return false end

    local task = tasks[taskID]
    if task == nil then return false end
    
    if (task.Category == nil) or (task.Target == nil) then return false end
    
    if task.Category == "Daily Quest" then
        local completed = false
        for _, daily in pairs(DataStore:GetDailiesHistory(character)) do
            if daily.id == task.Target then
                return true
            end 
        end
        return false
    end
    
    if task.Category == "Dungeon" then
        if (task.Expansion == nil) then return false end
        if (task.Difficulty == nil) then return false end
        
        for dungeonKey, _ in pairs(DataStore:GetSavedInstances(character)) do
            local instanceName, instanceID = strsplit("|", dungeonKey)
            local taskTargetName = EJ_GetInstanceInfo(task.Target)
            if instanceName == (taskTargetName.." "..task.Difficulty) then
                return true
            end
		end
        return false
    end
    
    if task.Category == "Raid" then
        if (task.Expansion == nil) then return false end
        if (task.Difficulty == nil) then return false end
        
        local taskTargetName = EJ_GetInstanceInfo(task.Target)
        
        for dungeonKey, _ in pairs(DataStore:GetSavedInstances(character)) do
            local instanceName, instanceID = strsplit("|", dungeonKey)
                        
            if task.Difficulty == "classic" then
                if instanceName == "Ahn'Qiraj Temple 40 Player" then
                    if taskTargetName == "Temple of Ahn'Qiraj" then
                        return true
                    end
                elseif instanceName == "Ahn'Qiraj Ruins 20 Player" then
                    if taskTargetName == "Ruins of Ahn'Qiraj" then
                        return true
                    end
                else
                    instanceName = instanceName.." 40 Player"
                    if taskTargetName == instanceName then
                        return true
                    end
                end
            else
                if instanceName == (taskTargetName.." "..task.Difficulty) then
                    return true
                end
            end
		end
        return false    
    end
    
    if task.Category == "Dungeon Boss" then
        if not task.Expansion then return false end
        if not task.Difficulty then return false end
        
        if type(task.Target) ~= "table" then return false end
        if not task.Target["instanceID"] then return false end
        if not task.Target["creatureName"] then return false end
        
        local taskTargetName = EJ_GetInstanceInfo(task.Target["instanceID"])
        
        for dungeonKey, _ in pairs(DataStore:GetSavedInstances(character)) do
            local instanceName, instanceID = strsplit("|", dungeonKey)
            if instanceName == (taskTargetName.." "..task.Difficulty) then
                local reset, lastCheck, isExtended, isRaid, numEncounters, encounterProgress, dungeonBosses = DataStore:GetSavedInstanceInfo(character, dungeonKey)
                return dungeonBosses[task.Target["creatureName"]]
            end
		end
        return false        
    end
    
    if task.Category == "Raid Boss" then
        if not task.Expansion then return false end
        if not task.Difficulty then return false end
        
        if type(task.Target) ~= "table" then return false end
        if not task.Target["instanceID"] then return false end
        if not task.Target["creatureName"] then return false end
        
        local taskTargetName = EJ_GetInstanceInfo(task.Target["instanceID"])
        
        for dungeonKey, _ in pairs(DataStore:GetSavedInstances(character)) do
            local instanceName, instanceID = strsplit("|", dungeonKey)
                        
            if task.Difficulty == "classic" then
                if instanceName == "Ahn'Qiraj Temple 40 Player" then
                    if taskTargetName == "Temple of Ahn'Qiraj" then
                        local reset, lastCheck, isExtended, isRaid, numEncounters, encounterProgress, dungeonBosses = DataStore:GetSavedInstanceInfo(character, dungeonKey)
                        return dungeonBosses[task.Target["creatureName"]]
                    end
                elseif instanceName == "Ahn'Qiraj Ruins 20 Player" then
                    if taskTargetName == "Ruins of Ahn'Qiraj" then
                        local reset, lastCheck, isExtended, isRaid, numEncounters, encounterProgress, dungeonBosses = DataStore:GetSavedInstanceInfo(character, dungeonKey)
                        return dungeonBosses[task.Target["creatureName"]]
                    end
                else
                    instanceName = instanceName.." 40 Player"
                    if taskTargetName == instanceName then
                        local reset, lastCheck, isExtended, isRaid, numEncounters, encounterProgress, dungeonBosses = DataStore:GetSavedInstanceInfo(character, dungeonKey)
                        return dungeonBosses[task.Target["creatureName"]]
                    end
                end
            else             
                if instanceName == (taskTargetName.." "..task.Difficulty) then
                    local reset, lastCheck, isExtended, isRaid, numEncounters, encounterProgress, dungeonBosses = DataStore:GetSavedInstanceInfo(character, dungeonKey)
                    return dungeonBosses[task.Target["creatureName"]]
                end
            end                
		end
        return false        
    end
        
    if task.Category == "Profession Cooldown" then
        for _ , profession in pairs(DataStore:GetProfessions(character)) do
            if DataStore:GetNumActiveCooldowns(profession) > 0 then
                for i = 1, DataStore:GetNumActiveCooldowns(profession) do
                    local name, expiresIn, resetsIn, expiresAt = DataStore:GetCraftCooldownInfo(profession, i)
                    if name == task.Target then
                        return true
                    end
                end
            end
        end
        return false
    end
    
    if task.Category == "World Boss" then
        for bossKey, bossReset in pairs(DataStore:GetSavedWorldBosses(character)) do
            local bossName, bossID = strsplit("|", bossKey)
            if bossName == task.Target then
                return true
            end
        end
        return false
    end
end

local function OnDropDownClicked(self)
    addon:ToggleUI()
	AltoTasksOptions:Show()
end

local function DropDown_Initialize(frame, level)
	frame:AddButton("Manage", 1, OnDropDownClicked)
end

local callbacks = {
	OnUpdate = function() 
		end,
	OnUpdateComplete = function() end,
	GetSize = function() return #tasks end,
	RowSetup = function(self, rowFrame, dataRowID)
            if (tasks[dataRowID]) and (tasks[dataRowID].Name) then
			    rowFrame.Name.Text:SetText(tasks[dataRowID].Name)
            end
			rowFrame.Name.Text:SetJustifyH("LEFT")
		end,
	RowOnEnter = function()	end,
	RowOnLeave = function() end,
	ColumnSetup = function(self, button, dataRowID, character)
			button.Name:SetFontObject("GameFontNormalSmall")
			button.Name:SetJustifyH("CENTER")
			button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
			button.Background:SetDesaturated(false)
			button.Background:SetTexCoord(0, 1, 0, 1)
			
			button.Background:SetTexture(GetItemIcon(currentItemID) or ICON_QUESTIONMARK)

			local text = icons.notReady
			local vc = 0.25	-- vertex color

			if #tasks ~= 0 then		
				if taskPassesFilters(dataRowID, character) then
                    if isTaskComplete(dataRowID, character) then
					   vc = 1.0
					   text = icons.ready
				    else
					   vc = 0.4
				    end
                else
                    button:Hide()
                end
			end

			button.Background:SetVertexColor(vc, vc, vc)
			button.Name:SetText(text)
			button.id = currentItemID
		end,
	OnEnter = function(self)  
		end,
	OnClick = function(self, button)
		end,
	OnLeave = function(self) 
		end,
		
	InitViewDDM = function(frame, title)
			dropDownFrame = frame
			frame:Show()
			title:Show()
			
			frame:SetMenuWidth(100) 
			frame:SetButtonWidth(20)
			frame:SetText("Manage Tasks")
			frame:Initialize(DropDown_Initialize, "MENU_NO_BORDERS")
		end,
}

AltoholicTabGrids:RegisterGrid(15, callbacks)
