if (!surface_exists(trail_surf)) trail_surf = surface_create(room_width, room_height);

// remove carimbos expirados (de trás pra frente, seguro pra remover em loop)
for (var i = array_length(stamps) - 1; i >= 0; i--) {
    if (current_time - stamps[i].born_time >= trail_duration_ms) {
        array_delete(stamps, i, 1);
    }
}

surface_set_target(trail_surf);
    draw_clear_alpha(c_black, 0);
    var _count = array_length(stamps);
    for (var i = 0; i < _count; i++) {
        var _s = stamps[i];
        var _age = current_time - _s.born_time;
        var _alpha = clamp(1 - (_age / trail_duration_ms), 0, 1);
        draw_set_alpha(_alpha);
        draw_circle_color(_s.x, _s.y, _s.radius, _s.color, _s.color, false);
    }
    draw_set_alpha(1);
surface_reset_target();


    //if (variable_global_exists("trail_manager") && instance_exists(global.trail_manager)) {
        //// calcula um ponto atrás da nave (popa), baseado no ângulo atual
        //var _rear_offset = 12; // ajuste conforme o tamanho do sprite da nave
        //var _rear_x = x - lengthdir_x(_rear_offset, transform.angle);
        //var _rear_y = y - lengthdir_y(_rear_offset, transform.angle);
//
        //global.trail_manager.request_stamp(_rear_x, _rear_y, trail_color, trail_radius);
    //}
//}