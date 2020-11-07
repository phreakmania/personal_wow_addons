local BUI, E, _, V, P, G = unpack(select(2, ...))
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale or 'enUS');
local BUID = BUI:GetModule('Dashboards');

local tinsert, pairs, ipairs, gsub, unpack, format, tostring = table.insert, pairs, ipairs, gsub, unpack, string.format, tostring
local GetProfessions, GetProfessionInfo = GetProfessions, GetProfessionInfo
local GetNumFactions, GetFactionInfo = GetNumFactions, GetFactionInfo
local BreakUpLargeNumbers = BreakUpLargeNumbers

local PROFESSIONS_ARCHAEOLOGY, PROFESSIONS_MISSING_PROFESSION, TOKENS = PROFESSIONS_ARCHAEOLOGY, PROFESSIONS_MISSING_PROFESSION, TOKENS
local PLAYER_V_PLAYER, SECONDARY_SKILLS, TRADE_SKILLS = PLAYER_V_PLAYER, SECONDARY_SKILLS, TRADE_SKILLS

-- GLOBALS: AceGUIWidgetLSMlists, hooksecurefunc

local dungeonTokens = {
	1166, 	-- Timewarped Badge (6.22)
}

local pvpTokens = {
	391,	-- Tol Barad Commendation
	1602,	-- Conquest
}

local secondaryTokens = {
	81,		-- Epicurean's Award
	402,	-- Ironpaw Token
	61,		-- Dalaran Jewelcrafter's Token
	361,	-- Illustrious Jewelcrafter's Token
}

local miscTokens = {
	241,	-- Champion's Seal
	416,	-- Mark of the World Tree
	515,	-- Darkmoon Prize Ticket
	789,	-- Bloody Coin
}

local mopTokens = {
	697,	-- Elder Charm of Good Fortune
	738,	-- Lesser Charm of Good Fortune
	776,	-- Warforged Seal
	777,	-- Timeless Coin
}

local wodTokens = {
	824,	-- Garrison Resources
	823,	-- Apexis Crystal (for gear, like the valors)
	994,	-- Seal of Tempered Fate (Raid loot roll)
	980,	-- Dingy Iron Coins (rogue only, from pickpocketing)
	944,	-- Artifact Fragment (PvP)
	1101,	-- Oil
	1129,	-- Seal of Inevitable Fate
	1191, 	-- Valor Points (6.23)
}

local legionTokens = {
	1155,	-- Ancient Mana
	1220,	-- Order Resources
	1275,	-- Curious Coin (Buy stuff :P)
	1226,	-- Nethershard (Invasion scenarios)
	1273,	-- Seal of Broken Fate (Raid)
	1154,	-- Shadowy Coins
	1149,	-- Sightless Eye (PvP)
	1268,	-- Timeworn Artifact (Honor Points?)
	1299,	-- Brawler's Gold
	1314,	-- Lingering Soul Fragment (Good luck with this one :D)
	1342,	-- Legionfall War Supplies (Construction at the Broken Shore)
	1355,	-- Felessence (Craft Legentary items)
	1356,	-- Echoes of Battle (PvP Gear)
	1357,	-- Echoes of Domination (Elite PvP Gear)
	1416,	-- Coins of Air
	1508,	-- Veiled Argunite
	1533,	-- Wakening Essence
}

local bfaTokens = {
	1560, -- War Resources
	1580,	-- Seal of Wartorn Fate
	1587,	-- War Supplies
	1710,	-- Seafarer's Dubloon
	1718,	-- Titan Residuum
	1719,	-- Corrupted Memento
	1721,	-- Prismatic Manapearl
	1755,	-- Coalescing Visions
	1803,	-- Echoes of Ny'alotha
}

local slTokens = {
	1751,	-- Freed Soul
	1754,	-- Argent Commendation
	1810,	-- Willing Soul
	1813,	-- Reservoir Anima
	1820,	-- Infused Ruby
	1822,	-- Renown
	1828, 	-- Soul Ash
}

-- Archaeology tokens
local archyClassic = {
	384,	-- Dwarf Archaeology Fragment
	385,	-- Troll Archaeology Fragment
	393,	-- Fossil Archaeology Fragment
	394,	-- Night Elf Archaeology Fragment
	397,	-- Orc Archaeology Fragment
	398,	-- Draenei Archaeology Fragment
	399,	-- Vrykul Archaeology Fragment
	400,	-- Nerubian Archaeology Fragment
	401,	-- Tol'vir Archaeology Fragment
}

