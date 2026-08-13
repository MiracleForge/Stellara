var _inputs = (joystick != noone) ? joystick.get_inputs() : keyboard_input.get_inputs();

player.ship.update(_inputs);

x += player.ship.physics.hspeed;
y += player.ship.physics.vspeed;
image_angle = player.ship.transform.angle;