local cos = math.cos;
local sin = math.sin;
local sqrt = math.sqrt;
local floor = math.floor;
local pow = math.pow;
local abs = math.abs;
local PI = math.pi;
local function outSine(t, b, c, d)
	return c * sin(t / d * (PI / 2)) + b
end

local AR = CreateFrame("Frame", "NarciAR");
local TurningFrame = CreateFrame("Frame", nil, NarciAR);
NarciAR.Turning = TurningFrame;
TurningFrame:Hide();

AR:SetScript("OnHide", function(self)
    self.Turning:Hide();
end)

local GetFacing = GetPlayerFacing;
if not GetFacing then return; end;

local VirtualLineRight = Narci_VirtualLineRight;
local VirtualLineLeft = Narci_VirtualLineLeft;
local _, _, _, rightBase = VirtualLineRight:GetPoint();
local _, _, _, leftBase = VirtualLineLeft:GetPoint();

local function UpdateReferenceLine(offset)
    local ScaledOffset = offset * 5;    --Strengh
    VirtualLineRight:ClearAllPoints();
    VirtualLineRight:SetPoint("RIGHT", rightBase + ScaledOffset, 0);
    VirtualLineLeft:ClearAllPoints();
    VirtualLineLeft:SetPoint("LEFT", leftBase + ScaledOffset, 0);
end

local VLUF = CreateFrame("Frame", nil, NarciAR);    --VirtualLineUpdateFrame
NarciAR.VirtualLineUpdateFrame = VLUF;
VLUF:Hide();

local function VLUF_OnLoad(self)
    self.TimeSinceLastUpdate = 0;
    self.duration = 0.25;
end

local function VLUF_OnShow(self)
    self.TimeSinceLastUpdate = 0;
    if TurningFrame.offset == 0 then
        self:Hide();
        return;
    end;
    self.duration = math.max(0.1, sqrt(abs(TurningFrame.offset /10)) );
    --print(TurningFrame.offset);
end

local function VLUF_OnUpdate(self, elapsed)
	local startOffset = TurningFrame.offset;
    local offset = outSine(self.TimeSinceLastUpdate, startOffset, 0 - startOffset, self.duration);
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if self.TimeSinceLastUpdate >= self.duration then
        offset = 0;
        self:Hide();
    end
    UpdateReferenceLine(offset);
    TurningFrame.offset = offset;
end

VLUF:SetScript("OnLoad", VLUF_OnLoad);
VLUF:SetScript("OnUpdate", VLUF_OnUpdate);
VLUF:SetScript("OnShow", VLUF_OnShow);

TurningFrame.velocity = 0;
TurningFrame.radian = 0;
TurningFrame.diff = 0;
TurningFrame.offset = 0;
TurningFrame.threshhold = 20;

local function Turning_OnUpdate(self, elapsed)
    local radian = GetFacing();
    if not radian then return; end;
    local diff = radian - self.radian;
    self.radian = radian;
    --if diff ~= 0 then print(diff); end
    if diff > PI then
        diff = -2*PI + diff;
    elseif diff < - PI then
        diff = 2*PI + diff;

    end
    self.offset = self.offset + diff;

    local velocity = (diff) / elapsed;
    local acceleration = (velocity - self.velocity) / elapsed;
    self.velocity = velocity;
    
    UpdateReferenceLine(self.offset);
    if acceleration < self.threshhold and acceleration > -self.threshhold then
        --acceleration < 1 and acceleration ~=0 and acceleration > -1
        if self.offset ~=0 then
            VLUF:Show();
        end
    else
        VLUF:Hide();
    end
end

local function Turning_OnHide(self)
    --UpdateReferenceLine(0);
    VLUF:Show();
end

local function Turning_OnShow(self)
    VLUF:Hide();
end

TurningFrame:SetScript("OnUpdate", Turning_OnUpdate);
TurningFrame:SetScript("OnHide", Turning_OnHide);
TurningFrame:SetScript("OnShow", Turning_OnShow);
--[[
local function CalculateScale(zoom)
    return -0.1486*pow(zoom, 3) + 3.7573*pow(zoom, 2) - 32.864*zoom + 112.36
end

NarciARMixin = {};
function CreateNarciAR(x, y)
	local vector = CreateFromMixins(NarciARMixin);
	vector:OnLoad(x, y);
	return vector;
end

function NarciARMixin:OnLoad(x, y)
    self.x = x;
    self.y = y;
    self.scale = 1;
    self.SetScale = SetScale;
    self.SetPoint = SetPoint;
end

function NarciARMixin:UpdateScale(scale)
    self:SetScale(scale)
    self:SetPoint("CENTER", nil, self.x * scale, self.y * scale);
end

local function UpdateScale(frame, scale)
    if scale <= 0 then return; end
    frame:SetScale(scale)
    frame:SetPoint("CENTER", nil, frame.x * sqrt(scale), frame.y * sqrt(scale));
end

--NarciAR = CreateNarciAR(-50, 50);

local function LoadFrame(frame, x, y)
    if not frame then return; end
    frame.x = x;
    frame.y = y;
end

local initialize = CreateFrame("Frame")
initialize:RegisterEvent("VARIABLES_LOADED");
initialize:SetScript("OnEvent",function(self,event,...)
    LoadFrame(NarciAR, 0, 40);
end)


local ARFrame = CreateFrame("Frame", "NarciAR_UpdateFrame")
ARFrame:Hide()
ARFrame.TimeSinceLastUpdate = 0;
ARFrame.TotalTime = 0;
local ZoomLevel, ScaleLevel;
local function ARFrame_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed
    ZoomLevel = GetCameraZoom()
    ScaleLevel= CalculateScale(ZoomLevel)/20
    UpdateScale(NarciAR, ScaleLevel)
	if self.TimeSinceLastUpdate >= 2 then
		self:Hide();
	end

end

local function ARFrame_OnHide(self)
    self.TimeSinceLastUpdate = 0;
end

ARFrame:SetScript("OnUpdate", ARFrame_OnUpdate)
ARFrame:SetScript("OnHide", ARFrame_OnHide)

hooksecurefunc("CameraZoomIn", function(increment)
    ARFrame.TimeSinceLastUpdate = 0;
    ARFrame:Show();
end)

hooksecurefunc("CameraZoomOut", function(increment)
    ARFrame.TimeSinceLastUpdate = 0;
    ARFrame:Show();
end)

hooksecurefunc("MoveViewInStart", function()
    print("View In")
end)

function NarciAR_MeasurementSlider_OnValueChanged(self, value, userInput)
    self.VirtualThumb:SetPoint("CENTER", self.Thumb, "CENTER", 0, 0)
    if value ~= self.oldValue then
        self.oldValue = value
        self.KeyLabel:SetText(floor(value*100 + 0.5)/100)
    end
end
--]]