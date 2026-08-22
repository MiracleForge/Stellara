if (instance_exists(target)) {
    var _dist = point_distance(x, y, target.x, target.y);
    image_angle = point_direction(obj_player.x, obj_player.y, target.x, target.y);
    
    x = obj_player.player.ship.draw_x
    y = obj_player.player.ship.draw_y
    
    image_xscale = _dist / sprite_width;
}

image_yscale = random_range(0.9, 1.1)
if (!obj_player.shoot_lazer) {
    instance_destroy();
}
