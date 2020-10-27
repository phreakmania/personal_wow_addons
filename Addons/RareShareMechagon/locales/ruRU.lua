local AddonName, Addon = ...

if (GetLocale() == "ruRU") then
    Addon.Loc = {
        Title = "Мехагон",
        Drills = {
            ["Prefix"] = "Активная буровая установка",
            "ДЫР-ТР28",
            "ДЫР-ТР35",
            "ДЫР-КК61",
            "ДЫР-КК73",
            "ДЫР-КК88",
            "ДЫР-ДЖ41",
            "ДЫР-ДЖ99",
        },
        Armories = "Оружейная найдена в",
        Rares = {
            [151934] = "Арахноид-пожинатель",
            [150394] = "Бронированный сейфобот",
            [153200] = "Ошпар",
            [151308] = "Боггак Черепокол",
            [152001] = "Костегрыз",
            [154739] = "Едкий механослизень",
            [151569] = "Глубоководный пожиратель",
            [150342] = "Землекрушитель Гулрок",
            [154153] = "Каратель KX-T57",
            [151202] = "Гнусноструй",
            [151884] = "Грозный грибостраж",
            [135497] = "Грозный грибостраж",
            [153228] = "Инспектор экипировки Искраддон",
            [153205] = "Драгоцид",
            [154701] = "Прожорливый пожиратель шестеренок",
            [151684] = "Зубодробитель",
            [152007] = "Циркулятор",
            [151933] = "Неисправный гориллобот",
            [151124] = "Мехагонский нейтрализатор",
            [151672] = "Мехарантул",
            [151627] = "Господин Починятор",
            [151296] = "КПХ-Мститель/МГ",
            [153206] = "Старина Бивень",
            [152764] = "Порождение сточной жижи",
            [151702] = "Паол Пруд-по-колено",
            [150575] = "Маховище",
            [152182] = "Ржавое Перо",
            [155583] = "Хламокоготь",
            [150937] = "Солеплюй",
            [153000] = "Паучиха на прокачку",
            [153226] = "Певица стали Фреза",
            [155060] = "Двойник",
            [152113] = "Клептобосс",
            [151940] = "Дядюшка Т'Рогг",
            [151625] = "Король-над-свалкой",
            [151623] = "Король-над-свалкой (На маунте)",
            [154342] = "Арахноид-пожинатель (Альтернативный Мехагон)",
            [154225] = "Ржавый принц (Альтернативный Мехагон)",
            [154968] = "Бронированный сейфобот (Альтернативный Мехагон)",
            [152569] = "Обезумевший трогг (Зеленый)",
            [152570] = "Обезумевший трогг (Синий)",
            [149847] = "Обезумевший трогг (Оранжевый)",
        },
        Config = {
            ["Armory"] = {
                "Включить оповещения - Оружейные",
                "Включить/Выключить оповещения об оружейных в общий чат",
            },
            ["Drills"] = {
                "Включить оповещения - Буровые установки",
                "Включить/Выключить оповещения о появлении буровой установки",
            },
            ["DrillSounds"] = {
                "Включить звуковые оповещения",
                "Включить/Выключить звуковое оповещение о появлении буровой установки",
            },
            ["DrillWaypoints"] = {
                "Навигация",
                "Включить/Выключить навигацию до буровой установки",
            }
        },
    }
end