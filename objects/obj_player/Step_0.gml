var _inputs = (joystick != noone) ? joystick.get_inputs() : { active: false, x: 0, y: 0 };

player.ship.update(_inputs);
x += player.ship.physics.hspeed;
y += player.ship.physics.vspeed;
image_angle = player.ship.transform.angle;