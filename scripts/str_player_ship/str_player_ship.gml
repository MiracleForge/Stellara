enum space_ship_state {
    DRIVE,
    HYPER_DRIVE,
    DESTROYED
};

function PlayerShip(_data)
constructor
{
    data = _data;

    sprite = data.sprite;

    stats = data.stats;


    state = space_ship_state.DRIVE;


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
}