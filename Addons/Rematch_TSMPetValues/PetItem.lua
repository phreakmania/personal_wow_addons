------------------------------------------------------------------------------
-- Rematch_TSMPetValues - Add TSM market values ​​to the Rematch pet list
------------------------------------------------------------------------------
-- PetItem.lua - Pet Item Functions
--
-- Author: Expelliarm5s / October 2020 / All Rights Reserved
--
-- Version 1.1.19
------------------------------------------------------------------------------
-- luacheck: ignore 212 globals DLAPI

local addonName, addon = ...
local PetItem = addon:NewModule("PetItem", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
-- local private = {}

------------------------------------------------------------------------------
-- Debug Stuff

function PetItem:DebugPrintf(...)
	if addon.isDebug then
		local status, res = pcall(format, ...)
		if status then
			addon:DebugLog("PetItem~" .. res)
		end
	end
end

------------------------------------------------------------------------------
-- Addon Loading / Player Login/Logout

function PetItem:Login()
	PetItem:DebugPrintf("Login()")

	----------------------------------------------------------------------------------------------------
	-- TSM API Compatibility Layer

	if TSMAPI and TSMAPI.ValidateCustomPrice then
		PetItem:DebugPrintf("  found TSM3 and use TSMAPI.ValidateCustomPrice for addon.ValidateCustomPrice")
		addon.ValidateCustomPrice = function(...) return TSMAPI:ValidateCustomPrice(...) end
	elseif TSM_API and TSM_API.IsCustomPriceValid then
		PetItem:DebugPrintf("  found TSM4 and use TSM_API.IsCustomPriceValid for addon.ValidateCustomPrice")
		addon.ValidateCustomPrice = TSM_API.IsCustomPriceValid
	end

	if TSMAPI and TSMAPI.GetCustomPriceValue then
		PetItem:DebugPrintf("  found TSM3 and use TSMAPI.GetCustomPriceValue for addon.GetCustomPriceValue")
		addon.GetCustomPriceValue = function(...) return TSMAPI:GetCustomPriceValue(...) end
	elseif TSM_API and TSM_API.GetCustomPriceValue then
		PetItem:DebugPrintf("  found TSM4 and use TSM_API.GetCustomPriceValue for addon.GetCustomPriceValue")
		addon.GetCustomPriceValue = TSM_API.GetCustomPriceValue
	end

	if TSMAPI and TSMAPI.MoneyToString then
		PetItem:DebugPrintf("  found TSM3 and use TSMAPI.MoneyToString for addon.MoneyToString")
		addon.MoneyToString = function(...) return TSMAPI:MoneyToString(...) end
	elseif TSM_API and TSM_API.FormatMoneyString then
		PetItem:DebugPrintf("  found TSM4 and use TSM_API.FormatMoneyString for addon.MoneyToString")
		addon.MoneyToString = function(...)
			local v = TSM_API.FormatMoneyString(...)
			if v then
				v = strmatch(v, "^(.+)|cffffd70ag|r") or v
				return v .. "|cffffd70ag|r"
			else
				return "0|cffffd70ag|r"
			end
		end
	end

end

addon.petGoldValueC = {}

-- goldValue = GetPetGoldValue(petItemString, priceSource)
function PetItem.GetPetGoldValue(petItemString, priceSource)
	PetItem:DebugPrintf("GetPetGoldValue(%s, %s)", tostring(petItemString), tostring(priceSource))
	local price = 0
	if not priceSource then
		addon.aError = L["check empty price source"]
		return price
	end
	if petItemString then
		if addon.petGoldValueC[petItemString .. priceSource] then
			return addon.petGoldValueC[petItemString .. priceSource]
		end
		if addon.ValidateCustomPrice and addon.GetCustomPriceValue then
			-- TSM4 API is broken: we have to pcall() ValidateCustomPrice and GetCustomPriceValue to have it not break
			-- this addon if something went wrong _inside_ TSM4 we have no influence of!
			local status1, res1 = pcall(addon.ValidateCustomPrice, priceSource)
			if status1 then
				if res1 then
					local status2, res2 = pcall(addon.GetCustomPriceValue, priceSource, petItemString)
					if status2 then
						if tonumber(res2) then
							price = floor(res2 / COPPER_PER_GOLD)
						end
					else
						PetItem:DebugPrintf("ERR~TSM API error: %s", tostring(res2))
						addon.aError = L["TSM API error"] .. ": " .. res2
					end
				else
					PetItem:DebugPrintf("ERR~TSM price source error: %s", tostring(priceSource))
					priceSource = priceSource or L["invalid price source"]
					addon.aError = L["TSM price source error"] .. ": " .. priceSource
				end
			else
				PetItem:DebugPrintf("ERR~TSM API error: %s", tostring(res1))
				addon.aError = L["TSM API error"] .. ": " .. res1
			end
			addon.petGoldValueC[petItemString .. priceSource] = price
		end

		-- debugging without loaded TSM
		-- price = 1234
		-- addon.petGoldValueC[petItemString .. priceSource] = price
		-- addon.MoneyToString = function(w) return tostring(w) end

	end
	return price
end

-- priceInfoString = GetPriceInfo(petItemString)
function PetItem.GetPriceInfo(petItemString)
	PetItem:DebugPrintf("GetPriceInfo(%s)", tostring(petItemString))
	local priceInfo = ""
	local fps = 0
	local sps = 0

	if addon.db.global.valA then
		local itemValue = PetItem.GetPetGoldValue(petItemString, addon.db.global.valA)
		if itemValue and itemValue > 0 then
			local itemValueString = addon.MoneyToString(itemValue * COPPER_PER_GOLD, "OPT_TRIM")
			priceInfo = itemValueString
			fps = itemValue
		else
			priceInfo = "0"
		end
	end

	if addon.db.global.valB then
		local itemValue = PetItem.GetPetGoldValue(petItemString, addon.db.global.valB)
		if itemValue and itemValue > 0 then
			local itemValueString = addon.MoneyToString(itemValue * COPPER_PER_GOLD, "OPT_TRIM")
			priceInfo = priceInfo .. " / " .. itemValueString
			sps = itemValue
		else
			priceInfo = priceInfo .. " / 0"
		end
	end

	local aTrigger
	local fixedTrigger = tonumber(addon.db.global.valTH)
	if fixedTrigger ~= nil then
		aTrigger = fixedTrigger
	else
		aTrigger = PetItem.GetPetGoldValue(petItemString, addon.db.global.valTH)
	end

	if (priceInfo == "0" or priceInfo == "0 / 0" or priceInfo == "0c / 0c") then
		priceInfo = nil
	else
		if fps > 0 and sps > 0 and aTrigger then
			if ((fps - sps) >= 0) then
				if ((fps - sps) >= (aTrigger * 3)) then
					priceInfo = "+++ " .. priceInfo
				elseif ((fps - sps) >= (aTrigger * 2)) then
					priceInfo = "++ " .. priceInfo
				elseif ((fps - sps) >= (aTrigger * 1)) then
					priceInfo = "+ " .. priceInfo
				end
			end
			if ((sps - fps) > 0) then
				if ((sps - fps) > (aTrigger * 3)) then
					priceInfo = "--- " .. priceInfo
				elseif ((sps - fps) > (aTrigger * 2)) then
					priceInfo = "-- " .. priceInfo
				elseif ((sps - fps) > (aTrigger * 1)) then
					priceInfo = "- " .. priceInfo
				end
			end
		end
	end

	return priceInfo
end

