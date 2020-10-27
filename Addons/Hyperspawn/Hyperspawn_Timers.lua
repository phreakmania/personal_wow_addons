
-------------------
-- Create Frames --
-------------------

Hyperspawn_Timer_Event = CreateFrame("Frame");

---------------
-- Functions --
---------------

function Hyperspawn_Timer_OnEvent(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
	-- Loot Timer
		StopwatchFrame:Hide()
-- Loot Timer
	elseif event == "LOOT_CLOSED" then
		if LT_TI_CB:GetChecked() == true then
			StopwatchFrame:Show()
			Stopwatch_StartCountdown(0, 2, 0)
			Stopwatch_Play()
		end
	end
end

function Hyperspawn_Timer_OnClick()
-- Loot Timer
	LT_TI_CB:SetScript("OnClick", function(self)
	StopwatchFrame:Hide()
	end)
end

---------------------
-- Register Events --
---------------------

Hyperspawn_Timer_Event:RegisterEvent("LOOT_CLOSED");
Hyperspawn_Timer_Event:RegisterEvent("PLAYER_ENTERING_WORLD");

-----------------
-- Set Scripts --
-----------------

Hyperspawn_Timer_Event:SetScript("OnEvent", Hyperspawn_Timer_OnEvent)