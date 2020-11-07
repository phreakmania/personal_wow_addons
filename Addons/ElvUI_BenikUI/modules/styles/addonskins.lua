local BUI, E, L, V, P, G = unpack(select(2, ...))

local _G = _G
local unpack = unpack

local CreateFrame = CreateFrame

-- GLOBALS: hooksecurefunc, Skada, Recount, oRA3, RC, RCnotify, RCminimized

if not BUI.AS then return end
local AS = unpack(AddOnSkins)

local classColor = E:ClassColor(E.myclass, true)

local function SkadaDecor()
	if not E.db.benikui.general.benikuiStyle or not E.db.benikuiSkins.addonSkins.skada then return end
	hooksecurefunc(Skada.displays['bar'], 'ApplySettings', function(self, win)
		local skada = win.bargroup
		skada.Backdrop:Style('Outside')
		if win.db.enabletitle then
			skada.button:StripTextures()
		end
		if not skada.Backdrop.ishooked then
			hooksecurefunc(AS, 'Embed_Check', function(self, message)
				if skada.Backdrop.style then
					if AS.db.EmbedSystem and AS.db.EmbedSkada then
						skada.Backdrop.style:Hide()
					else
						skada.Backdrop.style:Show()
					end
				end
			end)
			skada.Backdrop.ishooked = true
		end
	end)
end

local function StyleRecount(name, parent, ...)
	if E.db.benikui.general.benikuiStyle ~= true then return end
	local recountdecor = CreateFrame('Frame', name, E.UIParent, 'BackdropTemplate')
	recountdecor:SetTemplate('Default', true)
	recountdecor:SetParent(parent)
	recountdecor:Point('TOPLEFT', parent, 'TOPLEFT', 0, -2)
	recountdecor:Point('BOTTOMRIGHT', parent, 'TOPRIGHT', 0, -7)

	return recountdecor
end

local function RecountDecor()
	if not E.db.benikuiSkins.addonSkins.recount then return end
	StyleRecount('recountMain', _G["Recount_MainWindow"])
	_G["Recount_MainWindow"].TitleBackground:StripTextures()
	_G["Recount_ConfigWindow"].TitleBackground:StripTextures()
	_G["Recount_DetailWindow"].TitleBackground:StripTextures()
	StyleRecount(nil, _G["Recount_DetailWindow"])
	StyleRecount(nil, _G["Recount_ConfigWindow"])
	hooksecurefunc(Recount, 'ShowReport', function(self)
		if _G["Recount_ReportWindow"].TitleBackground then
			_G["Recount_ReportWindow"].TitleBackground:StripTextures()
			StyleRecount(nil, _G["Recount_ReportWindow"])
		end
	end)

	hooksecurefunc(AS, 'Embed_Check', function(self, message)
		-- Fix for blurry pixel fonts
		Recount.db.profile.Scaling = 0.95
		if E.db.benikui.general.benikuiStyle ~= true then return end
		if AS.db.EmbedSystem then
			_G["recountMain"]:Hide()
		else
			_G["recountMain"]:Show()
		end
	end)
end

local function TinyDPSDecor()
	if not E.db.benikui.general.benikuiStyle or not E.db.benikuiSkins.addonSkins.tinydps then return end
	if _G["tdpsFrame"] then
		if not _G["tdpsFrame"].style then
			_G["tdpsFrame"]:Style('Outside')
		end
	end
end

local function AtlasLootDecor()
	if not E.db.benikui.general.benikuiStyle or not E.db.benikuiSkins.addonSkins.atlasloot then return end
	local AtlasLootFrame = _G["AtlasLoot_GUI-Frame"]
	if AtlasLootFrame then
		if not AtlasLootFrame.style then
			AtlasLootFrame:Style('Outside')
		end
	end
end

local function AltoholicDecor()
	if not E.db.benikui.general.benikuiStyle or not E.db.benikuiSkins.addonSkins.altoholic then return end
	if _G["AltoholicFrame"] then
		if not _G["AltoholicFrame"].style then
			_G["AltoholicFrame"]:Style('Outside')
		end
	end
end

local function CliqueDecor()
	if not E.db.benikui.general.benikuiStyle or not E.db.benikuiSkins.addonSkins.clique then return end
	_G["CliqueConfig"]:Style('Small')
	_G["CliqueDialog"]:Style('Small')
	local tab = _G["CliqueSpellTab"]
	if not tab.style then
		tab:Style('Inside')
		tab.style:SetFrameLevel(5)
	end
	tab:GetNormalTexture():SetTexCoord(.08, 0.92, 0.08, 0.92)
end

