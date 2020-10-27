NarciTooltipMixin = {};

local TP = NarciTooltipMixin;
local GetMouseFocus = GetMouseFocus;
local IsMouseButtonDown = IsMouseButtonDown;
local max = math.max;
local sin = math.sin;
local pi = math.pi;
local After = C_Timer.After;
-----------------------------------
local tooltipAnchor, pointerOffsetX, pointerOffsetY, isHorizontal;
local pendingText, pendingTexture;
local callbackFunc;
local MIN_SIZE = 48;
local TEXT_PADDING = 18;
local DEFAULT_DELAY = 0.6;
local DEFAULT_POINTER_OFFSET = -8;
local FIXED_WIDTH = 270;
local delayDuration = 0.6;
-----------------------------------

local PATH_PREFIX = "Interface/AddOns/Narcissus/Guide/IMG/";
local Images = {
    [1] =  PATH_PREFIX .. "HideTexts",
    [2] =  PATH_PREFIX .. "TopQuality",
    [3] =  PATH_PREFIX .. "GroundShadow",
    [4] =  PATH_PREFIX .. "HidePlayer",
    [5] =  PATH_PREFIX .. "CompactMode",
    [6] =  PATH_PREFIX .. "SaveLayers",
    [7] =  PATH_PREFIX .. "LightSwitch",
}


-----------------------------------
local AutoClose = CreateFrame("Frame");
AutoClose:Hide();

local Timer = CreateFrame("Frame");

Timer:Hide();
Timer.t = 0;

local function FadeInTooltip()
    local tooltip = NarciTooltip;
    tooltip:Hide();
    
    if not (tooltipAnchor and tooltipAnchor == GetMouseFocus()) then return; end;
    callbackFunc(); --Set texts
    tooltip.Pointer:ClearAllPoints();
    tooltip:ClearAllPoints();
    
    if not tooltip.UseCustomScale then
        tooltip:SetScale(tooltipAnchor:GetEffectiveScale());
    end

    local offsetX = pointerOffsetX or 0;
    local offsetY = pointerOffsetY or DEFAULT_POINTER_OFFSET;

    if isHorizontal then
        tooltip:SetPoint("RIGHT", tooltipAnchor, "LEFT", offsetX, offsetY);
        tooltip.Pointer2:SetPoint("CENTER", tooltipAnchor, "LEFT", offsetX - 12);
        tooltip.Pointer2:Show();
        tooltip.Pointer:Hide();
    else
        tooltip:SetPoint("BOTTOM", tooltipAnchor, "TOP", offsetX, offsetY);
        tooltip.Pointer:SetPoint("CENTER", tooltipAnchor, "TOP", offsetX, offsetY + 12);
        tooltip.Pointer:Show();
        tooltip.Pointer2:Hide();
    end
    
    After(0, function()
        tooltip:FadeIn(0.12);
    end);
end

local function DelayedEntrance(self, elapsed)
    if IsMouseButtonDown("LeftButton") then
        self:Hide();
        return;
    end

    self.t = self.t + elapsed;
    if self.t >= delayDuration then
        self:Hide();
        FadeInTooltip();
    end
end

Timer:SetScript("OnUpdate", DelayedEntrance);

Timer:SetScript("OnShow", function()
    AutoClose:Show();
end);

Timer:SetScript("OnHide", function(self)
    self.t = 0;
end)

local function SetSingleLine()
    local tooltip = NarciTooltip;
    tooltip.IsSignleLine = true;
    local tex = pendingTexture;
    tooltip.Icon:Hide();
    local TextObject = tooltip.Text0;
    TextObject:SetSize(0, 0);
    TextObject:Show();
    TextObject:SetText(pendingText);
    tooltip.Guide:SetAlpha(0);
end

local function SetMultiLines()
    local tooltip = NarciTooltip;
    tooltip.IsSignleLine = false;
    local tex = pendingTexture;
    tooltip.Icon:SetTexture(tex[1]);
    tooltip.Icon:SetTexCoord(tex[2], tex[3], tex[4], tex[5], tex[6], tex[7], tex[8], tex[9]);
    tooltip.Icon:Show();
    tooltip.Header:Show();
    tooltip.Text1:Show();
    tooltip.Header:SetText(pendingText[1]);
    tooltip.Text1:SetText(pendingText[2]);
    local index = tooltip.GuideIndex;
    if index then
        if Images[index] then
            tooltip.Guide.Picture:SetTexture(Images[index]);
            tooltip.Guide:SetAlpha(1);
        else
            tooltip.Guide:SetAlpha(0);
        end
    else
        tooltip.Guide:SetAlpha(0);
    end
end

local function GetIconFile(anchorFrame)
    local texureObject = anchorFrame.icon or anchorFrame.Icon;
    local texs = {};
    if texureObject then
        local texFile = texureObject:GetTexture();
        local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy = texureObject:GetTexCoord();
        texs = {texFile, ULx, ULy, LLx, LLy, URx, URy, LRx, LRy};
    else
        texs = {nil, 0, 0, 0, 0, 0, 0, 0, 0};
    end
    return texs;
