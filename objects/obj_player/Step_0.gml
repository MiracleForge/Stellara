var _inputs = obj_input.input_data.get_inputs();

player.ship.update(_inputs);

x = player.ship.x;
y = player.ship.y;



if (mouse_check_button(mb_left) && instance_exists(player.ship.locked_target)) {
    shoot_lazer = true;
    if (!instance_exists(active_laser)) {
        active_laser = instance_create_layer(x, y, "ly_guns", obj_lazer_test);
    }
    active_laser.set_target(player.ship.locked_target);
} else {
    shoot_lazer = false;
    if (instance_exists(active_laser)) {
        instance_destroy(active_laser);
    }
    active_laser = noone;
}