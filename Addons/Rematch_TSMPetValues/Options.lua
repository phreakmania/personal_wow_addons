------------------------------------------------------------------------------
-- Rematch_TSMPetValues - Add TSM market values ​​to the Rematch pet list
------------------------------------------------------------------------------
-- Options.lua - Hook for Rematch
--
-- Author: Expelliarm5s / October 2020 / All Rights Reserved
--
-- Version 1.1.19
------------------------------------------------------------------------------
-- luacheck: ignore 212 globals DLAPI
-- luacheck: globals AceGUIWidgetLSMlists, max line length 320, ignore 212

-- luacheck: globals Rematch

local addonName, addon = ...
local Options = addon:NewModule("Options", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local LSM = LibStub("LibSharedMedia-3.0")
-- local WidgetLists = AceGUIWidgetLSMlists
--------------------------------------------------------------------------------------------------------

--  Options
Options.defaults = {
	profile = {
	},
	global = {
		valA = "DBMinBuyout",
		valB = "DBRegionMarketAvg",
		valTH = "30% DBRegionMarketAvg",
	},
}

------------------------------------------------------------------------------
-- Debug Stuff

function Options:DebugPrintf(...)
	if addon.isDebug then
		local status, res = pcall(format, ...)
		if status then
			addon:DebugLog("OPT~" .. res)
		end
	end
end

function Options:Login()
	Options:DebugPrintf("Options:Login()")

	-- see https://wow.tools/files/#search=&page=1&sort=0&desc=asc
	if LSM then
		if not addon.isClassic then
			LSM:Register("sound", "Default", 567482)
			LSM:Register("sound", "Small Chain", 567577)
			LSM:Register("sound", "Bell Toll Alliance", 566564)
			LSM:Register("sound", "Bell Toll Horde", 565853)
			LSM:Register("sound", "Auction Window Close", 567499)
			LSM:Register("sound", "Quest Failed", 567459)
			LSM:Register("sound", "Fel Nova", 568582)
			LSM:Register("sound", "Simon Large Blue", 566076)
			LSM:Register("sound", "Simon Small Blue", 567002)
			LSM:Register("sound", "Portcullis Close", 566240)
			LSM:Register("sound", "PvP Flag Taken", 569200)
			LSM:Register("sound", "Cannon", 566101)
			LSM:Register("sound", "Alarm 2", 567399)
		else
			LSM:Register("sound", "Default", SOUNDKIT.AUCTION_WINDOW_OPEN)
			LSM:Register("sound", "Small Chain", SOUNDKIT.PUT_DOWN_SMALL_CHAIN)
			LSM:Register("sound", "AH Bell", SOUNDKIT.AUCTION_WINDOW_CLOSE)
			LSM:Register("sound", "Simon Small Blue", SOUNDKIT.AUCTION_WINDOW_OPEN)
		end
	end
end

function Options.PlaySound(key)
	if LSM and key and LSM:Fetch("sound", key) then
		local sound = LSM:Fetch("sound", key)
		if sound == "Interface\\Quiet.ogg" then
			-- nix
			Options:DebugPrintf("Playing/1: silence")
		else
			-- Options:Printf("Sound %s=%s", key, LSM:Fetch("sound", key))
			-- 8.2: no more sound file paths, check against external LSM registered sounds
			if type(sound) == "string" then
				if sound:match("^Sound") then
					Options:DebugPrintf("PlaySound/2: std sound")
					PlaySound(SOUNDKIT.AUCTION_WINDOW_OPEN, "master")
				else
					Options:DebugPrintf("PlaySoundFile/2: %s", sound)
					PlaySoundFile(sound, "master")
				end
			else
				if type(sound) == "number" then
					if addon.isClassic then
						Options:DebugPrintf("PlaySound/4: %s", tostring(sound))
						PlaySound(sound, "master")
					else
						Options:DebugPrintf("PlaySoundFile/4: %s", tostring(sound))
						PlaySoundFile(sound, "master")
					end
				else
					Options:DebugPrintf("PlaySound/5: std sound")
					PlaySound(SOUNDKIT.AUCTION_WINDOW_OPEN, "master")
				end
			end
		end
	else
		Options:DebugPrintf("PlaySound/6: std sound")
		PlaySound(SOUNDKIT.AUCTION_WINDOW_OPEN, "master")
	end
end

function Options.GetOptions(uiType, uiName, appName)
	if appName == addonName then
		local options = {
			type = "group",
			name = addon.METADATA.NAME .. " (" .. addon.METADATA.VERSION .. ")",
			args = {
				desc1 = {
					type = "description",
					order = 0,
					name = "|cff99ccff-: by " .. GetAddOnMetadata(addonName, "Author") .. " :-|r|n|n" .. GetAddOnMetadata(addonName, "Notes"),
					fontSize = "medium",
				},
				desc1a = {
					type = "description",
					order = 0.05,
					name = "",
				},
				g1 = {
					type = "group",
					order = 1,
					guiInline = true,
					name = L["Price Sources"],
					args = {
						valAVal = {
							name = L["First Price Source"],
							desc = L["Choose a TSM price source"],
							type = "input",
							order = 0.1,
							width = "double",
							get = function()
								return addon.db.global.valA
								end,
							set = function(_, value)
								if value == "" then value = nil end
								if addon.db.global.valA ~= value then
									addon.db.global.valA = value
									addon.aError = nil
									if value then
										local status, res1 = pcall(addon.ValidateCustomPrice, value)
										if status then
											if not res1 then
												addon.aError = L["TSM price source error"] .. ": " .. value
											end
										else
											addon.aError = L["TSM API error"] .. ": " .. res1
										end
									end
									addon.errorPrinted = false
									addon.PrintIfError()
									wipe(addon.petGoldValueC)
									if Rematch and Rematch.UpdateRoster then
										Rematch.UpdateRoster()
									end
								end
							end,
						},
						desc2 = {
							type = "description",
							order = 0.2,
							name = L["Default is 'DBMinBuyout', one of '/tsm sources'"],
							width = "double",
						},
						valBVal = {
							name = L["Second Price Source"],
							desc = L["Choose a TSM price source"],
							type = "input",
							order = 0.3,
							width = "double",
							get = function()
								return addon.db.global.valB
								end,
							set = function(_, value)
								if value == "" then value = nil end
								if addon.db.global.valB ~= value then
									addon.db.global.valB = value
									addon.aError = nil
									if value then
										if addon.ValidateCustomPrice and addon.GetCustomPriceValue then
											local status, res1 = pcall(addon.ValidateCustomPrice, value)
											if status then
												if not res1 then
													addon.aError = L["TSM price source error"] .. ": " .. value
												end
											else
												addon.aError = L["TSM API error"] .. ": " .. res1
											end
										end
									end
									addon.errorPrinted = false
									addon.PrintIfError()
									wipe(addon.petGoldValueC)
									if Rematch and Rematch.UpdateRoster then
										Rematch.UpdateRoster()
									end
								end
							end,
						},
						desc3 = {
							type = "description",
							order = 0.4,
							name = L["Default is 'DBRegionMarketAvg', one of '/tsm sources'"],
							width = "double",
						},
					},
				},
				g2 = {
					type = "group",
					order = 2,
					name = L["Alerts"],
					guiInline = true,
					args = {
						valTHVal = {
							name = L["Alert Trigger"],
							desc = L["Choose the amount of gold to trigger the +/- notice. Example: '5000g' or '50% DBRegionMarketAvg'."],
							type = "input",
							order = 0.5,
							width = "double",
							get = function()
								return addon.db.global.valTH
								end,
							set = function(_, value)
								if value == "" then value = nil end
								if addon.db.global.valTH ~= value then
									addon.db.global.valTH = value
									addon.aError = nil
									if value then
										if addon.ValidateCustomPrice and addon.GetCustomPriceValue then
											local status, res1 = pcall(addon.ValidateCustomPrice, value)
											if status then
												if not res1 then
													addon.aError = L["TSM price source error"] .. ": " .. value
												end
											else
												addon.aError = L["TSM API error"] .. ": " .. res1
											end
										end
									end
									addon.errorPrinted = false
									addon.PrintIfError()
									wipe(addon.petGoldValueC)
									if Rematch and Rematch.UpdateRoster then
										Rematch.UpdateRoster()
									end
								end
							end,
						},
						desc4a = {
							type = "description",
							order = 0.6,
							fontSize = "medium",
							name = L["If the difference between the first and second market value is greater than this value, an + is printed in front of a price info, up to three times. Otherwise an - is printed. Defaults to 5000."],
							width = "full",
						},
						desc4b = {
							type = "description",
							order = 0.65,
							fontSize = "medium",
							name = L["Example: Set the first price source to 'DBMinBuyout' and the second to 'DBRegionMarketAvg'. For every + you can expect a greater chance to gain gold, if you sell this pet on this server. For every - you can expect to gain gold, if you buy this pet on this server and sell it on an other server."],
							width = "full",
						},
					},
				},
			},
		}
		return options
	end
end

-- EOF
