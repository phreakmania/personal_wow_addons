
---------------
-- Variables --
---------------

Hyperspawn_Miscellaneous_interval = 1

-------------------
-- Create Frames --
-------------------

Hyperspawn_Miscellaneous_Update = CreateFrame("Frame");
SG_M_B = CreateFrame("Button", nil, MerchantFrame, "UIPanelButtonTemplate")

---------------
-- Functions --
---------------

function Hyperspawn_Miscellaneous_OnUpdate(self, elapsed)
-- OnUpdate
self.TimeSinceLastUpdate = self.TimeSinceLastUpdate - elapsed
	if self.TimeSinceLastUpdate > 0 then
		return
	end	
self.TimeSinceLastUpdate = Hyperspawn_Miscellaneous_interval
-- Black Ox Statue Raid Target Icon
	if BOS_M_CB:GetChecked() == true then
	local bosIcon = GetRaidTargetIndex("target")
	local bosName = GetUnitName("target")
		if bosIcon == nil then
			if bosName == "Black Ox Statue" then
				SetRaidTargetIcon("target", 8)
			end
		end		
	end
end

function Hyperspawn_Miscellaneous_sellItems()
TotalPrice = 0
	for myBags = 0,4 do
		for bagSlots = 1, GetContainerNumSlots(myBags) do
		CurrentItemLink = GetContainerItemLink(myBags, bagSlots)
			if CurrentItemLink then
			_, _, itemRarity, _, _, _, _, _, _, _, itemSellPrice = GetItemInfo(CurrentItemLink)
			_, itemCount = GetContainerItemInfo(myBags, bagSlots)
				if itemRarity == 0 and itemSellPrice ~= 0 then
				TotalPrice = TotalPrice + (itemSellPrice * itemCount)
					UseContainerItem(myBags, bagSlots)
				end
			end
		end
	end
end


-----------
-- Other --
-----------

Hyperspawn_Miscellaneous_Update.TimeSinceLastUpdate = Hyperspawn_Miscellaneous_interval
SG_M_B:RegisterForClicks("AnyUp")
SG_M_B:SetHeight(22)
SG_M_B:SetPoint("TopRight", -200, -0 )
SG_M_B:SetText("Sell Grays")
SG_M_B:SetWidth(80)

---------------------
-- Register Events --
---------------------

-----------------
-- Set Scripts --
-----------------

Hyperspawn_Miscellaneous_Update:SetScript("OnUpdate", Hyperspawn_Miscellaneous_OnUpdate)
SG_M_B:SetScript("OnClick", Hyperspawn_Miscellaneous_sellItems)