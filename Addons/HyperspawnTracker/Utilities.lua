function HST:Set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

function HST:TableHasKey(table, key)
    return table[key] ~= nil
end

function HST:DumpTable(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

 function HST:PrintText(text, colorType)
    if (colorType == "warning") then
        print(HST.Color_Brand .. "[HST]: " .. HST.Color_Warning .. text)
    elseif (colorType == "critical") then
        print(HST.Color_Brand .. "[HST]: " .. HST.Color_Critical .. text)
    else
        print(HST.Color_Brand .. "[HST]: " .. HST.Color_Default .. text)
    end

end

function HST:PlaySound(fileName)
    if (HST.db.profile.sound_channel ~= "a_none") then
        local isNumber = tonumber(fileName);
        if (isNumber) then
            if (HST.db.profile.sound_channel == "b_master") then
                PlaySound(isNumber, "Master")
            elseif (HST.db.profile.sound_channel == "c_sound") then
                PlaySound(isNumber)
            end
        else
            if (HST.db.profile.sound_channel == "b_master") then
                PlaySoundFile(fileName, "Master")
            elseif (HST.db.profile.sound_channel == "c_sound") then
                PlaySoundFile(fileName)
            end
        end
    end
end

function HST:CommaSeparatedNum(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

function HST:PlayerSentMessage(sender)
    -- Since \b and alike doesnt exist: use "frontier pattern": %f[%A]
    return string.match(sender, GetUnitName("player") .. "%f[%A]") ~= nil;
end


HST.TTM_ID_Horde = 61447 -- TTM = Traveler's Tundra Mammoth Horde
HST.TTM_ID_Alliance = 61425 -- TTM = Traveler's Tundra Mammoth Alliance 
HST.GEY_ID = 122708 -- GEY = Grand Expedition Yak
HST.Jeeves_ID = 49040 -- Jeeves
HST.MCB_ID = 264058 -- Mighty Caravan Brutosaur
HST.ME_ID = 40768 -- Moll-e
HST.SW_ID = 261602 -- Stampwhistle
HST.VendorList = HST:Set { HST.TTM_ID_Horde, HST.TTM_ID_Alliance, HST.GEY_ID, HST.Jeeves_ID, HST.MCB_ID };
HST.AuctionHouseList = HST:Set { HST.MCB_ID };
HST.MailboxList = HST:Set { HST.ME_ID, HST.SW_ID };

HST.Announcement_OxStatueWarningTime = 75

HST.SessionPromptString = "[Hyperspawn Tracker]-SessionStart";
HST.BroadcastCooldown = 60;


---- Color Variables----
HST.Color_Brand = "|c00FFA500";
HST.Color_Warning = "|c00ffff00";
HST.Color_Critical = "|c00ff0000";
HST.Color_Default = "|c00ffffff";
HST.Color_EpicQuality = "|c00a335ee";
HST.Color_White = "|c00ffffff";

---- UI Constants ----
HST.FontSize = 14;
HST.LeftPadding = 10;
HST.LineHeight = 20;
HST.TopPadding = 10;