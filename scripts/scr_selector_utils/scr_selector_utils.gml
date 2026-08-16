function rebuild_selection_cache(_entity)
{
    var _info = _entity.infoData;
    var _fields = _info.fields;
    var _has_children = variable_struct_exists(_info, "children");
    var _child_fields = _has_children ? _info.children[0].fields : [];
    var _field_count = array_length(_fields);
    var _child_count = _has_children ? array_length(_child_fields) : 0;
    var _total_count = _field_count + _child_count;

    var _all_fields = array_create(_total_count);
    array_copy(_all_fields, 0, _fields, 0, _field_count);
    if (_has_children) {
        array_copy(_all_fields, _field_count, _child_fields, 0, _child_count);
    }

    draw_set_font(global.my_font.infopanel);

    var _line_height = string_height("Ag") + BOX_LINE_SPACING;
    var _text_width = 0;

    selection_lines = array_create(_total_count);
    for (var _i = 0; _i < _total_count; _i++) {
        var _line = string(_all_fields[_i].label) + ": " + string(_all_fields[_i].value);
        selection_lines[_i] = _line;
        _text_width = max(_text_width, string_width(_line));
    }

    selection_line_height = _line_height;
    selection_box_w = _text_width + BOX_PAD_X * 2;
    selection_box_h = (_line_height * _total_count) + BOX_PAD_TOP + BOX_PAD_BOTTOM;
    selection_box_scale_x = selection_box_w / box_square_w;
    selection_box_scale_y = selection_box_h / box_square_h;
}