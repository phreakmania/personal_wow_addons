﻿local _, ADDON = ...

if GetLocale() ~= 'koKR' then
    return
end

ADDON.isMetric = true -- is the metric or imperial/us unit system used?
local L = ADDON.L or {}

L["Black Market"] = "암시장"
L["Family"] = "종류"
L["FAVOR_DISPLAYED"] = "모두 표시"
L["FAVOR_PER_CHARACTER"] = "캐릭터별 표시"
L["Flying"] = "비행"
L["Ground"] = "지상"
L["Hidden"] = "숨김"
L["Only tradable"] = "교환가능"
L["Only usable"] = "사용가능"
L["Passenger"] = "승객"
L["Reset filters"] = "필터 초기화"
--[[Translation missing --]]
--[[ L["ROTATE_DOWN"] = "Rotate Down"--]] 
--[[Translation missing --]]
--[[ L["ROTATE_UP"] = "Rotate Up"--]] 
L["Show in Collections"] = "모음집에서 보기"
--[[Translation missing --]]
--[[ L["SORT_FAVORITES_FIRST"] = "Favorites First"--]] 
--[[Translation missing --]]
--[[ L["SORT_REVERSE"] = "Reverse Sort"--]] 
--[[Translation missing --]]
--[[ L["SORT_UNOWNED_BOTTOM"] = "Unowned at Bottom"--]] 
L["TASK_END"] = "[MJE] 작업 완료"
L["TASK_FAVOR_START"] = "[MJE] 탈것 목록 즐겨찾기 재설정을 시작합니다"
L["Transform"] = "변환"
L["Underwater"] = "수중"

-- Settings
--[[Translation missing --]]
--[[ L["SETTING_ACHIEVEMENT_POINTS"] = "Show achievement points"--]] 
L["SETTING_COMPACT_LIST"] = "간소한 목록"
L["SETTING_CURSOR_KEYS"] = "위 아래 화살표 키로 목록 탐색하기"
--[[Translation missing --]]
--[[ L["SETTING_CUSTOM_SORT_OPTIONS"] = "Enable more sort options"--]] 
L["SETTING_FAVORITE_PER_CHAR"] = "캐릭터별 즐겨찾기"
--[[Translation missing --]]
--[[ L["SETTING_HEAD_BEHAVIOUR"] = "Behavior"--]] 
--[[Translation missing --]]
--[[ L["SETTING_MOUNT_COUNT"] = "Show personal mount count"--]] 
L["SETTING_MOVE_EQUIPMENT"] = "착용 장비 표시 이동"
--[[Translation missing --]]
--[[ L["SETTING_PERSONAL_FILTER"] = "Apply filters only to this character"--]] 
--[[Translation missing --]]
--[[ L["SETTING_PERSONAL_HIDDEN_MOUNTS"] = "Apply hidden mounts only to this character"--]] 
--[[Translation missing --]]
--[[ L["SETTING_PERSONAL_UI"] = "Apply Interface settings only to this character"--]] 
--[[Translation missing --]]
--[[ L["SETTING_PREVIEW_LINK"] = "Show Collection button in mount preview"--]] 
L["SETTING_SHOP_BUTTON"] = "구매 버튼 활성화"
--[[Translation missing --]]
--[[ L["SETTING_SHOW_USAGE"] = "Display mount usage statistics"--]] 
--[[Translation missing --]]
--[[ L["SETTING_TRACK_USAGE"] = "Track mount usage behavior on all characters"--]] 
L["SETTING_YCAMERA"] = "표시 화면에서 마우스로 Y 축 회전 잠금 해제"

