SLASH_ABANDONZONE1 = "/abandonzone";

SlashCmdList["ABANDONZONE"] = function(zone)
	QuestTitles = {}
	HeaderValues = {}
	SectionIndices = {}
	for i = 1, GetNumQuestLogEntries() do
		local title = select(1, GetQuestLogTitle(i))
		local isHeader = select(4, GetQuestLogTitle(i))
		table.insert(QuestTitles, i, title)
		table.insert(HeaderValues, i, isHeader)
	end
	
	for index, value in pairs(HeaderValues) do
		if value == true then
			table.insert(SectionIndices, index)
		end
	end
	
	local valueFound = {false, nil, nil }
	for index, value in pairs(QuestTitles) do
		if (string.lower(value) == string.lower(zone)) and (HeaderValues[index]==true) then
			valueFound = { true, index, value }
		end
	end
	if valueFound[1] == true then
		nextSectionIndex = 0
		for index, value in pairs(SectionIndices) do
			if value == valueFound[2] then
				if index == table.getn(SectionIndices) then
					nextSectionIndex = table.getn(QuestTitles) + 1
				else
					nextSectionIndex = SectionIndices[index + 1]
				end
			end
		end
		for i = (valueFound[2]+1), (nextSectionIndex-1) do
			SelectQuestLogEntry(i)
			SetAbandonQuest()
			print("|cFFFFFF00Abandoned quest: '".. QuestTitles[i].. "'|r")
			AbandonQuest()
		end
	else
		if (string.lower(zone) == "all") then
			for i= 1, GetNumQuestLogEntries() do
				SelectQuestLogEntry(i);
				SetAbandonQuest();
				AbandonQuest();
			end
			print("|cFFFFFF00Abandoned all quests|r")
		elseif (string.lower(zone) == "help") or (zone == "") then
				print("|cFFFFFF00Type '/abandonzone' followed by the name of the zone you wish to abandon quests in, or type '/abandonzone all' to abandon all quests.|r")
		else
			print("|cFFFFFF00Zone '".. zone.. "' not found|r")
		end
	end
end

ButtonTable = {}
questsAbandoned = false

local function ClickAbandon(self, button, down)
	QuestTitles = {}
	HeaderValues = {}
	SectionIndices = {}
	for i = 1, GetNumQuestLogEntries() do
		local title = select(1, GetQuestLogTitle(i))
		local isHeader = select(4, GetQuestLogTitle(i))
		table.insert(QuestTitles, i, title)
		table.insert(HeaderValues, i, isHeader)
	end
	
	for index, value in pairs(HeaderValues) do
		if value == true then
			table.insert(SectionIndices, index)
		end
	end
	
	for index, value in pairs(ButtonTable) do
		if self == ButtonTable[index] then
			zoneIndex = index
		end
	end
	
	zone = "ZONE_ERROR"
	
	for index, value in pairs(QuestTitles) do
		if (index == SectionIndices[zoneIndex]) then
			zone = QuestTitles[index]
		end
	end
	
	StaticPopupDialogs["ABANDON_CONFIRMATION"] = {
		text = "Are you sure you want to abandon all quests in ".. zone.. "?",
		button1 = "Yes",
		button2 = "No",
		OnAccept = function()
			local valueFound = {false, nil, nil }
			for index, value in pairs(QuestTitles) do
				if (string.lower(value) == string.lower(zone)) and (HeaderValues[index]==true) then
					valueFound = { true, index, value }
				end
			end
			if valueFound[1] == true then
				nextSectionIndex = 0
				for index, value in pairs(SectionIndices) do
					if value == valueFound[2] then
						if index == table.getn(SectionIndices) then
							nextSectionIndex = table.getn(QuestTitles) + 1
						else
							nextSectionIndex = SectionIndices[index + 1]
						end
					end
				end
			end
			for i = (valueFound[2]+1), (nextSectionIndex-1) do
				SelectQuestLogEntry(i)
				SetAbandonQuest()
				print("|cFFFFFF00Abandoned quest: '".. QuestTitles[i].. "'|r")
				AbandonQuest()
			end
			questsAbandoned = true
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,
	}
	
	StaticPopup_Show ("ABANDON_CONFIRMATION")
end

