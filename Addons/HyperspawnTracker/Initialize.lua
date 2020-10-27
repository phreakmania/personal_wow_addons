HST = LibStub("AceAddon-3.0"):NewAddon("HyperspawnTracker", "AceConsole-3.0", "AceEvent-3.0")

local options = {
    name = "Hyperspawn Tracker",
    handler = HST,
    type = 'group',
    args = {
        general_group = {
            type = "group",
            name = "General",
            inline = true,
            order = 1,
            args = {
                sound_channel = {
                    type = 'select',
                    order = 1,
                    name = "Sound Channel",
                    desc = "Selects what channel the sound should play through",
                    values = {
                        a_none = "None",
                        b_master = "Master",
                        c_sound = "Sound"
                    },
                    set = function(info, val)
                        HST.db.profile.sound_channel = val
                    end,
                    get = function(info)
                        return HST.db.profile.sound_channel
                    end
                },
                general_SessionPrompt = {
                    type = 'toggle',
                    order = 6,
                    name = "Session Prompt",
                    desc = "Enables automatic prompts for when you or your party start a new session. (Only triggers while in a party)",
                    set = function(info, val)
                        HST.db.profile.general_SessionPrompt = val
                    end,
                    get = function(info)
                        return HST.db.profile.general_SessionPrompt
                    end
                }
            }
        },

        lootTimer_group = {
            type = "group",
            name = "Loot Timer",
            inline = true,
            order = 2,
            args = {
                lootTimer_enabled = {
                    type = 'toggle',
                    order = 1,
                    name = "Enable (2 min)",
                    desc = "A loot timer that tracks when corpses will disappear. (2 minutes)",
                    set = function(info, val)
                        local row = 3
                        if (val) then
                            row = 4
                            HST.Label_LootTimer:Show();
                        else
                            HST.Label_LootTimer:Hide();
                        end
                        HST.Label_EpicLootTimer:SetPoint("TOPLEFT", HST.LeftPadding, -HST.TopPadding + (row * (-HST.LineHeight)))
                        HST.db.profile.lootTimer_enabled = val
                    end,
                    get = function(info)
                        return HST.db.profile.lootTimer_enabled
                    end
                },
                lootTimer_enableEpicTimer = {
                    type = 'toggle',
                    order = 2,
                    name = "Enable (15 min)",
                    desc = "A loot timer that tracks when corpses will disappear that have an epic drop. (15 minutes)",
                    set = function(info, val)
                        HST.db.profile.lootTimer_enableEpicTimer = val
                    end,
                    get = function(info)
                        return HST.db.profile.lootTimer_enableEpicTimer
                    end
                },
                lootTimer_audioAlerts = {
                    type = 'multiselect',
                    order = 3,
                    name = "Audio Alerts",
                    desc = "Selects which audio alerts to enable for the loot timer.",
                    values = {
                        thirtysec = "30 Second Alert",
                        fivesec = "5 Second Countdown",
                        expired = "Expired Alert"
                    },
                    set = function(info, nodeIndex, state)
                        HST.db.profile.lootTimer_audioAlerts[nodeIndex] = state
                    end,
                    get = function(info, nodeIndex)
                        return HST.db.profile.lootTimer_audioAlerts[nodeIndex]
                    end
                },
                lootTimer_chatAlerts = {
                    type = 'multiselect',
                    order = 4,
                    name = "Chat Alerts",
                    desc = "Selects which chat alerts to enable for the loot timer.",
                    values = {
                        thirtysec = "30 Second Alert",
                        fivesec = "5 Second Countdown",
                        expired = "Expired Alert"
                    },
                    set = function(info, nodeIndex, state)
                        HST.db.profile.lootTimer_chatAlerts[nodeIndex] = state
                    end,
                    get = function(info, nodeIndex)
                        return HST.db.profile.lootTimer_chatAlerts[nodeIndex]
                    end
                }
            }
        },
        group_blackOx = {
            type = "group",
            name = "Black Ox Statue (Requires Brewmaster)",
            inline = true,
            order = 3,
            args = {
                blackOx_ExpireAlert = {
                    type = 'toggle',
                    order = 1,
                    name = "Expiration Alert",
                    desc = "Alerts you when your black ox statue is about to expire.",
                    set = function(info, val)
                        HST.db.profile.blackOx_ExpireAlert = val
                    end,
                    get = function(info)
                        return HST.db.profile.blackOx_ExpireAlert
                    end
                },
                blackOx_RaidTarget = {
                    type = 'toggle',
                    order = 2,
                    name = "Raid Target Icon",
                    desc = "Automatically sets a raid target icon on your black ox statue.",
                    set = function(info, val)
                        HST.db.profile.blackOx_RaidTarget = val
                    end,
                    get = function(info)
                        return HST.db.profile.blackOx_RaidTarget
                    end
                }
            }
        },
        group_personalAlerts = {
            type = "group",
            name = "Personal Alerts",
            inline = true,
            order = 4,
            args = {
                personalAlert_GroupSize = {
                    type = 'toggle',
                    order = 1,
                    name = "Group Size",
                    desc = "Alerts you when your group size is over 4 members.",
                    set = function(info, val)
                        HST.db.profile.personalAlert_GroupSize = val
                    end,
                    get = function(info)
                        return HST.db.profile.personalAlert_GroupSize
                    end
                },
                personalAlert_BagSpace = {
                    type = 'toggle',
                    order = 2,
                    name = "Bag Space",
                    desc = "Alerts you when your bag space is nearing full. (5 spaces remaining)",
                    set = function(info, val)
                        HST.db.profile.personalAlert_BagSpace = val
                    end,
                    get = function(info)
                        return HST.db.profile.personalAlert_BagSpace
                    end
                },
            }
        },
        group_publicAlerts = {
            type = "group",
            name = "Public Alerts",
            inline = true,
            order = 5,
            args = {
                publicAlert_Vendor = {
                    type = 'toggle',
                    order = 1,
                    name = "Vendor",
                    desc = "Announces when you summon a vendor.",
                    set = function(info, val)
                        HST.db.profile.publicAlert_Vendor = val
                    end,
                    get = function(info)
                        return HST.db.profile.publicAlert_Vendor
                    end
                },
                publicAlert_MailBox = {
                    type = 'toggle',
                    order = 2,
                    name = "Mailbox",
                    desc = "Announces when you summon a mailbox.",
                    set = function(info, val)
                        HST.db.profile.publicAlert_MailBox = val
                    end,
                    get = function(info)
                        return HST.db.profile.publicAlert_MailBox
                    end
                },
                publicAlert_AuctionHouse = {
                    type = 'toggle',
                    order = 3,
                    name = "Auction House",
                    desc = "Announces when you summon an auction house.",
                    set = function(info, val)
                        HST.db.profile.publicAlert_AuctionHouse = val
                    end,
                    get = function(info)
                        return HST.db.profile.publicAlert_AuctionHouse
                    end
                },
                publicAlert_TappedMob = {
                    type = 'toggle',
                    order = 4,
                    name = "Tapped Mob",
                    desc = "Announces when a tapped (gray) mob is detected.",
                    set = function(info, val)
                        HST.db.profile.publicAlert_TappedMob = val
                    end,
                    get = function(info)
                        return HST.db.profile.publicAlert_TappedMob
                    end
                },
                publicAlert_LootedEpic = {
                    type = 'toggle',
                    order = 5,
                    name = "Epic Looted",
                    desc = "Announces when an epic item is looted.",
                    set = function(info, val)
                        HST.db.profile.publicAlert_LootedEpic = val
                    end,
                    get = function(info)
                        return HST.db.profile.publicAlert_LootedEpic
                    end
                },

            }
        }
    }
}

