local BUI, E, L, V, P, G = unpack(select(2, ...))
local mod = BUI:GetModule('Actionbars')
local AB = E:GetModule('ActionBars')

if E.private.actionbar.enable ~= true then return; end

local _G = _G
local pairs = pairs
local C_TimerAfter = C_Timer.After
local MAX_TOTEMS = MAX_TOTEMS

-- GLOBALS: NUM_PET_ACTION_SLOTS
-- GLOBALS: ElvUI_BarPet, ElvUI_StanceBar

local classColor = E:ClassColor(E.myclass, true)

local styleOtherBacks = {ElvUI_BarPet, ElvUI_StanceBar}

function mod:StyleBackdrops()
	-- Actionbar backdrops
	for i = 1, 10 do
		local styleBacks = {_G['ElvUI_Bar'..i]}
		for _, frame in pairs(styleBacks) do
			if frame.backdrop then
				frame.backdrop:Style('Outside', nil, true, true)
			end

			-- Button Shadows
			if BUI.ShadowMode then
				for k = 1, 12 do
					local buttonBars = {_G["ElvUI_Bar"..i.."Button"..k]}
					for _, button in pairs(buttonBars) do
						if button.backdrop and not button.backdrop.shadow then
							button.backdrop:CreateSoftShadow()
						end
					end
				end
			end
		end
	end

	-- Other bar backdrops
	for _, frame in pairs(styleOtherBacks) do
		if frame.backdrop then
			frame.backdrop:Style('Outside', nil, true, true)
		end
	end
end

function mod:ToggleStyle()
	-- Actionbar backdrops
	for i = 1, 10 do
		if _G['ElvUI_Bar'..i].backdrop.style then
			if E.db.benikui.actionbars.style['bar'..i] then
				_G['ElvUI_Bar'..i].backdrop.style:Show()
			else
				_G['ElvUI_Bar'..i].backdrop.style:Hide()
			end
		end
	end

	-- Other bar backdrops
	if _G['ElvUI_BarPet'].backdrop.style then
		if E.db.benikui.actionbars.style.petbar then
			_G['ElvUI_BarPet'].backdrop.style:Show()
		else
			_G['ElvUI_BarPet'].backdrop.style:Hide()
		end
	end

	if _G['ElvUI_StanceBar'].backdrop.style then
		if E.db.benikui.actionbars.style.stancebar then
			_G['ElvUI_StanceBar'].backdrop.style:Show()
		else
			_G['ElvUI_StanceBar'].backdrop.style:Hide()
		end
	end
end

local r, g, b = 0, 0, 0

function mod:ColorBackdrops()
	if E.db.benikui.general.benikuiStyle ~= true then return end
	local db = E.db.benikui.colors

	for i = 1, 10 do
		local styleBacks = {_G['ElvUI_Bar'..i].backdrop.style}

		for _, frame in pairs(styleBacks) do
			if db.abStyleColor == 1 then
				r, g, b = classColor.r, classColor.g, classColor.b
			elseif db.abStyleColor == 2 then
				r, g, b = BUI:unpackColor(db.customAbStyleColor)
			elseif db.abStyleColor == 3 then
				r, g, b = BUI:unpackColor(E.db.general.valuecolor)
			else
				r, g, b = BUI:unpackColor(E.db.general.backdropcolor)
			end
			frame:SetBackdropColor(r, g, b, db.abAlpha or 1)
		end
	end

	for _, frame in pairs(styleOtherBacks) do
		local name = _G[frame:GetName()].backdrop.style

		if db.abStyleColor == 1 then
			r, g, b = classColor.r, classColor.g, classColor.b
		elseif db.abStyleColor == 2 then
			r, g, b = BUI:unpackColor(db.customAbStyleColor)
		elseif db.abStyleColor == 3 then
			r, g, b = BUI:unpackColor(E.db.general.valuecolor)
		else
			r, g, b = BUI:unpackColor(E.db.general.backdropcolor)
		end
		if name then
			name:SetBackdropColor(r, g, b, db.abAlpha or 1)
		end
	end
end

function mod:PetShadows()
	-- Pet Buttons
	for i = 1, NUM_PET_ACTION_SLOTS do
		local petButtons = {_G['PetActionButton'..i]}
		for _, button in pairs(petButtons) do
			if button.backdrop then
				if BUI.ShadowMode then
					if not button.backdrop.shadow then
						button.backdrop:CreateSoftShadow()
					end
				end
			end
		end
	end
end

function mod:TotemShadows()
	if not BUI.ShadowMode then return end

	for i=1, MAX_TOTEMS do
		local button = _G["ElvUI_TotemBarTotem"..i];
		if button then
			if not button.shadow then
				button:CreateSoftShadow()
			end
		end
	end
end

function mod:ApplyFlyoutShadows(btn)
	if not btn.shadow then
		btn:CreateSoftShadow()
	end
end

function mod:FlyoutShadows()
	local btn, i = _G['SpellFlyoutButton1'], 1
	while btn do
		mod:ApplyFlyoutShadows(btn)

		i = i + 1
		btn = _G['SpellFlyoutButton'..i]
	end
end

function mod:ExtraAB() -- shadows
	hooksecurefunc(_G.ZoneAbilityFrame, "UpdateDisplayedZoneAbilities", function(button)
		for spellButton in button.SpellButtonContainer:EnumerateActive() do
			if spellButton and not spellButton.hasShadow then
				spellButton.backdrop:CreateSoftShadow()
				spellButton.hasShadow = true
			end
		end
	end)

	if E.private.skins.cleanBossButton ~= true then return end
	for i = 1, _G.ExtraActionBarFrame:GetNumChildren() do
		local button = _G["ExtraActionButton"..i]
		if button then
			button.backdrop:CreateSoftShadow()
		end
	end
end

local function VehicleExit()
	if E.private.actionbar.enable ~= true then
		return
	end
	local f = _G.MainMenuBarVehicleLeaveButton
	f:SetNormalTexture("Interface\\AddOns\\ElvUI_BenikUI\\media\\textures\\flightMode\\arrow")
	f:SetPushedTexture("Interface\\AddOns\\ElvUI_BenikUI\\media\\textures\\flightMode\\arrow")
	f:SetHighlightTexture("Interface\\AddOns\\ElvUI_BenikUI\\media\\textures\\flightMode\\arrow")
	if MasqueGroup and E.private.actionbar.masque.actionbars then return end
	f:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
	f:GetPushedTexture():SetTexCoord(0, 1, 0, 1)
end

function mod:Initialize()
	C_TimerAfter(1, mod.StyleBackdrops)
	C_TimerAfter(1, mod.PetShadows)
	C_TimerAfter(2, mod.ColorBackdrops)
	C_TimerAfter(2, mod.LoadToggleButtons)
	C_TimerAfter(2, mod.ToggleStyle)
	C_TimerAfter(2, mod.TotemShadows)
	VehicleExit()
	self:LoadRequestButton()
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", "ColorBackdrops");
	hooksecurefunc(BUI, "SetupColorThemes", mod.ColorBackdrops)

	if not BUI.ShadowMode then return end
	hooksecurefunc(_G.SpellFlyout, 'Show', mod.FlyoutShadows)
	mod:ExtraAB()
end

BUI:RegisterModule(mod:GetName())