    trail_steps = 50;

trail_x = [];
trail_y = [];

array_resize(trail_x, trail_steps);
array_resize(trail_y, trail_steps);

trail_count = 0;

trail_fade_speed = 30;
trail_fade_timer = 0;
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