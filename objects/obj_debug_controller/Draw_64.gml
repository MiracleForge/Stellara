if (is_debug_active) {

    var _line_h = 16;
    var _selector = obj_selection_box.selector;

    // =========================================================
    // SELECTOR
    // =========================================================

    var _selector_x = 16;
    var _selector_y = 16;

    draw_text_ext_colour(_selector_x, _selector_y, "SELECTOR", _line_h, 300, c_yellow, c_yellow, c_yellow, c_yellow, 1);
    _selector_y += _line_h;

    if (is_struct(_selector)) {

        draw_text_ext_colour(_selector_x, _selector_y, "Entity: " + string(_selector.entity), _line_h, 300, c_white, c_white, c_white, c_white, 1);
        _selector_y += _line_h;

        draw_text_ext_colour(_selector_x, _selector_y, "Hover: " + string(_selector.hovered_instance), _line_h, 300, c_white, c_white, c_white, c_white, 1);
        _selector_y += _line_h;

        draw_text_ext_colour(_selector_x, _selector_y, "State: " + string(_selector.selector_state), _line_h, 300, c_white, c_white, c_white, c_white, 1);
        _selector_y += _line_h;

        draw_text_ext_colour(_selector_x, _selector_y, "Scale: " + string(_selector._scale), _line_h, 300, c_white, c_white, c_white, c_white, 1);
        _selector_y += _line_h;

        // =====================================================
        // TARGET SYSTEM
        // =====================================================

        var _targets = _selector.get_selection_targets();

        draw_text_ext_colour(_selector_x, _selector_y, "TARGET SYSTEM [" + string(array_length(_targets)) + "]", _line_h, 300, c_aqua, c_aqua, c_aqua, c_aqua, 1);
        _selector_y += _line_h;

        if (array_length(_targets) > 0) {

            for (var i = 0; i < array_length(_targets); i++) {

                var _target = _targets[i];
                var _target_text = "[" + string(i) + "] " + string(_target);

                draw_text_ext_colour(_selector_x, _selector_y, _target_text, _line_h, 300, c_white, c_white, c_white, c_white, 1);
                _selector_y += _line_h;
            }

        } else {

            draw_text_ext_colour(_selector_x, _selector_y, "NONE", _line_h, 300, c_white, c_white, c_white, c_white, 1);
            _selector_y += _line_h;
        }

    } else {

        draw_text_ext_colour(_selector_x, _selector_y, "Selector: NONE", _line_h, 300, c_white, c_white, c_white, c_white, 1);
        _selector_y += _line_h;
    }


    // =========================================================
    // CAMERA
    // =========================================================

    var _camera_x = 16;
    var _camera_y = _selector_y + 24;

    draw_text_ext_colour(_camera_x, _camera_y, "CAMERA", _line_h, 300, c_aqua, c_aqua, c_aqua, c_aqua, 1);
    _camera_y += _line_h;

    draw_text_ext_colour(_camera_x, _camera_y, "Position: " + string(VIEW_X) + ", " + string(VIEW_Y), _line_h, 300, c_white, c_white, c_white, c_white, 1);
    _camera_y += _line_h;

    draw_text_ext_colour(_camera_x, _camera_y, "Size: " + string(VIEW_W) + " x " + string(VIEW_H), _line_h, 300, c_white, c_white, c_white, c_white, 1);
    _camera_y += _line_h;

    draw_text_ext_colour(_camera_x, _camera_y, "Center: " + string(VIEW_CENTER_X) + ", " + string(VIEW_CENTER_Y), _line_h, 300, c_white, c_white, c_white, c_white, 1);


    // =========================================================
    // PLAYER
    // =========================================================

    var _player_x = 16;
    var _player_y = _camera_y + 24;

    draw_text_ext_colour(_player_x, _player_y, "PLAYER", _line_h, 300, c_lime, c_lime, c_lime, c_lime, 1);
    _player_y += _line_h;

    draw_text_ext_colour(_player_x, _player_y, "Position: " + string(obj_player.player.ship.draw_x) + ", " + string(obj_player.player.ship.draw_y), _line_h, 300, c_white, c_white, c_white, c_white, 1);
    _player_y += _line_h;
     draw_text_ext_colour(_player_x, _player_y, "player transponder: " + string(obj_player.player.ship.identity.transponder_active), _line_h, 300, c_white, c_white, c_white, c_white, 1);
    

    // =========================================================
    // FPS
    // =========================================================

    var _fps_text = "FPS: " + string(fps);

    draw_text_ext_colour(display_get_gui_width() - string_width(_fps_text) - 16, 16, _fps_text, _line_h, 300, c_red, c_red, c_red, c_red, 1);
}