local function createButton()
	local button = CreateFrame("Button", nil, QuestMapFrame.QuestsFrame)
	button:ClearAllPoints()
	button:SetPoint("TOPLEFT", 0, 0)
	button:SetWidth(30)
	button:SetHeight(30)
	button:SetNormalFontObject("GameFontNormal")
	button:RegisterForClicks("AnyUp");
	button:SetScript("OnClick", ClickAbandon)
	
	local ntex = button:CreateTexture()
	ntex:SetTexture("Interface/Buttons/CancelButton-Up")
	ntex:SetTexCoord(0, 1, 0, 1)
	ntex:SetAllPoints()	
	button:SetNormalTexture(ntex)
	
	local htex = button:CreateTexture()
	htex:SetTexture("Interface/Buttons/CancelButton-Highlight")
	htex:SetTexCoord(0, 1, 0, 1)
	htex:SetAllPoints()
	button:SetHighlightTexture(htex)
	
	local ptex = button:CreateTexture()
	ptex:SetTexture("Interface/Buttons/CancelButton-Down")
	ptex:SetTexCoord(0, 1, 0, 1)
	ptex:SetAllPoints()
	button:SetPushedTexture(ptex)
	return button
end

local function getNumHeaders()
	local numHeaders = 0
	for i = 1, GetNumQuestLogEntries() do
		local isHeader = select(4, GetQuestLogTitle(i))
		if (isHeader == true) then
			numHeaders = numHeaders + 1
		end
	end
	return numHeaders
end

local function calculateSpacing(headerNum)
	local HeaderValues = {}
	local SectionIndices = {}
	local ExpandedValues = {}
	local ExpandedIndices = {}
	for i = 1, GetNumQuestLogEntries() do
		local isHeader = select(4, GetQuestLogTitle(i))
		local isExpanded = not (select(5, GetQuestLogTitle(i)))
		table.insert(HeaderValues, i, isHeader)
		table.insert(ExpandedValues, i, isExpanded)
	end
	
	for index, value in pairs(HeaderValues) do
		if value == true then
			table.insert(SectionIndices, index)
		end
	end
	for index, value in pairs(ExpandedValues) do
		if (value == true) and (tContains(SectionIndices, index)) then
			table.insert(ExpandedIndices, index)
		end
	end
	
	local TitleHeight = {}
	for line in QuestScrollFrame.titleFramePool:EnumerateActive() do
		table.insert(TitleHeight, line:GetHeight())
	end

	local spacing = 0
	local heightIndex = table.getn(TitleHeight)
	for i = 1, headerNum do
		if (tContains(ExpandedIndices, SectionIndices[i])) then
			for i = 1, SectionIndices[i+1]-SectionIndices[i]-1 do
				if ( QuestMapFrame:IsShown() ) then
					if (heightIndex) > 0 then
						spacing = spacing + TitleHeight[heightIndex]
						heightIndex = heightIndex - 1
					end
				end
			end
			spacing = spacing + 16
		else
			spacing = spacing + 16
		end
	end
	if ( QuestScrollFrame.Contents.StoryHeader:IsShown() ) then
		spacing = spacing + QuestScrollFrame.Contents.StoryHeader:GetHeight() - 12
	end
	return spacing
end

local function headersToButtons()
	if (getNumHeaders()) then
		if (getNumHeaders() > table.getn(ButtonTable)) then
			for i = 1, (getNumHeaders() - table.getn(ButtonTable)) do
				table.insert(ButtonTable, i, createButton())
			end
		end
	end
end

local function buttonShow()
	if (getNumHeaders() <= table.getn(ButtonTable)) then
		for i = 1, getNumHeaders() do
			local vButtonPos = -4+ -calculateSpacing(i-1) + QuestScrollFrame:GetVerticalScroll()
			ButtonTable[i]:SetParent(QuestMapFrame.QuestsFrame);
			ButtonTable[i]:SetPoint("TOPLEFT", 230,vButtonPos)
			ButtonTable[i]:SetFrameStrata("DIALOG");
			if ((-485 < vButtonPos) and (vButtonPos < 10)) then
				ButtonTable[i]:Show();
			else
				ButtonTable[i]:Hide();
			end
		end
	end
end

local function buttonHide()
	for index, button in pairs(ButtonTable) do
		button:Hide();
		button:SetParent(nil);
	end
end

local function loadSequence()
	if (ButtonTable[1]) then
		if (questsAbandoned) then
			buttonHide();
			questsAbandoned = false
		end
		SetCVar("questLogOpen", 0);
		QuestMapFrame_Hide();
		SetCVar("questLogOpen", 1);
		QuestMapFrame_Show();
		buttonShow();
	end
end

QuestMapFrame:HookScript("OnShow", headersToButtons)
QuestMapFrame:HookScript("OnHide", buttonHide)
QuestMapFrame:HookScript("OnEvent", loadSequence)
QuestScrollFrame:HookScript("OnVerticalScroll", buttonShow)