local defaults = {
    profile = {
        sound_channel = "b_master",
        general_SessionPrompt = false,

        lootTimer_enabled = true,
        lootTimer_enableEpicTimer = false,
        lootTimer_audioAlerts = {
            ["thirtysec"] = false,
            ["fivesec"] = true,
            ["expired"] = true
        },
        lootTimer_chatAlerts = {
            ["thirtysec"] = false,
            ["fivesec"] = true,
            ["expired"] = true
        },

        blackOx_ExpireAlert = true,
        blackOx_RaidTarget = false,

        personalAlert_GroupSize = false,
        personalAlert_BagSpace = true,

        publicAlert_AuctionHouse = false,
        publicAlert_MailBox = false,
        publicAlert_Vendor = false,
        publicAlert_TappedMob = false,
        publicAlert_LootedEpic = false,
    },
    char = {
        LootTimerStart = 0,
        SessionActive = false,
        KillStart = 0,
        MoneyStart = 0,
        CurrentSpec = "",
        groupSizeAlertSent = false,
        tappedMobSent = false,
        bagSpace = 1000,
        showPanel = false
    }
}



---- Functions ----

function HST:OnInitialize()
    HST.db = LibStub("AceDB-3.0"):New("HyperspawnTrackerDB", defaults)
    local parent = LibStub("AceConfig-3.0"):RegisterOptionsTable("HyperspawnTracker", options)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("HyperspawnTracker", "Hyperspawn Tracker")
    profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(HST.db)
    LibStub("AceConfig-3.0"):RegisterOptionsTable("HyperspawnTracker.profiles", profiles)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("HyperspawnTracker.profiles", "Profiles", "Hyperspawn Tracker")
end

function HST:OnEnable()
    HST:RegisterChatCommand("hst", "ProcessSlash")
    StaticPopupDialogs["HST_SessionPrompt"] = {
        text = "Do you want to restart your session?",
        button1 = "Yes",
        button2 = "No",
        OnAccept = function()
            HST:NewSession(false)
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 4 -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
    }
end
