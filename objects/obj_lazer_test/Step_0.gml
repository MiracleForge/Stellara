if (laser == noone) exit;

var _still_alive = laser.update();
x = laser.x;
y = laser.y;

if (!_still_alive) {
    instance_destroy();
    exit;
}

if (!obj_player.shoot_lazer) {
    instance_destroy();
}