local archyMop = {
	676,	-- Pandaren Archaeology Fragment
	677,	-- Mogu Archaeology Fragment
	754,	-- Mantid Archaeology Fragment
}

local archyWod = {
	821,	-- Draenor Clans Archaeology Fragment
	828,	-- Ogre Archaeology Fragment
	829,	-- Arakkoa Archaeology Fragment
}

local archyLegion = {
	1172,	-- Highborne Archaeology Fragment
	1173,	-- Highmountain Tauren Archaeology Fragment
	1174,	-- Demonic Archaeology Fragment
}
local archyBfa = {
	1534,	-- Zandalari Archaeology Fragment
	1535,	-- Drust Archaeology Fragment
}

local secondaryTokensName = SECONDARY_SKILLS:gsub(':', '')

local currencyTables = {
	-- table, option, name
	{dungeonTokens, 'dungeonTokens', GROUP_FINDER},
	{pvpTokens, 'pvpTokens', PLAYER_V_PLAYER},
	{slTokens, 'slTokens', EXPANSION_NAME8},
	{bfaTokens, 'bfaTokens', EXPANSION_NAME7},
	{legionTokens, 'legionTokens', EXPANSION_NAME6},
	{wodTokens, 'wodTokens', EXPANSION_NAME5},
	{mopTokens, 'mopTokens', EXPANSION_NAME4},
	{secondaryTokens, 'secondaryTokens', secondaryTokensName},
	{miscTokens, 'miscTokens', MISCELLANEOUS},
}

local archyTables = {
	-- table, option, name
	{archyClassic, 'classic', EXPANSION_NAME0},
	{archyMop, 'mop', EXPANSION_NAME4},
	{archyWod, 'wod', EXPANSION_NAME5},
	{archyLegion, 'legion', EXPANSION_NAME6},
	{archyBfa, 'bfa', EXPANSION_NAME7},
}

local boards = {"FPS", "MS", "Durability", "Bags", "Volume"}

local function UpdateSystemOptions()
	for _, boardname in pairs(boards) do
		local optionOrder = 1
		E.Options.args.benikui.args.dashboards.args.system.args.chooseSystem.args[boardname] = {
			order = optionOrder + 1,
			type = 'toggle',
			name = boardname,
			desc = L['Enable/Disable ']..boardname,
			get = function(info) return E.db.dashboards.system.chooseSystem[boardname] end,
			set = function(info, value) E.db.dashboards.system.chooseSystem[boardname] = value; E:StaticPopup_Show('PRIVATE_RL'); end,
		}
	end

	E.Options.args.benikui.args.dashboards.args.system.args.latency = {
		order = 10,
		type = "select",
		name = L['Latency (MS)'],
		values = {
			[1] = L.HOME,
			[2] = L.WORLD,
		},
		disabled = function() return not E.db.dashboards.system.chooseSystem.MS end,
		get = function(info) return E.db.dashboards.system.latency end,
		set = function(info, value) E.db.dashboards.system.latency = value; E:StaticPopup_Show('PRIVATE_RL'); end,
	}
end

