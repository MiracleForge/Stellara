enum space_ship_state {
    DRIVE,
    HYPER_DRIVE,
    DESTROYED
};

function PlayerShip(_data, _ship_name, _faction)
constructor
{
    data = _data;

    sprite = data.sprite;

    stats = data.stats;

    state = space_ship_state.DRIVE;

    identity = {
        name: _ship_name,
        faction: _faction,
        hostility: 0
    };
    
    transform = {
        angle: 0
    };


    physics = {
        hspeed: 0,
        vspeed: 0,
        angular_velocity: 0
    };


update = function(_inputs)
{
    switch(state)
    {
        case space_ship_state.DRIVE:
            scr_drive(self, _inputs);
        break;
    }
};
    
     getInfo = function()
    {
        return {
            type: "ship",

            fields: [ 
                {
                    label: "Faction",
                    value: global.faction_data[identity.faction].name,
                },
                {
                    label: "Name",
                    value: identity.name,
                },
                {
                    label: "Class",
                    value: data.shipInfo.class,
                },
            ],
        };
    };
}