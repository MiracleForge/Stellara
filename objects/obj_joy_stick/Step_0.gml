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
    
    if (point_distance(0, 0, move_x, move_y) > max_radius) {
        var _dir = point_direction(0, 0, move_x, move_y);
        move_x = lengthdir_x(max_radius, _dir);
        move_y = lengthdir_y(max_radius, _dir);
    }
}

//if (obj_player_parent.player.ship.hyper_state == hyper_drive_state.charging) {
    //anim_timer += delta_time * 0.000001; // converte pra segundos
    //if (anim_timer >= anim_spd) {
        //anim_timer = 0;
        //anim_frame = (anim_frame + 1) % sprite_get_number(spr_joystick_count);
    //}
//} else {
    //anim_timer = 0;
    //anim_frame = 0; // reseta ao sair do estado
//}