local function oRA3Decor()
	if not E.db.benikui.general.benikuiStyle or not E.db.benikuiSkins.addonSkins.ora then return end
	hooksecurefunc(oRA3, "ToggleFrame", function() _G["oRA3Frame"]:Style('Small'); end)

	local ReadyCheckModule = oRA3:GetModule("ReadyCheck")
	if (ReadyCheckModule) then
		hooksecurefunc(ReadyCheckModule, "READY_CHECK", function() _G["oRA3ReadyCheck"]:Style('Small'); end)
	end
end

local function PawnDecor()
	if not E.db.benikui.general.benikuiStyle or not E.db.benikuiSkins.addonSkins.pawn then return end
	local frame = PawnUIFrame

	if not frame.style then
		frame:Style('Outside')
	end
end

local function DbmDecor(event)
	if not E.db.benikui.general.benikuiStyle or not E.db.benikuiSkins.addonSkins.dbm then return end

	local function StyleRangeFrame(self, range, filter, forceshow, redCircleNumPlayers)
		if DBM.Options.DontShowRangeFrame and not forceshow then return end

		if DBMRangeCheckRadar then
			if not DBMRangeCheckRadar.style then
				DBMRangeCheckRadar:Style('Inside')
			end

			if AS:CheckOption('DBMRadarTrans') then
				if DBMRangeCheckRadar.style and E.db.benikui.general.benikuiStyle then
					DBMRangeCheckRadar.style:Hide()
				end

				if DBMRangeCheckRadar.shadow then
					DBMRangeCheckRadar.shadow:Hide()
				end
			else
				if DBMRangeCheckRadar.style and E.db.benikui.general.benikuiStyle then
					DBMRangeCheckRadar.style:Show()
				end

				if DBMRangeCheckRadar.shadow then
					DBMRangeCheckRadar.shadow:Show()
				end
			end
		end
		
		if DBMRangeCheck then
			if not DBMRangeCheck.style then
				DBMRangeCheck:Style('Outside')
			end
		end
	end

	local function StyleInfoFrame(self, maxLines, event, ...)
		if DBM.Options.DontShowInfoFrame and (event or 0) ~= "test" then return end

		if DBMInfoFrame and not DBMInfoFrame.style then
			DBMInfoFrame:Style('Inside')
		end
	end

	hooksecurefunc(DBM.RangeCheck, 'Show', StyleRangeFrame)
	hooksecurefunc(DBM.InfoFrame, 'Show', StyleInfoFrame)
end

local function BugSackDecor()
	if not E.db.benikui.general.benikuiStyle then return end

	hooksecurefunc(BugSack, "OpenSack", function()
		if BugSackFrame.IsStyled then return end
		if not BugSackFrame.style then
			BugSackFrame:Style('Outside')
		end
		BugSackFrame.IsStyled = true
	end)
end

local function LibrariesDecor()
	local DBIcon = LibStub("LibDBIcon-1.0", true)
	if DBIcon and DBIcon.tooltip and DBIcon.tooltip:IsObjectType('GameTooltip') then
		DBIcon.tooltip:HookScript("OnShow", function(self)
			if not self.style then
				self:Style('Outside')
			end
		end)
	end
end

local function ZygorDecor()
	if not E.db.benikui.general.benikuiStyle or not E.db.benikuiSkins.addonSkins.zygor then return end

	_G['ZygorGuidesViewerFrame_Border']:Style('Outside')
end

local function ImmersionDecor()
	if not E.db.benikui.general.benikuiStyle or not E.db.benikuiSkins.addonSkins.immersion then return end
	local frame = _G['ImmersionFrame']
	frame.TalkBox.BackgroundFrame.Backdrop:Style('Inside')
	frame.TalkBox.Hilite:SetOutside(frame.TalkBox.BackgroundFrame.Backdrop)
	frame.TalkBox.Elements.Backdrop:Style('Inside')

	if BUI.ShadowMode then
		frame.TalkBox.BackgroundFrame.Backdrop.Shadow:Hide()
		frame.TalkBox.Elements.Backdrop.Shadow:Hide()
	end
	
	frame:HookScript('OnUpdate', function(self)
		for _, Button in ipairs(self.TitleButtons.Buttons) do
			if Button.Backdrop and not Button.Backdrop.isStyled then
				Button.Backdrop:Style('Inside')
				Button.Hilite:SetOutside(Button.Backdrop)
				Button.Backdrop.Shadow:Hide()
				Button.Backdrop.isStyled = true
			end
		end
	end)
end

local function AllTheThingsDecor()
	if not E.db.benikui.general.benikuiStyle or not E.db.benikuiSkins.addonSkins.allthethings then return end
	for _, Instance in pairs({ 'Prime', 'CurrentInstance' }) do
		local Window = AllTheThings:GetWindow(Instance)
		Window:Style('Outside')
	end
end

