var radius = 50;

if (!is_active) exit;

//if (obj_player.ship.hyper_state == hyper_drive_state.charging) {
    //var scale = (radius * 2) / 450;
    //draw_sprite_ext(spr_joystick_count, anim_frame, joy_x, joy_y, scale, scale, -1, c_white, 1);
//}

draw_set_alpha(0.5);
draw_circle(joy_x, joy_y, radius, false);
draw_set_alpha(0.3);
draw_circle(joy_x + move_x, joy_y + move_y, 15, false);
draw_set_alpha(1);