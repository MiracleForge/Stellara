var _selector = obj_selection_box.selector;
if (_selector.entity != noone) {
    var _entity = _selector.entity;
    var _selector_color = _selector.selectorColor;
    var _font_color = _selector.fontColor;

    if (_entity != selection_cache_entity) {
        selection_cache_entity = _entity;
        rebuild_selection_cache(_entity);
    }

    var _origin_x = _selector.selectorTopRightX + TIP_OFFSET_X;
    var _origin_y = _selector.selectorTopRightY + TIP_OFFSET_Y;

    draw_set_font(global.my_font.infopanel);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_colour(_font_color);

    draw_sprite_ext(spr_tip, -1, _origin_x, _origin_y - (tip_h / 2), 1, 1, -1, _selector_color, BOX_ALPHA);

    selection_box_x = _origin_x + tip_w;
    selection_box_y = _origin_y - (selection_box_h / 2);

    draw_sprite_ext(BOX_SQUARE, -1, selection_box_x, selection_box_y,
        selection_box_scale_x, selection_box_scale_y,
        0, _selector_color, BOX_ALPHA);
    
    var _box_w_scaled = box_square_w * selection_box_scale_x;
    var _key_y = selection_box_y + box_square_h * selection_box_scale_y;
    
    var _attk_key_x = selection_box_x + _box_w_scaled * 0.8;
    var _talk_key_x = selection_box_x + _box_w_scaled * 0.6;
    
    var _input_type = obj_input.input_data.current_input; 
    var _attk_sprite = global.input_sprite_map.attk[_input_type];
    var _talk_sprite = global.input_sprite_map.talk[_input_type];
    
    draw_sprite_ext(_attk_sprite, -1, _attk_key_x, _key_y, 1, 1, 0, _selector_color, 1);
    draw_sprite_ext(_talk_sprite, -1, _talk_key_x, _key_y, 1, 1, 0, _selector_color, 1);

    var _text_x = selection_box_x + BOX_PAD_X;
    var _text_y = selection_box_y + BOX_PAD_TOP;

    var _count = array_length(selection_lines);
    
    for (var _i = 0; _i < _count; _i++) {
        draw_text(_text_x, _text_y, selection_lines[_i]);
        _text_y += selection_line_height;
    }

    draw_set_font(-1);
    draw_set_colour(c_white);
}