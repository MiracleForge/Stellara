function PlayerShip(_x, _y, _data, _ship_name, _faction) : Ship(_x, _y, _data, _ship_name, _faction) constructor {

    static update = function(_inputs) {
        switch (state) {
            case space_ship_state.DRIVE:
                scr_drive(self, _inputs);
                break;
        }
        apply_movement();
    }
}