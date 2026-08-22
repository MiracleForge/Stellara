var _inputs = obj_input.input_data.get_inputs();

player.ship.update(_inputs);

x = player.ship.x;
y = player.ship.y;



if (mouse_check_button(mb_left) && instance_exists(player.ship.locked_target)) {
    shoot_lazer = true;
    obj_laser_manager.fire(id, player.ship.locked_target, "eletric", c_blue);
} else {
    shoot_lazer = false;
    obj_laser_manager.stop(id);
}