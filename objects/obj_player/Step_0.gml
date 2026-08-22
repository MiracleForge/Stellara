var _inputs = obj_input.input_data.get_inputs();

player.ship.update(_inputs);

x = player.ship.x;
y = player.ship.y;



if (mouse_check_button(mb_left)) {
    shoot_lazer = true;
    if (!instance_exists(obj_ship_lazer)) {
        var _laser = instance_create_layer(x, y, "Instances", obj_lazer_test);
        _laser.target = player.ship.locked_target;

        with (_laser) {
            x = obj_player.player.ship.draw_x;
            y = obj_player.player.ship.draw_y;
        }
    }
} else {
    shoot_lazer = false;
}
