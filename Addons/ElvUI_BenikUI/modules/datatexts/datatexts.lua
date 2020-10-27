local BUI, E, L, V, P, G = unpack(select(2, ...))
local DT = E:GetModule('DataTexts')
local mod = BUI:GetModule('DataTexts')

function mod:BuildPanelFrame(name)
	local Panel = DT:FetchFrame(name)
	Panel:Style('Outside')
end

function mod:UpdatePanelInfo(panelName, panel)
	if not panel then panel = DT.RegisteredPanels[panelName] end
	local db = panel.db or P.datatexts.panels[panelName] and DT.db.panels[panelName]
	if not db then return end

	if not (panel == _G.LocPlusLeftDT or panel == _G.LocPlusRightDT or panel == _G.MinimapPanel or panel == _G.LeftChatDataPanel or panel == _G.RightChatDataPanel) then
		panel:Style('Outside')
		if panel.style then
			if db.benikuiStyle then
				panel.style:Show()
			else
				panel.style:Hide()
			end
		end

		if BUI.ShadowMode then
			if not (db.border and db.backdrop or db.backdrop) then
				panel.shadow:Hide()
			else
				panel.shadow:Show()
			end
		end
	end
end

function mod:SetupTooltip()
	DT.tooltip:Style('Outside')
end

function mod:Initialize()
	hooksecurefunc(DT, "BuildPanelFrame", mod.BuildPanelFrame)
	hooksecurefunc(DT, "UpdatePanelInfo", mod.UpdatePanelInfo)
	hooksecurefunc(DT, "SetupTooltip", mod.SetupTooltip)
end

BUI:RegisterModule(mod:GetName())
