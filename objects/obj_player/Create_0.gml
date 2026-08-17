joystick = instance_find(obj_joy_stick, 0);
keyboard_input = (joystick == noone) ? new KeyboardInput() : noone;

player = new Player( "Sole", global.ship_types.uss_cerulean, "Fox", factions.federation );

infoData = player.getTransponder ();

draw_x = 0;
draw_y = 0;

trail_steps = 20;

trail_x = [];
trail_y = [];

array_resize(trail_x, trail_steps);
array_resize(trail_y, trail_steps);

trail_count = 0;

trail_fade_speed = 30;
trail_fade_timer = 0;