local function TinyInspectDecor()
	if not E.db.benikui.general.benikuiStyle or not E.db.benikuiSkins.addonSkins.tinyinspect then return end
	TinyInspectRaidFrame:Style('Outside') -- not tested
	TinyInspectRaidFrame.panel:Style('Outside') -- not tested

	PaperDollFrame:HookScript("OnShow", function(self)
		if self.inspectFrame then
			if not self.inspectFrame.style then
				self.inspectFrame:Style('Outside')
			end
			self.inspectFrame:SetBackdropBorderColor(unpack(E.media.bordercolor))
		end
	end)
end

local function ArkInventoryDecor()
	if not E.db.benikui.general.benikuiStyle or not E.db.benikuiSkins.addonSkins.arkinventory then return end
	hooksecurefunc(ArkInventory, 'Frame_Main_Paint', function(frame)
		if not ArkInventory.ValidFrame(frame, true) then return end
		if not frame.style then
			frame:Style('Outside')
		end
	end)
end

-- Replace the close button
function AS:SkinCloseButton(Button, Reposition)
	if Button.Backdrop then return end

	AS:SkinBackdropFrame(Button)

	Button.Backdrop:Point('TOPLEFT', 7, -8)
	Button.Backdrop:Point('BOTTOMRIGHT', -7, 8)
	Button.Backdrop:SetTemplate('NoBackdrop')

	Button:SetHitRectInsets(6, 6, 7, 7)
	
	Button.Backdrop.img = Button.Backdrop:CreateTexture(nil, 'OVERLAY')
	Button.Backdrop.img:Size(12, 12)
	Button.Backdrop.img:Point("CENTER")
	Button.Backdrop.img:SetTexture('Interface\\AddOns\\ElvUI_BenikUI\\media\\textures\\Close.tga')
	Button.Backdrop.img:SetVertexColor(1, 1, 1)

	Button:HookScript('OnEnter', function(self)
		self.Backdrop.img:SetVertexColor(1, .2, .2)
		if E.myclass == 'PRIEST' then
			self.Backdrop.img:SetVertexColor(unpack(E["media"].rgbvaluecolor))
			self.Backdrop:SetBackdropBorderColor(unpack(E["media"].rgbvaluecolor))
		else
			self.Backdrop.img:SetVertexColor(classColor.r, classColor.g, classColor.b)
			self.Backdrop:SetBackdropBorderColor(classColor.r, classColor.g, classColor.b)
		end
	end)

	Button:HookScript('OnLeave', function(self)
		self.Backdrop.img:SetVertexColor(1, 1, 1)
		self.Backdrop:SetBackdropBorderColor(unpack(E["media"].bordercolor))
	end)

	if Reposition then
		Button:Point('TOPRIGHT', Reposition, 'TOPRIGHT', 2, 2)
	end
end

if AS:CheckAddOn('Skada') then AS:RegisterSkin('Skada', SkadaDecor, 2) end
if AS:CheckAddOn('Recount') then AS:RegisterSkin('Recount', RecountDecor, 2) end
if AS:CheckAddOn('TinyDPS') then AS:RegisterSkin('TinyDPS', TinyDPSDecor, 2) end
if AS:CheckAddOn('AtlasLoot') then AS:RegisterSkin('AtlasLoot', AtlasLootDecor, 2) end
if AS:CheckAddOn('Altoholic') then AS:RegisterSkin('Altoholic', AltoholicDecor, 2) end
if AS:CheckAddOn('Clique') then AS:RegisterSkin('Clique', CliqueDecor, 2) end
if AS:CheckAddOn('oRA3') then AS:RegisterSkin('oRA3', oRA3Decor, 2) end
if AS:CheckAddOn('Pawn') then AS:RegisterSkin('Pawn', PawnDecor, 2) end
if (AS:CheckAddOn('DBM-Core') and AS:CheckAddOn('DBM-StatusBarTimers') and AS:CheckAddOn('DBM-DefaultSkin')) then AS:RegisterSkin('DBM', DbmDecor, 'ADDON_LOADED') end
if AS:CheckAddOn('BugSack') then AS:RegisterSkin('BugSack', BugSackDecor, 2) end
if AS:CheckAddOn('ZygorGuidesViewer') then AS:RegisterSkin('Zygor', ZygorDecor, 2) end
if AS:CheckAddOn('Immersion') then AS:RegisterSkin('Immersion', ImmersionDecor, 2) end
if AS:CheckAddOn('AllTheThings') then AS:RegisterSkin('AllTheThings', AllTheThingsDecor, 2) end
if AS:CheckAddOn('TinyInspect') then AS:RegisterSkin('TinyInspect', TinyInspectDecor, 2) end
if AS:CheckAddOn('ArkInventory') then AS:RegisterSkin('ArkInventory', ArkInventoryDecor, 2) end
LibrariesDecor()

hooksecurefunc(AS, 'AcceptFrame', function(self)
	if not _G["AcceptFrame"].style then
		_G["AcceptFrame"]:Style('Outside')
	end
end)