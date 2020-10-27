﻿local _, ADDON = ...

if GetLocale() ~= 'ptBR' then
    return
end

ADDON.isMetric = true -- is the metric or imperial/us unit system used?
local L = ADDON.L or {}

L["Black Market"] = "Mercado Negro"
--[[Translation missing --]]
--[[ L["Family"] = "Family"--]] 
--[[Translation missing --]]
--[[ L["FAVOR_DISPLAYED"] = "All Displayed"--]] 
--[[Translation missing --]]
--[[ L["FAVOR_PER_CHARACTER"] = "Per Character"--]] 
--[[Translation missing --]]
--[[ L["Flying"] = "Flying"--]] 
--[[Translation missing --]]
--[[ L["Ground"] = "Ground"--]] 
--[[Translation missing --]]
--[[ L["Hidden"] = "Hidden"--]] 
--[[Translation missing --]]
--[[ L["Only tradable"] = "Only tradable"--]] 
--[[Translation missing --]]
--[[ L["Only usable"] = "Only usable"--]] 
--[[Translation missing --]]
--[[ L["Passenger"] = "Passenger"--]] 
--[[Translation missing --]]
--[[ L["Reset filters"] = "Reset filters"--]] 
--[[Translation missing --]]
--[[ L["ROTATE_DOWN"] = "Rotate Down"--]] 
--[[Translation missing --]]
--[[ L["ROTATE_UP"] = "Rotate Up"--]] 
--[[Translation missing --]]
--[[ L["Show in Collections"] = "Show in Collections"--]] 
--[[Translation missing --]]
--[[ L["SORT_FAVORITES_FIRST"] = "Favorites First"--]] 
--[[Translation missing --]]
--[[ L["SORT_REVERSE"] = "Reverse Sort"--]] 
--[[Translation missing --]]
--[[ L["SORT_UNOWNED_BOTTOM"] = "Unowned at Bottom"--]] 
--[[Translation missing --]]
--[[ L["TASK_END"] = "[MJE] Phew! I'm done."--]] 
--[[Translation missing --]]
--[[ L["TASK_FAVOR_START"] = "[MJE] Reapplying stars all over your mounts. Please wait a few seconds until I'm finished."--]] 
--[[Translation missing --]]
--[[ L["Transform"] = "Transform"--]] 
--[[Translation missing --]]
--[[ L["Underwater"] = "Underwater"--]] 

-- Settings
--[[Translation missing --]]
--[[ L["SETTING_ACHIEVEMENT_POINTS"] = "Show achievement points"--]] 
--[[Translation missing --]]
--[[ L["SETTING_COMPACT_LIST"] = "Compact mount list"--]] 
--[[Translation missing --]]
--[[ L["SETTING_CURSOR_KEYS"] = "Enable Up&Down keys to browse mounts"--]] 
--[[Translation missing --]]
--[[ L["SETTING_CUSTOM_SORT_OPTIONS"] = "Enable more sort options"--]] 
--[[Translation missing --]]
--[[ L["SETTING_FAVORITE_PER_CHAR"] = "Favorite mounts per character"--]] 
--[[Translation missing --]]
--[[ L["SETTING_HEAD_BEHAVIOUR"] = "Behavior"--]] 
--[[Translation missing --]]
--[[ L["SETTING_MOUNT_COUNT"] = "Show personal mount count"--]] 
--[[Translation missing --]]
--[[ L["SETTING_MOVE_EQUIPMENT"] = "Move equipment slot into display"--]] 
--[[Translation missing --]]
--[[ L["SETTING_PERSONAL_FILTER"] = "Apply filters only to this character"--]] 
--[[Translation missing --]]
--[[ L["SETTING_PERSONAL_HIDDEN_MOUNTS"] = "Apply hidden mounts only to this character"--]] 
--[[Translation missing --]]
--[[ L["SETTING_PERSONAL_UI"] = "Apply Interface settings only to this character"--]] 
--[[Translation missing --]]
--[[ L["SETTING_PREVIEW_LINK"] = "Show Collection button in mount preview"--]] 
--[[Translation missing --]]
--[[ L["SETTING_SHOP_BUTTON"] = "Show shop button at untrained shop mounts"--]] 
--[[Translation missing --]]
--[[ L["SETTING_SHOW_USAGE"] = "Display mount usage statistics"--]] 
--[[Translation missing --]]
--[[ L["SETTING_TRACK_USAGE"] = "Track mount usage behavior on all characters"--]] 
--[[Translation missing --]]
--[[ L["SETTING_YCAMERA"] = "Unlock Y rotation with mouse in display"--]] 