end

AutoClose:SetScript("OnShow", function(self)
    self:RegisterEvent("GLOBAL_MOUSE_DOWN");
end)

AutoClose:SetScript("OnHide", function(self)
    self:UnregisterEvent("GLOBAL_MOUSE_DOWN");
end)

AutoClose:SetScript("OnEvent", function(self)
    self:Hide();
    Timer:Hide();
    NarciTooltip:FadeOut(0.15);
end)
-----------------------------------
function TP:OnHide()
    AutoClose:Hide();
    Timer:Hide();
    self:ClearAllPoints();
    self.Pointer:ClearAllPoints();
    self:Hide();
    self:SetAlpha(0);
    self.Text0:Hide();
    self.Header:Hide();
    self.Text1:Hide();
    self.Icon:Hide();
end

function TP:OnLoad()
    self.IsSignleLine = true;
    self.Scale = 1;
    local animFade = NarciAPI_CreateFadingFrame(self);
end

function TP:OnSizeChanged(width, height)
    self:SetSize(max(MIN_SIZE, width), max(MIN_SIZE, height));
    local insetHeight = self.inset:GetHeight();
    self.Icon:SetSize(insetHeight, insetHeight);
end

function TP:OnShow()
    AutoClose:Show();
    if self.IsSignleLine then
        local textWidth, textHeight = self.Text0:GetSize();
        self:SetSize(textWidth + 2*TEXT_PADDING, textHeight + 2*TEXT_PADDING);
    else
        self:SetWidth(FIXED_WIDTH);
        self.Guide:SetHeight(FIXED_WIDTH / 2 + 12);
        local height = (self.Header:GetHeight() + self.Text1:GetHeight() + 2 * (TEXT_PADDING - 6) + 24 + 4 + 1);
        self:SetHeight(height);
    end
end


function TP:JustHide()
    self:Hide();
    self:SetAlpha(0);
    Timer:Hide();
end

function TP:NewText(texts, offsetX, offsetY, delay, horizontal)
    Timer:Hide();
    tooltipAnchor = GetMouseFocus();
    if not tooltipAnchor or tooltipAnchor == WorldFrame or not texts then return; end;
    pointerOffsetX, pointerOffsetY = offsetX, offsetY;
    delayDuration = delay or DEFAULT_DELAY;
    isHorizontal = horizontal;
    pendingText = texts;
    pendingTexture = GetIconFile(tooltipAnchor);
    self.GuideIndex = tooltipAnchor.GuideIndex;
    After(0, function()
        Timer:Show();
        if type(texts) == "string" then
            callbackFunc = SetSingleLine;
        elseif type(texts) == "table" then
            callbackFunc = SetMultiLines;
        end
    end)
end

function TP:ShowTooltip(frame, offsetX, offsetY, delay)
    self:NewText(frame.tooltip, offsetX, offsetY, delay);
end

function TP:SetColorTheme(index)
    local minG, maxG;

    if index and index ==  1 then
        --Bright
        minG, maxG = 0.82, 1.0;
        self.Pointer:SetTexCoord(0, 0.5, 0, 1);
        self.Pointer2:SetTexCoord(0, 1, 0, 0.5);
        self.Text0:SetTextColor(0, 0, 0);
        self.Text0:SetShadowColor(1, 1, 1, 0);
        self.Text1:SetTextColor(0, 0, 0);
        self.Text1:SetShadowColor(1, 1, 1, 0);
        self.Header:SetTextColor(0, 0, 0);
        self.Header:SetShadowColor(1, 1, 1, 0);
        self.Icon:SetAlpha(0.2);
    else
        --Dark
        minG, maxG = 0.05, 0.12;
        self.Pointer:SetTexCoord(0.5, 1, 0, 1);
        self.Pointer2:SetTexCoord(0, 1, 0.5, 1);
        self.Text0:SetTextColor(1, 1, 1);
        self.Text0:SetShadowColor(0, 0, 0, 0);
        self.Text1:SetTextColor(1, 1, 1);
        self.Text1:SetShadowColor(0, 0, 0, 1);
        self.Header:SetTextColor(0.25, 0.78, 0.92);
        self.Header:SetShadowColor(0, 0, 0);
        self.Icon:SetAlpha(0.1);
    end

    self.Gradient:SetGradient("VERTICAL", minG, minG, minG, maxG, maxG, maxG);
end

function TP:SetCustomScale(scale)
    if scale then
        --set scale manually
        self.UseCustomScale = true;
        self:SetScale(scale);
    else
        --use anchor frame's scale
        self.UseCustomScale = false;
    end
end


--[[
/run NarciTooltip:SetColorTheme(2);NarciTooltip:NewText({NARCI_DRESSING_ROOM, NARCI_DRESSING_ROOM_DESCRIPTION})
/run NarciTooltip:SetSize(160,140)
--]]