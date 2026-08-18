if (mouse_check_button_pressed(mb_left)) {
    joy_x = mouse_x;
    joy_y = mouse_y;
    
    move_x = 0;
    move_y = 0;
    
    is_active = true;
}

if (mouse_check_button_released(mb_left)) {
    move_x = 0;
    move_y = 0;
    
    is_active = false;
}

if (is_active) {
    move_x = mouse_x - joy_x;
    move_y = mouse_y - joy_y;
    
    if (point_distance(0, 0, move_x, move_y) > JOYSTICK_BASE) {
        var _dir = point_direction(0, 0, move_x, move_y);
        move_x = lengthdir_x(JOYSTICK_BASE, _dir);
        move_y = lengthdir_y(JOYSTICK_BASE, _dir);
    }
}