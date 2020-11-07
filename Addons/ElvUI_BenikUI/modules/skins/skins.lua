local BUI, E, L, V, P, G = unpack(select(2, ...))
local mod = BUI:GetModule('Skins')
local S = E:GetModule('Skins')

local classColor = E:ClassColor(E.myclass, true)
local CloseButton = 'Interface\\AddOns\\ElvUI_BenikUI\\media\\textures\\Close.tga'

function mod:HandleCloseButton(f)
	if f.Texture then
		f.Texture:SetTexture(CloseButton)
		f.Texture:SetVertexColor(1, 1, 1)
	end

	f:HookScript('OnEnter', function(self)
		if E.myclass == 'PRIEST' then
			self.Texture:SetVertexColor(unpack(E["media"].rgbvaluecolor))
		else
			self.Texture:SetVertexColor(classColor.r, classColor.g, classColor.b)
		end
	end)

	f:HookScript('OnLeave', function(self)
		self.Texture:SetVertexColor(1, 1, 1)
	end)
end
hooksecurefunc(S, "HandleCloseButton", mod.HandleCloseButton)

function mod:HandleButton(button, _, isDeclineButton)
	if button.isEdited then return end
	assert(button, "doesn't exist!")

	-- replace the white X letter on decline buttons
	if isDeclineButton then
		if button.Icon then
			button.Icon:SetTexture(CloseButton)
			button.Icon:Size(12, 12)
			button.Icon:Point("CENTER")
		end
	end

	button.isEdited = true
end
hooksecurefunc(S, "HandleButton", mod.HandleButton)

local function Style_Ace3TabSelected(self, selected)
	local bd = self.backdrop
	if not bd then return end

	if selected then
		bd:SetBackdropBorderColor(0, 0, 0)
	else
		local r, g, b = unpack(E.media.bordercolor)
		bd:SetBackdropBorderColor(r, g, b, 1)
	end
end
hooksecurefunc(S, 'Ace3_TabSetSelected', Style_Ace3TabSelected)

local function Style_SetButtonColor(self, btn, disabled)
	btn.dontReskin = true

	if disabled then
		local r, g, b = unpack(E.media.rgbvaluecolor)
		btn:SetBackdropBorderColor(r, g, b)
		btn:SetBackdropColor(r, g, b, 0.5)
		btn.Text:SetTextColor(1, 1, 1)
	else
		btn:SetBackdropColor(0, 0, 0, .5)
		local r, g, b = unpack(E.media.bordercolor)
		btn:SetBackdropBorderColor(r, g, b, 1)
		btn.Text:SetTextColor(.9, .8, 0)
	end
end
hooksecurefunc(E, 'Config_SetButtonColor', Style_SetButtonColor)

function mod:Initialize()
	if E.db.benikui.general.benikuiStyle ~= true then return end

	mod:SkinStoryline()
end

BUI:RegisterModule(mod:GetName())