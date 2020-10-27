local AddonName, Addon = ...

if (GetLocale() == "deDE") then
    Addon.Loc = {
        Title = "Mechagon",
        Drills = {
            ["Prefix"] = "Bohrer aktiv bei",
            "DR-TR28",
            "DR-TR35",
            "DR-CC61",
            "DR-CC73",
            "DR-CC88",
            "DR-JD41",
            "DR-JD99",
        },
        Armories = "Arsenal gefunden bei",
        Rares = {
            [151934] = "Arachnoider Ernter",
            [150394] = "Panzertresorbot",
            [153200] = "Siedebrand",
            [151308] = "Boggac Schädelrums",
            [152001] = "Knochenpicker",
            [154739] = "Ätzender Mechaschleim",
            [151569] = "Tiefseeschlund",
            [150342] = "Erdbrecher Gulroc",
            [154153] = "Vollstrecker KX-T57",
            [151202] = "Üble Manifestation",
            [151884] = "Fungianischer Furor",
            [135497] = "Fungianischer Furor",
            [153228] = "Getriebeprüfer Radstern",
            [153205] = "Splitterzid",
            [154701] = "Vollgefressener Ritzelknabberer",
            [151684] = "Kieferbrecher",
            [152007] = "Todessäge",
            [151933] = "Defekter Gorillabot",
            [151124] = "Mechagonischer Nullifizierer",
            [151672] = "Mecharantel",
            [151627] = "Herr Richter",
            [151296] = "OOX-Rächer/MG",
            [153206] = "Alter Großhauer",
            [152764] = "Oxidierte Egelbestie",
            [151702] = "Paol Teichwandler",
            [150575] = "Rumpelfels",
            [152182] = "Rostfeder",
            [155583] = "Schrottklaue",
            [150937] = "Seespuck",
            [153000] = "Funkenkönigin P'Emp",
            [153226] = "Stahlsängerin Freza",
            [155060] = "Doppelgänger",
            [152113] = "Der Kleptoboss",
            [151940] = "Onkel T'Rogg",
            [151625] = "Der Schrottkönig",
            [151623] = "Der Schrottkönig (aufgemountet)",
            [154342] = "Arachnoider Ernter (alternative Zeitlinie)",
            [154225] = "Der rostige Prinz (alternative Zeitlinie)",
            [154968] = "Panzertresorbot (alternative Zeitlinie)",
            [152569] = "Wahnsinniger Trogg (grün)",
            [152570] = "Wahnsinniger Trogg (blau)",
            [149847] = "Wahnsinniger Trogg (orange)",
        },
        Config = {
            ["Armory"] = {
                "Meldung für Arsenale aktivieren",
                "Schaltet die Ankündigung von Arsenalen in den Allgemein-Channel ein bzw. aus.",
            },
            ["Drills"] = {
                "Meldung für Bohrer aktivieren",
                "Schaltet die Ankündigung für neu gespawnte Bohrer ein bzw. aus.",
            },
            ["DrillSounds"] = {
                "Ton für Bohrer aktivieren",
                "Schaltet den Ton für neu gespawnte Bohrer ein bzw. aus."
            },
            ["DrillWaypoints"] = {
                "Wegpunkte für Bohrer aktivieren",
                "Schaltet die automatische Erstellung von Tom-Tom Wegpunkten für neu gespawnte Bohrer an bzw. aus.",
            }
        },
    }
end