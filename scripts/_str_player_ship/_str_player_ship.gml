function PlayerShip(_x, _y, _data, _ship_name, _faction) : Ship(_x, _y, _data, _ship_name, _faction) constructor {
    static update = function(_inputs) {
        run_state(_inputs);
        run_gun_state(_inputs);
        image_angle = (guns_state == guns_system.LOCKED_IN)
         ? point_direction(draw_x, draw_y, locked_target.x,     locked_target.y) : transform.angle;
        apply_movement(image_angle);
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
                //scr_guns_free(self, _inputs);
                exit
                break;
            case guns_system.LOCKED_IN:
                //scr_guns_locked(self, _inputs);
                break;
        }
    }
}