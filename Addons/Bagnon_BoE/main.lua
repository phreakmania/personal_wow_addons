if (not Bagnon) then
	return
end
if (function(addon)
	for i = 1,GetNumAddOns() do
		if (string.lower((GetAddOnInfo(i))) == string.lower(addon)) then
			if (GetAddOnEnableState(UnitName("player"), i) ~= 0) then
				return true
			end
		end
	end
end)("Bagnon_ItemInfo") then 
	return 
end 

local MODULE =  ...
local ADDON, Addon = MODULE:match("[^_]+"), _G[MODULE:match("[^_]+")]
local Module = Bagnon:NewModule("BindOnEquip", Addon)

-- Tooltip used for scanning
local ScannerTip = _G.BagnonItemInfoScannerTooltip or CreateFrame("GameTooltip", "BagnonItemInfoScannerTooltip", WorldFrame, "GameTooltipTemplate")
local ScannerTipName = ScannerTip:GetName()

-- Lua API
local _G = _G
local string_find = string.find
local string_match = string.match

-- WoW API
local GetDetailedItemLevelInfo = _G.GetDetailedItemLevelInfo 
local GetItemQualityColor = _G.GetItemQualityColor
local GetItemInfo = _G.GetItemInfo

-- WoW Strings
local S_ITEM_BOUND1 = _G.ITEM_SOULBOUND
local S_ITEM_BOUND2 = _G.ITEM_ACCOUNTBOUND
local S_ITEM_BOUND3 = _G.ITEM_BNETACCOUNTBOUND

-- Localization. 
-- *Just enUS so far. 
local L = {
	["BoE"] = "BoE", -- Bind on Equip 
	["BoU"] = "BoU"  -- Bind on Use
}

-- FontString Caches
local Cache_ItemBind = {}

-----------------------------------------------------------
-- Utility Functions
-----------------------------------------------------------
-- Update our secret scanner tooltip with the current button
local RefreshScanner = function(button)
	local bag, slot = button:GetBag(), button:GetID()
	ScannerTip.owner = button
	ScannerTip.bag = bag
	ScannerTip.slot = slot
	ScannerTip:SetOwner(button, "ANCHOR_NONE")
	ScannerTip:SetBagItem(button:GetBag(), button:GetID())
end

local IsItemBound = function(button)
	-- Refresh the scanner item
	RefreshScanner(button)

	-- We're trying line 2 to 6 for the bind texts, 
	-- I don't think they're ever further down.
	for i = 2,6 do 
		local line = _G[ScannerTipName.."TextLeft"..i]
		if (not line) then
			break
		end
		local msg = line:GetText()
		if msg and (string_find(msg, S_ITEM_BOUND1) or string_find(msg, S_ITEM_BOUND2) or string_find(msg, S_ITEM_BOUND3)) then 
			return true
		end
	end
end

-- Check if it's a caged battle pet
local GetBattlePetInfo = function(itemLink)
	if (string_find(itemLink, "battlepet")) then
		local data, name = string_match(itemLink, "|H(.-)|h(.-)|h")
		local  _, _, level, rarity = string_match(data, "(%w+):(%d+):(%d+):(%d+)")
		return true, level or 1, tonumber(rarity) or 0
	end
end

-----------------------------------------------------------
-- Cache & Creation
-----------------------------------------------------------
-- Retrieve a button's plugin container
local GetPluginContainter = function(button)
	local name = button:GetName() .. "ExtraInfoFrame"
	local frame = _G[name]
	if (not frame) then 
		frame = CreateFrame("Frame", name, button)
		frame:SetAllPoints()
	end 
	return frame
end

local Cache_GetItemBind = function(button)
	if (not Cache_ItemBind[button]) then
		local ItemBind = GetPluginContainter(button):CreateFontString()
		ItemBind:SetDrawLayer("ARTWORK")
		ItemBind:SetPoint("BOTTOMLEFT", 2, 2)
		ItemBind:SetFontObject(_G.NumberFont_Outline_Med or _G.NumberFontNormal) 
		ItemBind:SetFont(ItemBind:GetFont(), 11, "OUTLINE")
		ItemBind:SetShadowOffset(1, -1)
		ItemBind:SetShadowColor(0, 0, 0, .5)

		-- Move Pawn out of the way
		local UpgradeIcon = button.UpgradeIcon
		if UpgradeIcon then
			UpgradeIcon:ClearAllPoints()
			UpgradeIcon:SetPoint("BOTTOMRIGHT", 2, 0)
		end

		-- Store the reference for the next time
		Cache_ItemBind[button] = ItemBind
	end
	return Cache_ItemBind[button]
end

-----------------------------------------------------------
-- Main Update
-----------------------------------------------------------
local Update = function(self)
	local itemLink = self:GetItem() 
	if itemLink then

		-- Get some blizzard info about the current item
		local itemName, _itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, iconFileDataID, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, isCraftingReagent = GetItemInfo(itemLink)
		local effectiveLevel, previewLevel, origLevel = GetDetailedItemLevelInfo(itemLink)
		local isBattlePet, battlePetLevel, battlePetRarity = GetBattlePetInfo(itemLink)

		-- Retrieve the itemID from the itemLink
		local itemID = tonumber(string_match(itemLink, "item:(%d+)"))

		---------------------------------------------------
		-- ItemBind
		---------------------------------------------------
		if (itemRarity and (itemRarity > 1)) and ((bindType == 2) or (bindType == 3)) and (not IsItemBound(self)) then
			local ItemBind = Cache_ItemBind[self] or Cache_GetItemBind(self)
			local r, g, b = GetItemQualityColor(itemRarity)
			ItemBind:SetTextColor(r * 2/3, g * 2/3, b * 2/3)
			ItemBind:SetText((bindType == 3) and L["BoU"] or L["BoE"])
		else 
			if Cache_ItemBind[self] then 
				Cache_ItemBind[self]:SetText("")
			end	
		end

	else
		if Cache_ItemBind[self] then 
			Cache_ItemBind[self]:SetText("")
		end	
	end	
end 

local item = Bagnon.ItemSlot or Bagnon.Item
if (item) and (item.Update) then
	hooksecurefunc(item, "Update", Update)
end
