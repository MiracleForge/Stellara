if (obj_selection_box.selector.entity != noone)
{
    var _entity = obj_selection_box.selector.entity;

    if (_entity != selection_cache_entity)
    {
        selection_cache_entity = _entity;
        rebuild_selection_cache(_entity);
    }

    selection_box_x = _entity.x + _entity.sprite_width;
    selection_box_y = _entity.y - _entity.sprite_height;

    draw_set_font(ft_info_panel);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    draw_sprite_ext(BOX_SQUARE, -1, selection_box_x, selection_box_y,
        selection_box_w / sprite_get_width(BOX_SQUARE),
        selection_box_h / sprite_get_height(BOX_SQUARE),
        0, c_white, BOX_ALPHA);

    var _text_x = selection_box_x + BOX_PAD_X;
    var _text_y = selection_box_y + BOX_PAD_TOP;
    
    for (var _i = 0; _i < array_length(selection_lines); _i++)
    {
        draw_text(_text_x, _text_y, selection_lines[_i]);
        _text_y += selection_line_height;
    }

    draw_set_font(-1);
}