-- Families
L["Airplanes"] = "Aviões"
L["Airships"] = "Aeronaus"
L["Alpacas"] = "Alpacas"
L["Amphibian"] = "Anfíbios"
--[[Translation missing --]]
--[[ L["Animite"] = "Animite"--]] 
--[[Translation missing --]]
--[[ L["Aqir Flyers"] = "Aqir Flyers"--]] 
L["Arachnids"] = "Aracnídeos"
--[[Translation missing --]]
--[[ L["Assault Wagons"] = "Assault Wagons"--]] 
L["Basilisks"] = "Basiliscos"
L["Bats"] = "Morcegos"
L["Bears"] = "Ursos"
L["Bees"] = "Abelhas"
L["Birds"] = "Aves"
--[[Translation missing --]]
--[[ L["Blood Ticks"] = "Blood Ticks"--]] 
L["Boars"] = "Javalis"
--[[Translation missing --]]
--[[ L["Bovids"] = "Bovids"--]] 
L["Brutosaurs"] = "Brutossauros"
L["Camels"] = "Camelos"
--[[Translation missing --]]
--[[ L["Carnivorans"] = "Carnivorans"--]] 
L["Carpets"] = "Tapetes"
--[[Translation missing --]]
--[[ L["Cats"] = "Cats"--]] 
L["Chargers"] = "Corcéis"
L["Chickens"] = "Galinhas"
--[[Translation missing --]]
--[[ L["Clefthooves"] = "Clefthooves"--]] 
--[[Translation missing --]]
--[[ L["Cloud Serpents"] = "Cloud Serpents"--]] 
--[[Translation missing --]]
--[[ L["Core Hounds"] = "Core Hounds"--]] 
L["Crabs"] = "Caranguejos"
--[[Translation missing --]]
--[[ L["Cranes"] = "Cranes"--]] 
--[[Translation missing --]]
--[[ L["Crawgs"] = "Crawgs"--]] 
L["Crocolisks"] = "Crocoliscos"
L["Crows"] = "Corvos"
--[[Translation missing --]]
--[[ L["Demonic Hounds"] = "Demonic Hounds"--]] 
--[[Translation missing --]]
--[[ L["Demonic Steeds"] = "Demonic Steeds"--]] 
L["Demons"] = "Demônios"
L["Dinosaurs"] = "Dinossauros"
--[[Translation missing --]]
--[[ L["Dire Wolves"] = "Dire Wolves"--]] 
--[[Translation missing --]]
--[[ L["Direhorns"] = "Direhorns"--]] 
L["Discs"] = "Discos"
--[[Translation missing --]]
--[[ L["Dragonhawks"] = "Dragonhawks"--]] 
--[[Translation missing --]]
--[[ L["Drakes"] = "Drakes"--]] 
--[[Translation missing --]]
--[[ L["Dread Ravens"] = "Dread Ravens"--]] 
--[[Translation missing --]]
--[[ L["Elekks"] = "Elekks"--]] 
--[[Translation missing --]]
--[[ L["Elementals"] = "Elementals"--]] 
--[[Translation missing --]]
--[[ L["Falcosaurs"] = "Falcosaurs"--]] 
--[[Translation missing --]]
--[[ L["Fathom Rays"] = "Fathom Rays"--]] 
--[[Translation missing --]]
--[[ L["Feathermanes"] = "Feathermanes"--]] 
--[[Translation missing --]]
--[[ L["Felsabers"] = "Felsabers"--]] 
--[[Translation missing --]]
--[[ L["Fish"] = "Fish"--]] 
--[[Translation missing --]]
--[[ L["Flying Steeds"] = "Flying Steeds"--]] 
--[[Translation missing --]]
--[[ L["Foxes"] = "Foxes"--]] 
--[[Translation missing --]]
--[[ L["Gargon"] = "Gargon"--]] 
--[[Translation missing --]]
--[[ L["Goats"] = "Goats"--]] 
--[[Translation missing --]]
--[[ L["Gorger"] = "Gorger"--]] 
--[[Translation missing --]]
--[[ L["Gorm"] = "Gorm"--]] 
--[[Translation missing --]]
--[[ L["Grand Drakes"] = "Grand Drakes"--]] 
--[[Translation missing --]]
--[[ L["Gronnlings"] = "Gronnlings"--]] 
--[[Translation missing --]]
--[[ L["Gryphons"] = "Gryphons"--]] 
--[[Translation missing --]]
--[[ L["Gyrocopters"] = "Gyrocopters"--]] 
--[[Translation missing --]]
--[[ L["Hawkstriders"] = "Hawkstriders"--]] 
--[[Translation missing --]]
--[[ L["Hippogryphs"] = "Hippogryphs"--]] 
--[[Translation missing --]]
--[[ L["Horned Steeds"] = "Horned Steeds"--]] 
--[[Translation missing --]]
--[[ L["Horses"] = "Horses"--]] 
--[[Translation missing --]]
--[[ L["Hounds"] = "Hounds"--]] 
--[[Translation missing --]]
--[[ L["Hovercraft"] = "Hovercraft"--]] 
--[[Translation missing --]]
--[[ L["Humanoids"] = "Humanoids"--]] 
--[[Translation missing --]]
--[[ L["Hyenas"] = "Hyenas"--]] 
--[[Translation missing --]]
--[[ L["Infernals"] = "Infernals"--]] 
--[[Translation missing --]]
--[[ L["Insects"] = "Insects"--]] 
--[[Translation missing --]]
--[[ L["Jellyfish"] = "Jellyfish"--]] 
--[[Translation missing --]]
--[[ L["Jet Aerial Units"] = "Jet Aerial Units"--]] 
--[[Translation missing --]]
--[[ L["Kites"] = "Kites"--]] 
--[[Translation missing --]]
--[[ L["Kodos"] = "Kodos"--]] 
--[[Translation missing --]]
--[[ L["Krolusks"] = "Krolusks"--]] 
--[[Translation missing --]]
--[[ L["Larion"] = "Larion"--]] 
--[[Translation missing --]]
--[[ L["Lions"] = "Lions"--]] 
--[[Translation missing --]]
--[[ L["Mammoths"] = "Mammoths"--]] 
--[[Translation missing --]]
--[[ L["Mana Rays"] = "Mana Rays"--]] 
--[[Translation missing --]]
--[[ L["Manasabers"] = "Manasabers"--]] 
--[[Translation missing --]]
--[[ L["Mechanical Animals"] = "Mechanical Animals"--]] 
--[[Translation missing --]]
--[[ L["Mechanical Birds"] = "Mechanical Birds"--]] 
--[[Translation missing --]]
--[[ L["Mechanical Cats"] = "Mechanical Cats"--]] 
--[[Translation missing --]]
--[[ L["Mechanical Steeds"] = "Mechanical Steeds"--]] 
--[[Translation missing --]]
--[[ L["Mechanostriders"] = "Mechanostriders"--]] 
--[[Translation missing --]]
--[[ L["Mecha-suits"] = "Mecha-suits"--]] 
--[[Translation missing --]]
--[[ L["Moose"] = "Moose"--]] 
--[[Translation missing --]]
--[[ L["Moth"] = "Moth"--]] 
--[[Translation missing --]]
--[[ L["Motorcycles"] = "Motorcycles"--]] 
--[[Translation missing --]]
--[[ L["Mountain Horses"] = "Mountain Horses"--]] 
--[[Translation missing --]]
--[[ L["Mushan"] = "Mushan"--]] 
--[[Translation missing --]]
--[[ L["Nether Drakes"] = "Nether Drakes"--]] 
--[[Translation missing --]]
--[[ L["Nether Rays"] = "Nether Rays"--]] 
--[[Translation missing --]]
--[[ L["N'Zoth Serpents"] = "N'Zoth Serpents"--]] 
--[[Translation missing --]]
--[[ L["Others"] = "Others"--]] 
--[[Translation missing --]]
--[[ L["Pandaren Phoenixes"] = "Pandaren Phoenixes"--]] 
--[[Translation missing --]]
--[[ L["Parrots"] = "Parrots"--]] 
--[[Translation missing --]]
--[[ L["Phoenixes"] = "Phoenixes"--]] 
--[[Translation missing --]]
--[[ L["Proto-Drakes"] = "Proto-Drakes"--]] 
--[[Translation missing --]]
--[[ L["Pterrordaxes"] = "Pterrordaxes"--]] 
--[[Translation missing --]]
--[[ L["Quilen"] = "Quilen"--]] 
--[[Translation missing --]]
--[[ L["Rams"] = "Rams"--]] 
--[[Translation missing --]]
--[[ L["Raptors"] = "Raptors"--]] 
--[[Translation missing --]]
--[[ L["Rats"] = "Rats"--]] 
--[[Translation missing --]]
--[[ L["Ravagers"] = "Ravagers"--]] 
--[[Translation missing --]]
--[[ L["Rays"] = "Rays"--]] 
--[[Translation missing --]]
--[[ L["Reptiles"] = "Reptiles"--]] 
--[[Translation missing --]]
--[[ L["Rhinos"] = "Rhinos"--]] 
--[[Translation missing --]]
--[[ L["Riverbeasts"] = "Riverbeasts"--]] 
--[[Translation missing --]]
--[[ L["Roc"] = "Roc"--]] 
--[[Translation missing --]]
--[[ L["Rockets"] = "Rockets"--]] 
--[[Translation missing --]]
--[[ L["Ruinstriders"] = "Ruinstriders"--]] 
--[[Translation missing --]]
--[[ L["Runestag"] = "Runestag"--]] 
--[[Translation missing --]]
--[[ L["Rylaks"] = "Rylaks"--]] 
--[[Translation missing --]]
--[[ L["Sabers"] = "Sabers"--]] 
--[[Translation missing --]]
--[[ L["Scorpions"] = "Scorpions"--]] 
--[[Translation missing --]]
--[[ L["Sea Serpents"] = "Sea Serpents"--]] 
--[[Translation missing --]]
--[[ L["Seahorses"] = "Seahorses"--]] 
--[[Translation missing --]]
--[[ L["Seat"] = "Seat"--]] 
--[[Translation missing --]]
--[[ L["Silithids"] = "Silithids"--]] 
--[[Translation missing --]]
--[[ L["Snapdragons"] = "Snapdragons"--]] 
--[[Translation missing --]]
--[[ L["Spider Tanks"] = "Spider Tanks"--]] 
--[[Translation missing --]]
--[[ L["Spiders"] = "Spiders"--]] 
--[[Translation missing --]]
--[[ L["Steeds"] = "Steeds"--]] 
--[[Translation missing --]]
--[[ L["Stingrays"] = "Stingrays"--]] 
--[[Translation missing --]]
--[[ L["Stone Cats"] = "Stone Cats"--]] 
--[[Translation missing --]]
--[[ L["Stone Drakes"] = "Stone Drakes"--]] 
--[[Translation missing --]]
--[[ L["Talbuks"] = "Talbuks"--]] 
--[[Translation missing --]]
--[[ L["Tallstriders"] = "Tallstriders"--]] 
--[[Translation missing --]]
--[[ L["Talonbirds"] = "Talonbirds"--]] 
--[[Translation missing --]]
--[[ L["Tauralus"] = "Tauralus"--]] 
--[[Translation missing --]]
--[[ L["Tigers"] = "Tigers"--]] 
--[[Translation missing --]]
--[[ L["Toads"] = "Toads"--]] 
--[[Translation missing --]]
--[[ L["Turtles"] = "Turtles"--]] 
--[[Translation missing --]]
--[[ L["Undead Drakes"] = "Undead Drakes"--]] 
--[[Translation missing --]]
--[[ L["Undead Steeds"] = "Undead Steeds"--]] 
--[[Translation missing --]]
--[[ L["Undead Wolves"] = "Undead Wolves"--]] 
--[[Translation missing --]]
--[[ L["Ungulates"] = "Ungulates"--]] 
--[[Translation missing --]]
--[[ L["Ur'zul"] = "Ur'zul"--]] 
--[[Translation missing --]]
--[[ L["Vehicles"] = "Vehicles"--]] 
--[[Translation missing --]]
--[[ L["Vulpin"] = "Vulpin"--]] 
--[[Translation missing --]]
--[[ L["Vultures"] = "Vultures"--]] 
--[[Translation missing --]]
--[[ L["War Wolves"] = "War Wolves"--]] 
--[[Translation missing --]]
--[[ L["Water Striders"] = "Water Striders"--]] 
--[[Translation missing --]]
--[[ L["Wind Drakes"] = "Wind Drakes"--]] 
--[[Translation missing --]]
--[[ L["Wolfhawks"] = "Wolfhawks"--]] 
--[[Translation missing --]]
--[[ L["Wolves"] = "Wolves"--]] 
--[[Translation missing --]]
--[[ L["Wyverns"] = "Wyverns"--]] 
--[[Translation missing --]]
--[[ L["Yaks"] = "Yaks"--]] 
--[[Translation missing --]]
--[[ L["Yetis"] = "Yetis"--]] 
