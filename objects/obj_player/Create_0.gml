joystick = instance_find(obj_joy_stick, 0);
keyboard_input = (joystick == noone) ? new KeyboardInput() : noone;

player = new Player( "Sole", global.ship_types.uss_cerulean, "Fox", factions.federation );

infoData = player.getTransponder ();

draw_x = 0;
draw_y = 0;