-- these options must be updated when the player discovers a new token.
local function UpdateTokenOptions()
	if E.myfaction == 'Alliance' then
		tinsert(bfaTokens, 1717) -- 7th Legion Service Medal (Alliance)
	elseif E.myfaction == 'Horde' then
		tinsert(bfaTokens, 1716) -- Honorbound Service Medal (Horde)
	end

	for i, v in ipairs(currencyTables) do
		local tableName, option, optionName = unpack(v)
		local optionOrder = 1
		for _, id in ipairs(tableName) do
			E.Options.args.benikui.args.dashboards.args.tokens.args[option] = {
				order = i,
				type = 'group',
				name = optionName,
				args = {
				},
			}
			for _, id in ipairs(tableName) do
				local tname, amount, icon, _, _, isDiscovered = BUID:GetTokenInfo(id)
				if tname then
					E.Options.args.benikui.args.dashboards.args.tokens.args[option].args.desc = {
						order = optionOrder + 1,
						name = BUI:cOption(L['Tip: Grayed tokens are not yet discovered'], "blue"),
						type = 'header',
					}
					E.Options.args.benikui.args.dashboards.args.tokens.args[option].args[tname] = {
						order = optionOrder + 2,
						type = 'toggle',
						name = (icon and '|T'..icon..':18|t '..tname) or tname,
						desc = format('%s %s\n\n|cffffff00%s: %s|r', L['Enable/Disable'], tname, L['Amount'], BreakUpLargeNumbers(amount)),
						get = function(info) return E.private.dashboards.tokens.chooseTokens[id] end,
						set = function(info, value) E.private.dashboards.tokens.chooseTokens[id] = value; BUID:UpdateTokens(); BUID:UpdateTokenSettings(); end,
						disabled = function() return not isDiscovered end,
					}
				end
			end
		end
	end

	for i, v in ipairs(archyTables) do
		local tableName, option, optionName = unpack(v)
		local optionOrder = 1
		for _, id in ipairs(tableName) do
			E.Options.args.benikui.args.dashboards.args.tokens.args.archyGroup.args[option] = {
				order = i,
				type = 'group',
				name = optionName,
				args = {
				},
			}
			for _, id in ipairs(tableName) do
				local tname, amount, icon, _, _, isDiscovered = BUID:GetTokenInfo(id)
				if id and tname then
					E.Options.args.benikui.args.dashboards.args.tokens.args.archyGroup.args[option].args[tname] = {
						order = optionOrder + 1,
						type = 'toggle',
						name = (icon and '|T'..icon..':18|t '..(tname:gsub(' '..PROFESSIONS_ARCHAEOLOGY..' ', ' '))) or (tname:gsub(' '..PROFESSIONS_ARCHAEOLOGY..' ', ' ')), -- remove 'Archaeology' from the name, to shorten the options a bit.
						desc = format('%s %s\n\n|cffffff00%s: %s|r', L['Enable/Disable'], tname, L['Amount'], amount),
						get = function(info) return E.private.dashboards.tokens.chooseTokens[id] end,
						set = function(info, value) E.private.dashboards.tokens.chooseTokens[id] = value; BUID:UpdateTokens(); BUID:UpdateTokenSettings(); end,
						disabled = function() return not isDiscovered end,
					}
				end
			end
		end
	end
end

local function UpdateProfessionOptions()
	local prof1, prof2, archy, fishing, cooking = GetProfessions()
	local optionOrder = 1
	if (prof1 or prof2 or archy or fishing or cooking) then
		E.Options.args.benikui.args.dashboards.args.professions.args.choosePofessions = {
			order = 50,
			type = 'group',
			guiInline = true,
			name = L['Select Professions'],
			disabled = function() return not E.db.dashboards.professions.enableProfessions end,
			args = {
			},
		}
		local proftable = { GetProfessions() }
		for _, id in pairs(proftable) do
			local pname, icon = GetProfessionInfo(id)
			if pname then
				E.Options.args.benikui.args.dashboards.args.professions.args.choosePofessions.args[pname] = {
					order = optionOrder + 1,
					type = 'toggle',
					name = '|T'..icon..':18|t '..pname,
					desc = format('%s %s', L['Enable/Disable'], pname),
					get = function(info) return E.private.dashboards.professions.choosePofessions[id] end,
					set = function(info, value) E.private.dashboards.professions.choosePofessions[id] = value; BUID:UpdateProfessions(); BUID:UpdateProfessionSettings(); end,
				}
			end
		end
	else
		E.Options.args.benikui.args.dashboards.args.professions.args.choosePofessions = {
			order = 50,
			type = 'group',
			guiInline = true,
			name = L['Select Professions'],
			disabled = function() return not E.db.dashboards.professions.enableProfessions end,
			args = {
				noprof = {
					order = 1,
					type = 'description',
					name = PROFESSIONS_MISSING_PROFESSION,
				},
			},
		}
	end
end

local function UpdateReputationOptions()
	local numFactions = GetNumFactions()
	local factionIndex = 1
	local optionOrder = 1
	
	while (factionIndex <= numFactions) do
		local tname, _, _, _, _, _, _, _, isHeader, isCollapsed, hasRep, _, _, factionID = GetFactionInfo(factionIndex);

		if isHeader and isCollapsed then
			ExpandFactionHeader(factionIndex)
			numFactions = GetNumFactions()
		end

		local id = tostring(factionID)
		if hasRep or not isHeader then
			E.Options.args.benikui.args.dashboards.args.reputations.args[id] = {
				order = 100,
				type = 'toggle',
				name = tname,
				disabled = function() return not E.db.dashboards.reputations.enableReputations end,
				get = function(info) return E.private.dashboards.reputations.chooseReputations[id] end,
				set = function(info, value) E.private.dashboards.reputations.chooseReputations[id] = value; BUID:UpdateReputations(); BUID:UpdateReputationSettings(); end,
			}
		end

		factionIndex = factionIndex + 1
	end
