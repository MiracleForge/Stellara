var _inputs = undefined;
var _has_input = false;

var _js = instance_find(obj_joy_stick, 0);

if (_js != noone && _js.is_active) {
    _inputs = _js.get_inputs();
    _has_input = true;
}
    
player.ship.update(_inputs, _has_input);

x += player.ship.physics.hspeed;
y += player.ship.physics.vspeed;

image_angle = player.ship.transform.angle;