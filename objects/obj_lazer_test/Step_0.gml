// Step do laser
life_timer++;

var _t = clamp(life_timer / jitter_decay_time, 0, 1);
current_jitter = lerp(jitter_start, jitter_end, _t);

if (instance_exists(target)) {
    x = obj_player.player.ship.draw_x;
    y = obj_player.player.ship.draw_y;

    image_angle = point_direction(x, y, target.x, target.y); // só se ainda usar sprite/collision
} else {
    instance_destroy();
    exit; // evita rodar o resto do código depois de destruir a instância
}

if (!obj_player.shoot_lazer) {
    instance_destroy();
}