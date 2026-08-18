if (!is_active) exit;

draw_set_alpha(0.5);
draw_circle(joy_x, joy_y, JOYSTICK_KNOB, false);
draw_set_alpha(0.3);

draw_circle(joy_x + move_x, joy_y + move_y, 8, false);
draw_set_alpha(1);