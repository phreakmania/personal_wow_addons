------------------------------------------------------------------------------
-- Rematch_TSMPetValues - Add TSM market values ​​to the Rematch pet list
------------------------------------------------------------------------------
-- GUI_Rematch_Petlist1.lua - Hook for Rematch
--
-- Author: Expelliarm5s / October 2020 / All Rights Reserved
--
-- Version 1.1.19
------------------------------------------------------------------------------
-- luacheck: ignore 212 globals DLAPI
-- luacheck: globals Rematch

local addonName, addon = ...
local Rematch_PetList1 = addon:NewModule("Rematch_PetList1", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local private = {}

------------------------------------------------------------------------------
-- Debug Stuff

function Rematch_PetList1:DebugPrintf(...)
	if addon.isDebug then
		local status, res = pcall(format, ...)
		if status then
			addon:DebugLog("RemPL1~" .. res)
		end
	end
end

------------------------------------------------------------------------------
-- Addon Loading / Player Login/Logout

function Rematch_PetList1:ModuleName()
	return Rematch_PetList1.moduleName
end

function Rematch_PetList1:Login()
	Rematch_PetList1:DebugPrintf("Login()")

	addon.db.global[Rematch_PetList1:ModuleName()] = false
	if Rematch and Rematch.FillPetListButton and Rematch.GetIDType then
		Rematch_PetList1:DebugPrintf("   found Rematch and hook into Rematch.FillPetListButton()")

		private.OldRFPLB = Rematch.FillPetListButton
		Rematch.FillPetListButton = addon.NewRFPLB

		addon.db.global[Rematch_PetList1:ModuleName()] = true
	end
end

-- itemString, customName, name = GetPetItemString(petID)
local function GetPetItemString(petID)
	Rematch_PetList1:DebugPrintf("GetPetItemString(%s)", tostring(petID))

	local idType
	if Rematch.GetIDType then
		idType = Rematch.GetIDType(nil, petID)
	else
		return
	end

	local _, speciesID, tsmSpeciesID, customName, level, name, rarity, petInfo
	level = 1 -- doesn't matter
	rarity = 3 -- doesn't matter

	if idType=="pet" then
		speciesID, customName, level, _, _, _, _, name = C_PetJournal.GetPetInfoByPetID(petID)
		level = level or 1
		tsmSpeciesID = speciesID
	elseif idType=="species" then
		tsmSpeciesID = petID
	else
		return
	end

	if tsmSpeciesID == nil then
		return
	end

	if Rematch and Rematch.petInfo and Rematch.petInfo.Fetch then
		petInfo = Rematch.petInfo:Fetch(petID)
	end

	if not petInfo.valid then
		return
	end

	rarity = petInfo.rarity or rarity

	local petItemString = "p:" .. tsmSpeciesID .. ":" .. level .. ":" .. tostring(rarity)
	return petItemString, customName, name
end

-- hooked Function is Rematch:FillPetListButton(button, petID, forLoadout)
function addon.NewRFPLB(obj, button, petID, forLoadout)
	private.OldRFPLB(obj, button, petID, forLoadout)

	Rematch_PetList1:DebugPrintf("NewRFPLB(%s, %s, %s, %s)", tostring(obj), tostring(button), tostring(petID), tostring(forLoadout))

	local petItemString, customName, name = GetPetItemString(petID)
	local priceInfo = addon.PetItem and addon.PetItem.GetPriceInfo(petItemString)

	if priceInfo and button ~= nil then
		if button.SubName ~= nil then
			if customName then
				button.SubName:SetFontObject(GameFontHighlight )
				button.SubName:SetText(priceInfo .. ", " .. name)
			else
				button.SubName:SetFontObject(GameFontHighlight)
				button.SubName:SetText(priceInfo)
			end
			button.SubName:SetHeight(15)
			button.Name:SetHeight(21)
			button.SubName:Show()
		else
			-- Erscheinungsoptionen > Kompakte Listen
			addon.aError = L["Please disable 'Compact List Format' in Rematch > Options > Appearance Options."]
		end
	end

	addon.PrintIfError()
end
