var _inputs = (joystick != noone)
    ? joystick.get_inputs()
    : keyboard_input.get_inputs();

player.ship.update(_inputs);

x = player.ship.x;
y = player.ship.y;
image_angle = player.ship.transform.angle;