-- Families
L["Airplanes"] = "비행기"
L["Airships"] = "비행선"
L["Alpacas"] = "알파카"
L["Amphibian"] = "양서류"
--[[Translation missing --]]
--[[ L["Animite"] = "Animite"--]] 
L["Aqir Flyers"] = "아퀴르 날벌레"
L["Arachnids"] = "거미"
L["Assault Wagons"] = "공성차량"
L["Basilisks"] = "바실리스크"
L["Bats"] = "박쥐"
L["Bears"] = "곰"
L["Bees"] = "벌"
L["Birds"] = "새"
L["Blood Ticks"] = "흡혈충"
L["Boars"] = "멧돼지"
L["Bovids"] = "노루"
L["Brutosaurs"] = "브루토사우루스"
L["Camels"] = "낙타"
L["Carnivorans"] = "육식동물"
L["Carpets"] = "카페트"
L["Cats"] = "고양이과"
L["Chargers"] = "군마"
L["Chickens"] = "닭"
L["Clefthooves"] = "갈래발굽"
L["Cloud Serpents"] = "운룡"
L["Core Hounds"] = "심장부사냥개"
L["Crabs"] = "게"
L["Cranes"] = "학"
L["Crawgs"] = "크로그"
L["Crocolisks"] = "크로코리스크"
L["Crows"] = "까마귀"
L["Demonic Hounds"] = "지옥사냥개"
L["Demonic Steeds"] = "지옥군마"
L["Demons"] = "악마"
L["Dinosaurs"] = "공룡"
L["Dire Wolves"] = "다이어울프"
L["Direhorns"] = "다이어혼"
L["Discs"] = "원반"
L["Dragonhawks"] = "용매"
L["Drakes"] = "비룡"
L["Dread Ravens"] = "지옥까마귀"
L["Elekks"] = "엘레크"
L["Elementals"] = "정령"
L["Falcosaurs"] = "팔코사우루스"
L["Fathom Rays"] = "심해 가오리"
L["Feathermanes"] = "뾰족갈기"
L["Felsabers"] = "지옥표범"
L["Fish"] = "물고기"
L["Flying Steeds"] = "비행군마"
L["Foxes"] = "여우"
--[[Translation missing --]]
--[[ L["Gargon"] = "Gargon"--]] 
L["Goats"] = "염소"
--[[Translation missing --]]
--[[ L["Gorger"] = "Gorger"--]] 
--[[Translation missing --]]
--[[ L["Gorm"] = "Gorm"--]] 
L["Grand Drakes"] = "거대 비룡"
L["Gronnlings"] = "그론링"
L["Gryphons"] = "그리폰"
L["Gyrocopters"] = "자이로콥터"
L["Hawkstriders"] = "매타조"
L["Hippogryphs"] = "히포그리프"
L["Horned Steeds"] = "뿔 군마"
L["Horses"] = "말"
L["Hounds"] = "사냥개"
L["Hovercraft"] = "호버크래프트"
L["Humanoids"] = "휴머노이드"
L["Hyenas"] = "하이에나"
L["Infernals"] = "지옥불정령"
L["Insects"] = "곤충"
L["Jellyfish"] = "해파리"
L["Jet Aerial Units"] = "제트 비행기"
L["Kites"] = "연"
L["Kodos"] = "코도"
L["Krolusks"] = "크롤러스크"
--[[Translation missing --]]
--[[ L["Larion"] = "Larion"--]] 
L["Lions"] = "사자"
L["Mammoths"] = "매머드"
L["Mana Rays"] = "마나 가오리"
L["Manasabers"] = "마나호랑이"
L["Mechanical Animals"] = "기계형 야수"
L["Mechanical Birds"] = "기계형 새"
L["Mechanical Cats"] = "기계형 고양이"
L["Mechanical Steeds"] = "기계형 군마"
L["Mechanostriders"] = "기계타조"
L["Mecha-suits"] = "메카수트"
L["Moose"] = "엘크"
--[[Translation missing --]]
--[[ L["Moth"] = "Moth"--]] 
L["Motorcycles"] = "오토바이"
L["Mountain Horses"] = "산악마"
L["Mushan"] = "무샨"
L["Nether Drakes"] = "황천의 비룡"
L["Nether Rays"] = "황천 가오리"
L["N'Zoth Serpents"] = "느조스 뱀"
L["Others"] = "기타"
L["Pandaren Phoenixes"] = "판다렌 불사조"
L["Parrots"] = "앵무새"
L["Phoenixes"] = "불사조"
L["Proto-Drakes"] = "원시 비룡"
L["Pterrordaxes"] = "테러닥스"
L["Quilen"] = "기렌"
L["Rams"] = "산양"
L["Raptors"] = "랩터"
L["Rats"] = "쥐"
L["Ravagers"] = "칼날발톱"
L["Rays"] = "가오리"
L["Reptiles"] = "파충류"
L["Rhinos"] = "코뿔소"
L["Riverbeasts"] = "강물하마"
--[[Translation missing --]]
--[[ L["Roc"] = "Roc"--]] 
L["Rockets"] = "로켓"
L["Ruinstriders"] = "파멸발굽"
--[[Translation missing --]]
--[[ L["Runestag"] = "Runestag"--]] 
L["Rylaks"] = "라일라크"
L["Sabers"] = "표범"
L["Scorpions"] = "전갈"
L["Sea Serpents"] = "바다뱀"
L["Seahorses"] = "해마"
--[[Translation missing --]]
--[[ L["Seat"] = "Seat"--]] 
L["Silithids"] = "실리시드"
L["Snapdragons"] = "치악룡"
L["Spider Tanks"] = "거미 전차"
L["Spiders"] = "거미"
L["Steeds"] = "군마"
L["Stingrays"] = "독침가오리"
L["Stone Cats"] = "고양이 석상"
L["Stone Drakes"] = "비룡 석상"
L["Talbuks"] = "탈부크"
L["Tallstriders"] = "타조"
L["Talonbirds"] = "탈론 버드"
--[[Translation missing --]]
--[[ L["Tauralus"] = "Tauralus"--]] 
L["Tigers"] = "호랑이"
L["Toads"] = "두꺼비"
L["Turtles"] = "거북이"
L["Undead Drakes"] = "언데드 비룡"
L["Undead Steeds"] = "언데드 군마"
L["Undead Wolves"] = "언데드 늑대"
L["Ungulates"] = "유제류"
L["Ur'zul"] = "우르줄"
L["Vehicles"] = "차량"
--[[Translation missing --]]
--[[ L["Vulpin"] = "Vulpin"--]] 
--[[Translation missing --]]
--[[ L["Vultures"] = "Vultures"--]] 
L["War Wolves"] = "전투 늑대"
L["Water Striders"] = "소금쟁이"
L["Wind Drakes"] = "바람 비룡"
L["Wolfhawks"] = "늑대매"
L["Wolves"] = "늑대"
L["Wyverns"] = "와이번"
L["Yaks"] = "야크"
L["Yetis"] = "예티"

