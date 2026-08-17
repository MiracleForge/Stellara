var _inputs = (joystick != noone)
    ? joystick.get_inputs()
    : keyboard_input.get_inputs();

player.ship.update(_inputs);

x += player.ship.physics.hspeed;
y += player.ship.physics.vspeed;

image_angle = player.ship.transform.angle;

draw_x = round(x);
draw_y = round(y);

var _speed = point_distance(
    0,
    0,
    player.ship.physics.hspeed,
    player.ship.physics.vspeed
);

if (_speed > 0.01)
{
    trail_update(x, y);
    trail_fade_timer = 0;
}
else
{
    trail_fade_timer += delta_time;

    if (trail_fade_timer >= trail_fade_speed * 1000)
    {
        if (array_length(trail_x) > 0)
        {
            array_pop(trail_x);
            array_pop(trail_y);
        }

        trail_fade_timer = 0;
    }
}