function rebuild_selection_cache(_entity)
{
    var _info = _entity.infoData;
    var _fields = _info.fields;
    var _has_children = variable_struct_exists(_info, "children");

    // junta os fields do nível raiz + fields de TODOS os children
    var _all_fields = array_create(0);
    array_copy(_all_fields, array_length(_all_fields), _fields, 0, array_length(_fields));

    if (_has_children) {
        var _children = _info.children;
        var _child_count = array_length(_children);
        for (var _c = 0; _c < _child_count; _c++) {
            var _child_fields = _children[_c].fields;
            var _len_before = array_length(_all_fields);
            array_resize(_all_fields, _len_before + array_length(_child_fields));
            array_copy(_all_fields, _len_before, _child_fields, 0, array_length(_child_fields));
        }
    }

    var _total_count = array_length(_all_fields);

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