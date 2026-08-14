function rebuild_selection_cache(_entity)
{
    var _info = _entity.infoData;
    var _fields = _info.fields;

    var _has_children = variable_struct_exists(_info, "children");
    var _child_fields = _has_children ? _info.children[0].fields : [];

    var _field_count = array_length(_fields);
    var _child_count = array_length(_child_fields);
    var _total_count = _field_count + _child_count;

    var _all_fields = array_create(_total_count);
    for (var _i = 0; _i < _field_count; _i++) {
        _all_fields[_i] = _fields[_i];
    }
    for (var _j = 0; _j < _child_count; _j++) {
        _all_fields[_field_count + _j] = _child_fields[_j];
    }

    draw_set_font(ft_info_panel);
    var _line_height = string_height("Ag") + BOX_LINE_SPACING;
    var _text_width = 0;

    selection_lines = array_create(_total_count);
    for (var _i = 0; _i < _total_count; _i++) {
        var _text = string(_all_fields[_i].label) + ": " + string(_all_fields[_i].value);
        selection_lines[_i] = _text;
        _text_width = max(_text_width, string_width(_text));
    }

    selection_line_height = _line_height;
    selection_box_w = _text_width + BOX_PAD_X * 2;
    selection_box_h = (_line_height * _total_count) + BOX_PAD_TOP + BOX_PAD_BOTTOM;
}