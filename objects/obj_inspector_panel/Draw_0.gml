if (obj_selection_box.selector.entity != noone) {
    var _entity = obj_selection_box.selector.entity;
    var _selector_color = obj_selection_box.selector.selectorColor;
    var _font_color = obj_selection_box.selector.fontColor;
    if (_entity != selection_cache_entity)
    {
        selection_cache_entity = _entity;
        rebuild_selection_cache(_entity);
    }
    var _selector = obj_selection_box.selector;

    // deslocamento do tip (ajuste esses valores ao seu gosto)
    var _tip_offset_x = -8; // negativo = mais pra esquerda
    var _tip_offset_y = -6; // negativo = mais pra cima

    // ponto de conexão real: top-right do selector, já deslocado
    var _origin_x = _selector.selectorTopRightX + _tip_offset_x;
    var _origin_y = _selector.selectorTopRightY + _tip_offset_y;

    draw_set_font(ft_info_panel);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_colour(_font_color)

    // tip começa no origin (já deslocado), centralizado verticalmente no próprio sprite do tip
    draw_sprite_ext(spr_tip, -1, _origin_x, _origin_y - (tip_h / 2), 1, 1, -1, _selector_color, BOX_ALPHA);

    // box começa onde o tip termina, continua conectado pois usa o mesmo _origin_x/_origin_y
    selection_box_x = _origin_x + tip_w;
    selection_box_y = _origin_y - (selection_box_h / 2);

    draw_sprite_ext(BOX_SQUARE, -1, selection_box_x, selection_box_y,
        selection_box_w / box_square_w,
        selection_box_h / box_square_h,
        0, _selector_color, BOX_ALPHA);

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