target = noone;
laser = noone;

set_target = function(_target) {
    target = _target;
    if (laser == noone) {
        laser = new LaserController(obj_player, target);
    } else {
        laser.set_target(target);
    }
}