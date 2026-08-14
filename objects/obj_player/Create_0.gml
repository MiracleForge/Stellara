joystick = instance_find(obj_joy_stick, 0);
// Create Event
keyboard_input = (joystick == noone) ? new KeyboardInput() : noone;
player = new Player("Paulo",  global.ship_types.uss_cerulean);
infoData = player.getInfo();