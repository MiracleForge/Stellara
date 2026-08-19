function ShipNPC(_x, _y, _data, _ship_name, _faction) : Ship(_x, _y, _data, _ship_name, _faction) constructor {
    ai_target_x = x + room_width
    ai_target_y = y;
    static autopilot = function() {
        var _dist = point_distance(x, y, ai_target_x, ai_target_y);
        if (_dist < 4) return; 
        var _dir = point_direction(x, y, ai_target_x, ai_target_y);
        physics.hspeed = lengthdir_x(stats.max_speed, _dir);
        physics.vspeed = lengthdir_y(stats.max_speed, _dir);
        transform.angle = _dir;
    }
    static update = function() {
        switch (state) {
            case space_ship_mov.DRIVE:
                autopilot();
                break;
        }
        apply_movement();
    }
}