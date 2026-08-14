if (obj_selection_box.selector.entity != noone) {
    var _entity = obj_selection_box.selector.entity;
    var _info = _entity.infoData;
  

    draw_set_font(Font1);

    draw_text_ext(
        _entity.x + _entity.sprite_width,
        _entity.y - _entity.sprite_height,
        string(_info),
        30,
        300
    );
}