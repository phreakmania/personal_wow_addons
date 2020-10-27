NoFlashAddon = {}
NoFlashAddon.Frame = CreateFrame("Frame")
NoFlashAddon.Frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addon_name = ...
        if addon_name == "!NoFlash" then
            NoFlashAddon:LoadConfigDefaults()
            NoFlashAddon:CreateOptionsFrame()
        end
    end
end)
NoFlashAddon.Frame:RegisterEvent("ADDON_LOADED")

-- Logic code start

local flashIconCallerList =
{
    SetInCombat = function() return NoFlashDB.FlashOnEnterCombat end,
    ChatFrame_MessageEventHandler = function() return NoFlashDB.FlashOnWhisper end,
    RolePollPopup_Show = function() return NoFlashDB.FlashOnRoleSelect end,
    PVPFramePopup_SetupPopUp = function() return NoFlashDB.FlashOnPvpInvite end,
    LFGEventFrame_OnEvent = function() return NoFlashDB.FlashOnLfgInvite end,
    LFGListInviteDialog_Show = function() return NoFlashDB.FlashOnLfgInvite end,
	["LFGFrame.lua"] = function() return NoFlashDB.FlashOnLfgInvite end,
    ShowReadyCheck = function() return NoFlashDB.FlashOnReadyCheck end
}


-- Save the reference to the original function, then replace the 
_G['FlashClient_ORIG'] = FlashClientIcon
FlashClientIcon = function()
    local EnableDebugMessage = NoFlashDB.EnableDebugMessage
    -- get some caller data like file, line and function name
    local file, line, func = string.match(debugstack(2, 1, 0), "([^:]+):([0-9]+): in function ([^\n]+)")
	
    if(file == nil) then
        print("Someone unexpected called FlashClientIcon! Please report this to the developer!")
        print(debugstack())
        if(FlashFromUnknownSource) then
            FlashClient_ORIG();
        end
        return
    end

    -- functions inside XMLs dont have a filename nor a useful function name
    -- those functions look like [string ":OnShow"] - i just check for the leading bracket
    if(func:sub(2,2) == "[") then
        -- function is defined inside a xml, need to walk the stack :/
        for i in string.gmatch(debugstack(2), "(.-)\r?\n") do
            file, line, func = string.match(i, "([^:]+):([0-9]+): in function ([^\n]+)")
            if(file ~= nil and file:sub(1, 9) == "Interface") then
                -- we found a function which is defined in a file
                break
            end
        end
    end
	
	-- before we can use this fun name for our blacklist checking
	-- we need to check for a special edge case where
	-- the functionname is lua file including line number (Blizzard, why?!)
	local _file, _line = string.match(func, "\<Interface\\FrameXML\\([^:\\]+):([^>]+)\>")
	if(_file) then
		if(EnableDebugMessage) then
			print("Edgecase - func name defined as file: " .. _file)
		end
		func = _file
	else
		-- if this is not said special case, we just remove the leading and trailing quotes from the func name
		func = func:sub(2, func:len()-1) 
	end
	
    
    
    -- check if the caller is blacklisted from using the FlashClientIcon function
    local stateCallback = flashIconCallerList[func]
    local state = nil
    if stateCallback ~= nil then state = stateCallback() end

    if(state == false) then
        if(EnableDebugMessage) then
            print(func.." is blacklisted")
        end
    elseif (not FlashFromUnknownSource and state == nil) then
        if(EnableDebugMessage) then
            print(func.." is blacklisted (unknown function)")
        end
    else
        if(EnableDebugMessage) then
			print(func.." is not blacklisted")
			if(FlashFromUnknownSource) then
				print("##################")
				print(debugstack(2))
				print("##################")
			end
        end
        FlashClient_ORIG();
    end
end
print("|cFFCC0000!NoFlash|r online! Now with interface options!")

function NoFlashAddon:LoadConfigDefaults()
    if not NoFlashDB then NoFlashDB = {} end
    NoFlashDB.FlashOnWhisper = NoFlashDB.FlashOnWhisper or false
    NoFlashDB.FlashOnEnterCombat = NoFlashDB.FlashOnEnterCombat or false
    NoFlashDB.FlashOnRoleSelect = NoFlashDB.FlashOnRoleSelect or false
    NoFlashDB.FlashOnPvpInvite = NoFlashDB.FlashOnEnterCombat or false
    NoFlashDB.FlashOnLfgInvite = NoFlashDB.FlashOnLfgInvite or false
    NoFlashDB.FlashOnReadyCheck = NoFlashDB.FlashOnReadyCheck or false
    NoFlashDB.FlashFromUnknownSource = NoFlashDB.FlashFromUnknownSource or false
    NoFlashDB.EnableDebugMessage = NoFlashDB.EnableDebugMessage or false
end

function NoFlashAddon:CreateOptionsFrame()		-- Constructs the options frame
    NoFlashAddon.options = CreateFrame("Frame", "NoFlashOptions")
	
	local title = NoFlashAddon.options:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetFont("Fonts\\FRIZQT__.TTF", 16)
	title:SetText("!NoFlash")
	title:SetPoint("TOPLEFT", 16, -16)
	
	local subtitle = NoFlashAddon.options:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	subtitle:SetFont("Fonts\\FRIZQT__.TTF", 10)
	subtitle:SetText("Version " .. GetAddOnMetadata("!NoFlash","Version"))
	subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 4, -8)
    
    local cbIndex = 1
    local function CreateCheckButton(name, desc)
        local cb = CreateFrame("CheckButton", "NoFlashCFG"..name, NoFlashAddon.options, "UICheckButtonTemplate")
        cb:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", -3, cbIndex * -25)
        cbIndex = cbIndex + 1
        local text = _G["NoFlashCFG".. name .."Text"];
        text:SetJustifyH("LEFT")
        text:SetText(desc)
        cb:SetScript("OnClick", function(self) NoFlashDB[name] = self:GetChecked() end)
        cb:SetChecked(NoFlashDB[name])
    end

    CreateCheckButton("FlashOnWhisper", "flash the window on incoming whispers")
    CreateCheckButton("FlashOnEnterCombat", "Flash when entering combat")
    CreateCheckButton("FlashOnRoleSelect", "Flash when the role select window in a raid pops up")
    CreateCheckButton("FlashOnPvpInvite", "Flash when a pvp invite is pending")
    CreateCheckButton("FlashOnLfgInvite", "flash when a lfg invite is pending")
    CreateCheckButton("FlashOnReadyCheck", "flash when a ready check was issued")
    CreateCheckButton("FlashFromUnknownSource", "allow flashing from unknown sources (i.e. addons)")
    CreateCheckButton("EnableDebugMessage", "show debug messages in chat")
	
	NoFlashAddon.options.name = "!NoFlash"
	InterfaceOptions_AddCategory(NoFlashAddon.options)
end