    identity = {
        transponder_active: true,
        name: "Test",
        faction: factions.pirates,
        hostility: 0
    };

infoData =   {
            type: "ship",
            faction: identity.faction,
            transponder: identity.transponder_active,
            
     fields: [
                {
                    label: "Pilote",
                    value: "Va'lar"
                },
                {
                    label: "Name",
                    value: "Maca'zin"
                },
                {
                    label: "Class",
                    value: "Destroyer"
                },
                  {
                    label: "Faction",
                    value: global.faction_data[identity.faction].name
                }
            ],
        }