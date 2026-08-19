function PlayerShip(_x, _y, _data, _ship_name, _faction) : Ship(_x, _y, _data, _ship_name, _faction) constructor {
    static update = function(_inputs) {
        run_state(_inputs);
        run_gun_state(_inputs);
        apply_movement();
    }
    static run_state = function(_inputs) {
        switch (state) {
            case space_ship_mov.DRIVE:
                scr_drive(self, _inputs);
                break;
        }
    }
    static run_gun_state = function(_inputs) {
        switch (guns_state) {
            case guns_system.FREE:
                exit
                break;
            case guns_system.LOCKED_IN:
                break;
        }
    }
}