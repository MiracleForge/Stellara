if (obj_selection_box.selector.entity != noone) {
    var _entity = obj_selection_box.selector.entity;
    var _info = _entity.infoData;

    draw_set_font(Font1);

    draw_text_ext(
        _entity.x,
        _entity.y,
        string(_info),
        30,
        300
    );
}