end

local function dashboardsTable()
	E.Options.args.benikui.args.dashboards = {
		order = 60,
		type = 'group',
		name = BUI:cOption(L['Dashboards'], "blue"),
		args = {
			dashColor = {
				order = 1,
				type = 'group',
				name = L.COLOR,
				guiInline = true,
				args = {
					barColor = {
						type = "select",
						order = 1,
						name = L['Bar Color'],
						values = {
							[1] = L.CLASS_COLORS,
							[2] = L.CUSTOM,
						},
						get = function(info) return E.db.dashboards[ info[#info] ] end,
						set = function(info, value) E.db.dashboards[ info[#info] ] = value;
							if E.db.dashboards.professions.enableProfessions then BUID:UpdateProfessionSettings(); end
							if E.db.dashboards.tokens.enableTokens then BUID:UpdateTokenSettings(); end
							if E.db.dashboards.system.enableSystem then BUID:UpdateSystemSettings(); end
							if E.db.dashboards.reputations.enableReputations then BUID:UpdateReputationSettings(); end
						end,
					},
					customBarColor = {
						order = 2,
						type = "color",
						name = COLOR_PICKER,
						disabled = function() return E.db.dashboards.barColor == 1 end,
						get = function(info)
							local t = E.db.dashboards[ info[#info] ]
							local d = P.dashboards[info[#info]]
							return t.r, t.g, t.b, t.a, d.r, d.g, d.b
						end,
						set = function(info, r, g, b, a)
							E.db.dashboards[ info[#info] ] = {}
							local t = E.db.dashboards[ info[#info] ]
							t.r, t.g, t.b, t.a = r, g, b, a
							if E.db.dashboards.professions.enableProfessions then BUID:UpdateProfessionSettings(); end
							if E.db.dashboards.tokens.enableTokens then BUID:UpdateTokenSettings(); end
							if E.db.dashboards.system.enableSystem then BUID:UpdateSystemSettings(); end
							if E.db.dashboards.reputations.enableReputations then BUID:UpdateReputationSettings(); end
						end,
					},
					spacer = {
						order = 3,
						type = 'header',
						name = '',
					},
					textColor = {
						order = 4,
						type = "select",
						name = L['Text Color'],
						values = {
							[1] = L.CLASS_COLORS,
							[2] = L.CUSTOM,
						},
						get = function(info) return E.db.dashboards[ info[#info] ] end,
						set = function(info, value) E.db.dashboards[ info[#info] ] = value;
							if E.db.dashboards.professions.enableProfessions then BUID:UpdateProfessionSettings(); end
							if E.db.dashboards.tokens.enableTokens then BUID:UpdateTokenSettings(); end
							if E.db.dashboards.system.enableSystem then BUID:UpdateSystemSettings(); end
							if E.db.dashboards.reputations.enableReputations then BUID:UpdateReputationSettings(); end
						end,
					},
					customTextColor = {
						order = 5,
						type = "color",
						name = L.COLOR_PICKER,
						disabled = function() return E.db.dashboards.textColor == 1 end,
						get = function(info)
							local t = E.db.dashboards[ info[#info] ]
							local d = P.dashboards[info[#info]]
							return t.r, t.g, t.b, t.a, d.r, d.g, d.b
							end,
						set = function(info, r, g, b, a)
							E.db.dashboards[ info[#info] ] = {}
							local t = E.db.dashboards[ info[#info] ]
							t.r, t.g, t.b, t.a = r, g, b, a
							if E.db.dashboards.professions.enableProfessions then BUID:UpdateProfessionSettings(); end
							if E.db.dashboards.tokens.enableTokens then BUID:UpdateTokenSettings(); end
							if E.db.dashboards.system.enableSystem then BUID:UpdateSystemSettings(); end
							if E.db.dashboards.reputations.enableReputations then BUID:UpdateReputationSettings(); end
						end,
					},
				},
			},
			dashfont = {
				order = 2,
				type = 'group',
				name = L['Fonts'],
				guiInline = true,
				disabled = function() return not E.db.dashboards.system.enableSystem and not E.db.dashboards.tokens.enableTokens and not E.db.dashboards.professions.enableProfessions end,
				get = function(info) return E.db.dashboards.dashfont[ info[#info] ] end,
				set = function(info, value) E.db.dashboards.dashfont[ info[#info] ] = value;
					if E.db.dashboards.professions.enableProfessions then BUID:UpdateProfessionSettings(); end
					if E.db.dashboards.tokens.enableTokens then BUID:UpdateTokenSettings(); end
					if E.db.dashboards.system.enableSystem then BUID:UpdateSystemSettings(); end
					if E.db.dashboards.reputations.enableReputations then BUID:UpdateReputationSettings(); end
				end,
				args = {
					useDTfont = {
						order = 1,
						name = L['Use DataTexts font'],
						type = 'toggle',
						width = 'full',
					},
					dbfont = {
						type = 'select', dialogControl = 'LSM30_Font',
						order = 2,
						name = L['Font'],
						desc = L['Choose font for all dashboards.'],
						disabled = function() return E.db.dashboards.dashfont.useDTfont end,
						values = AceGUIWidgetLSMlists.font,
					},
					dbfontsize = {
						order = 3,
						name = L.FONT_SIZE,
						desc = L['Set the font size.'],
						disabled = function() return E.db.dashboards.dashfont.useDTfont end,
						type = 'range',
						min = 6, max = 22, step = 1,
					},
					dbfontflags = {
						order = 4,
						name = L['Font Outline'],
						disabled = function() return E.db.dashboards.dashfont.useDTfont end,
						type = 'select',
						values = {
							['NONE'] = L['None'],
							['OUTLINE'] = 'OUTLINE',
							['MONOCHROMEOUTLINE'] = 'MONOCROMEOUTLINE',
							['THICKOUTLINE'] = 'THICKOUTLINE',
						},
					},
				},
			},
			system = {
				order = 3,
				type = 'group',
				name = L['System'],
				args = {
					enableSystem = {
						order = 1,
						type = 'toggle',
						name = L["Enable"],
						width = 'full',
						desc = L['Enable the System Dashboard.'],
						get = function(info) return E.db.dashboards.system.enableSystem end,
						set = function(info, value) E.db.dashboards.system.enableSystem = value; E:StaticPopup_Show('PRIVATE_RL'); end,
					},
					combat = {
						order = 2,
						name = L['Combat Fade'],
						desc = L['Show/Hide System Dashboard when in combat'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.system.enableSystem end,
						get = function(info) return E.db.dashboards.system.combat end,
						set = function(info, value) E.db.dashboards.system.combat = value; BUID:EnableDisableCombat(BUI_SystemDashboard, 'system'); end,
					},
					mouseover = {
						order = 3,
						name = L['Mouse Over'],
						desc = L['The frame is not shown unless you mouse over the frame.'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.system.enableSystem end,
						get = function(info) return E.db.dashboards.system.mouseover end,
						set = function(info, value) E.db.dashboards.system.mouseover = value; E:StaticPopup_Show('PRIVATE_RL'); end,
					},
					width = {
						order = 4,
						type = 'range',
						name = L['Width'],
						desc = L['Change the System Dashboard width.'],
						min = 120, max = 520, step = 1,
						disabled = function() return not E.db.dashboards.system.enableSystem end,
						get = function(info) return E.db.dashboards.system.width end,
						set = function(info, value) E.db.dashboards.system.width = value; BUID:UpdateHolderDimensions(BUI_SystemDashboard, 'system', BUI.SystemDB); BUID:UpdateSystemSettings(); end,
					},
					style = {
						order = 5,
						name = L['BenikUI Style'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.system.enableSystem end,
						get = function(info) return E.db.dashboards.system.style end,
						set = function(info, value) E.db.dashboards.system.style = value; BUID:ToggleStyle(BUI_SystemDashboard, 'system'); end,
					},
					transparency = {
						order = 6,
						name = L['Panel Transparency'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.system.enableSystem end,
						get = function(info) return E.db.dashboards.system.transparency end,
						set = function(info, value) E.db.dashboards.system.transparency = value; BUID:ToggleTransparency(BUI_SystemDashboard, 'system'); end,
					},
					backdrop = {
						order = 7,
						name = L['Backdrop'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.system.enableSystem end,
						get = function(info) return E.db.dashboards.system.backdrop end,
						set = function(info, value) E.db.dashboards.system.backdrop = value; BUID:ToggleTransparency(BUI_SystemDashboard, 'system'); end,
					},
					spacer = {
						order = 10,
						type = 'header',
						name = '',
					},
					chooseSystem = {
						order = 20,
						type = 'group',
						guiInline = true,
						name = L['Select System Board'],
						disabled = function() return not E.db.dashboards.system.enableSystem end,
						args = {
						},
					},
				},
			},
			tokens = {
				order = 4,
				type = 'group',
				name = TOKENS,
				childGroups = 'select',
				args = {
					enableTokens = {
						order = 1,
						type = 'toggle',
						name = L["Enable"],
						width = 'full',
						desc = L['Enable the Tokens Dashboard.'],
						get = function(info) return E.db.dashboards.tokens.enableTokens end,
						set = function(info, value) E.db.dashboards.tokens.enableTokens = value; E:StaticPopup_Show('PRIVATE_RL'); end,
					},
					combat = {
						order = 2,
						name = L['Combat Fade'],
						desc = L['Show/Hide Tokens Dashboard when in combat'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.tokens.enableTokens end,
						get = function(info) return E.db.dashboards.tokens.combat end,
						set = function(info, value) E.db.dashboards.tokens.combat = value; BUID:EnableDisableCombat(BUI_TokensDashboard, 'tokens'); end,
					},
					mouseover = {
						order = 3,
						name = L['Mouse Over'],
						desc = L['The frame is not shown unless you mouse over the frame.'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.tokens.enableTokens end,
						get = function(info) return E.db.dashboards.tokens.mouseover end,
						set = function(info, value) E.db.dashboards.tokens.mouseover = value; BUID:UpdateTokens(); BUID:UpdateTokenSettings(); end,
					},
					width = {
						order = 4,
						type = 'range',
						name = L['Width'],
						desc = L['Change the Tokens Dashboard width.'],
						min = 120, max = 520, step = 1,
						disabled = function() return not E.db.dashboards.tokens.enableTokens end,
						get = function(info) return E.db.dashboards.tokens.width end,
						set = function(info, value) E.db.dashboards.tokens.width = value; BUID:UpdateHolderDimensions(BUI_TokensDashboard, 'tokens', BUI.TokensDB); BUID:UpdateTokenSettings(); end,
					},
					style = {
						order = 5,
						name = L['BenikUI Style'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.tokens.enableTokens end,
						get = function(info) return E.db.dashboards.tokens.style end,
						set = function(info, value) E.db.dashboards.tokens.style = value; BUID:ToggleStyle(BUI_TokensDashboard, 'tokens'); end,
					},
					transparency = {
						order = 6,
						name = L['Panel Transparency'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.tokens.enableTokens end,
						get = function(info) return E.db.dashboards.tokens.transparency end,
						set = function(info, value) E.db.dashboards.tokens.transparency = value; BUID:ToggleTransparency(BUI_TokensDashboard, 'tokens'); end,
					},
					backdrop = {
						order = 7,
						name = L['Backdrop'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.tokens.enableTokens end,
						get = function(info) return E.db.dashboards.tokens.backdrop end,
						set = function(info, value) E.db.dashboards.tokens.backdrop = value; BUID:ToggleTransparency(BUI_TokensDashboard, 'tokens'); end,
					},
					tooltip = {
						order = 8,
						name = L['Tooltip'],
						desc = L['Show/Hide Tooltips'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.tokens.enableTokens end,
						get = function(info) return E.db.dashboards.tokens.tooltip end,
						set = function(info, value) E.db.dashboards.tokens.tooltip = value; BUID:UpdateTokens(); BUID:UpdateTokenSettings(); end,
					},
					zeroamount = {
						order = 9,
						name = L['Show zero amount tokens'],
						desc = L['Show the token, even if the amount is 0'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.tokens.enableTokens end,
						get = function(info) return E.db.dashboards.tokens.zeroamount end,
						set = function(info, value) E.db.dashboards.tokens.zeroamount = value; BUID:UpdateTokens(); BUID:UpdateTokenSettings(); end,
					},
					weekly = {
						order = 10,
						name = L['Show Weekly max'],
						desc = L['Show Weekly max tokens instead of total max'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.tokens.enableTokens end,
						get = function(info) return E.db.dashboards.tokens.weekly end,
						set = function(info, value) E.db.dashboards.tokens.weekly = value; BUID:UpdateTokens(); BUID:UpdateTokenSettings(); end,
					},
					spacer = {
						order = 11,
						type = 'header',
						name = '',
					},
					archyGroup = {
						order = 100,
						type = 'group',
						name = format('%s', PROFESSIONS_ARCHAEOLOGY),
						args = {
							desc = {
								order = 1,
								name = BUI:cOption(L['Tip: Grayed tokens are not yet discovered'], "blue"),
								type = 'header',
							},
						},
					},
				},
			},
			professions = {
				order = 5,
				type = 'group',
				name = TRADE_SKILLS,
				args = {
					enableProfessions = {
						order = 1,
						type = 'toggle',
						name = L["Enable"],
						width = 'full',
						desc = L['Enable the Professions Dashboard.'],
						get = function(info) return E.db.dashboards.professions.enableProfessions end,
						set = function(info, value) E.db.dashboards.professions.enableProfessions = value; E:StaticPopup_Show('PRIVATE_RL'); end,
					},
					combat = {
						order = 2,
						name = L['Combat Fade'],
						desc = L['Show/Hide Professions Dashboard when in combat'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.professions.enableProfessions end,
						get = function(info) return E.db.dashboards.professions.combat end,
						set = function(info, value) E.db.dashboards.professions.combat = value; BUID:EnableDisableCombat(BUI_ProfessionsDashboard, 'professions'); end,
					},
					mouseover = {
						order = 3,
						name = L['Mouse Over'],
						desc = L['The frame is not shown unless you mouse over the frame.'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.professions.enableProfessions end,
						get = function(info) return E.db.dashboards.professions.mouseover end,
						set = function(info, value) E.db.dashboards.professions.mouseover = value; BUID:UpdateProfessions(); BUID:UpdateProfessionSettings(); end,
					},
					width = {
						order = 4,
						type = 'range',
						name = L['Width'],
						desc = L['Change the Professions Dashboard width.'],
						min = 120, max = 520, step = 1,
						disabled = function() return not E.db.dashboards.professions.enableProfessions end,
						get = function(info) return E.db.dashboards.professions.width end,
						set = function(info, value) E.db.dashboards.professions.width = value; BUID:UpdateHolderDimensions(BUI_ProfessionsDashboard, 'professions', BUI.ProfessionsDB); BUID:UpdateProfessionSettings(); end,
					},
					style = {
						order = 5,
						name = L['BenikUI Style'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.professions.enableProfessions end,
						get = function(info) return E.db.dashboards.professions.style end,
						set = function(info, value) E.db.dashboards.professions.style = value; BUID:ToggleStyle(BUI_ProfessionsDashboard, 'professions'); end,
					},
					transparency = {
						order = 6,
						name = L['Panel Transparency'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.professions.enableProfessions end,
						get = function(info) return E.db.dashboards.professions.transparency end,
						set = function(info, value) E.db.dashboards.professions.transparency = value; BUID:ToggleTransparency(BUI_ProfessionsDashboard, 'professions'); end,
					},
					backdrop = {
						order = 7,
						name = L['Backdrop'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.professions.enableProfessions end,
						get = function(info) return E.db.dashboards.professions.backdrop end,
						set = function(info, value) E.db.dashboards.professions.backdrop = value; BUID:ToggleTransparency(BUI_ProfessionsDashboard, 'professions'); end,
					},
					capped = {
						order = 8,
						name = L['Filter Capped'],
						desc = L['Show/Hide Professions that are skill capped'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.professions.enableProfessions end,
						get = function(info) return E.db.dashboards.professions.capped end,
						set = function(info, value) E.db.dashboards.professions.capped = value; BUID:UpdateProfessions(); BUID:UpdateProfessionSettings(); end,
					},
					spacer = {
						order = 9,
						type = 'header',
						name = '',
					},
				},
			},
			reputations = {
				order = 6,
				type = 'group',
				name = format('%s |cff00c0fa%s|r', REPUTATION, '(WIP)'),
				childGroups = 'select',
				args = {
					enableReputations = {
						order = 1,
						type = 'toggle',
						name = L["Enable"],
						width = 'full',
						desc = L['Enable the Professions Dashboard.'],
						get = function(info) return E.db.dashboards.reputations.enableReputations end,
						set = function(info, value) E.db.dashboards.reputations.enableReputations = value; E:StaticPopup_Show('PRIVATE_RL'); end,
					},
					combat = {
						order = 2,
						name = L['Combat Fade'],
						desc = L['Show/Hide Professions Dashboard when in combat'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.reputations.enableReputations end,
						get = function(info) return E.db.dashboards.reputations.combat end,
						set = function(info, value) E.db.dashboards.reputations.combat = value; BUID:EnableDisableCombat(BUI_ReputationsDashboard, 'reputations'); end,
					},
					mouseover = {
						order = 3,
						name = L['Mouse Over'],
						desc = L['The frame is not shown unless you mouse over the frame.'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.reputations.enableReputations end,
						get = function(info) return E.db.dashboards.reputations.mouseover end,
						set = function(info, value) E.db.dashboards.reputations.mouseover = value; BUID:UpdateReputations(); BUID:UpdateReputationSettings(); end,
					},
					width = {
						order = 4,
						type = 'range',
						name = L['Width'],
						desc = L['Change the Professions Dashboard width.'],
						min = 120, max = 520, step = 1,
						disabled = function() return not E.db.dashboards.reputations.enableReputations end,
						get = function(info) return E.db.dashboards.reputations.width end,
						set = function(info, value) E.db.dashboards.reputations.width = value; BUID:UpdateHolderDimensions(BUI_ReputationsDashboard, 'reputations', BUI.FactionsDB); BUID:UpdateReputationSettings(); BUID:UpdateReputations(); end,
					},
					style = {
						order = 5,
						name = L['BenikUI Style'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.reputations.enableReputations end,
						get = function(info) return E.db.dashboards.reputations.style end,
						set = function(info, value) E.db.dashboards.reputations.style = value; BUID:ToggleStyle(BUI_ReputationsDashboard, 'reputations'); end,
					},
					transparency = {
						order = 6,
						name = L['Panel Transparency'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.reputations.enableReputations end,
						get = function(info) return E.db.dashboards.reputations.transparency end,
						set = function(info, value) E.db.dashboards.reputations.transparency = value; BUID:ToggleTransparency(BUI_ReputationsDashboard, 'reputations'); end,
					},
					backdrop = {
						order = 7,
						name = L['Backdrop'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.reputations.enableReputations end,
						get = function(info) return E.db.dashboards.reputations.backdrop end,
						set = function(info, value) E.db.dashboards.reputations.backdrop = value; BUID:ToggleTransparency(BUI_ReputationsDashboard, 'reputations'); end,
					},
					barFactionColors = {
						order = 8,
						name = L['Use Faction Colors on Bars'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.reputations.enableReputations end,
						get = function(info) return E.db.dashboards.reputations.barFactionColors end,
						set = function(info, value) E.db.dashboards.reputations.barFactionColors = value; BUID:UpdateReputations(); BUID:UpdateReputationSettings(); end,
					},
					textFactionColors = {
						order = 9,
						name = L['Use Faction Colors on Text'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.reputations.enableReputations end,
						get = function(info) return E.db.dashboards.reputations.textFactionColors end,
						set = function(info, value) E.db.dashboards.reputations.textFactionColors = value; BUID:UpdateReputationSettings(); BUID:UpdateReputations(); end,
					},
					tooltip = {
						order = 10,
						name = L['Tooltip'],
						type = 'toggle',
						disabled = function() return not E.db.dashboards.reputations.enableReputations end,
						get = function(info) return E.db.dashboards.reputations.tooltip end,
						set = function(info, value) E.db.dashboards.reputations.tooltip = value; BUID:UpdateReputations(); end,
					},
					spacer = {
						order = 20,
						type = 'header',
						name = '',
					},
				},
			},
		},
	}
	-- update the options, when ElvUI Config fires
	hooksecurefunc(E, "ToggleOptionsUI", UpdateTokenOptions)
	hooksecurefunc(E, "ToggleOptionsUI", UpdateProfessionOptions)
	hooksecurefunc(E, "ToggleOptionsUI", UpdateReputationOptions)
end

tinsert(BUI.Config, dashboardsTable)
tinsert(BUI.Config, UpdateSystemOptions)
tinsert(BUI.Config, UpdateTokenOptions)
tinsert(BUI.Config, UpdateProfessionOptions)
tinsert(BUI.Config, UpdateReputationOptions)
