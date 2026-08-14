if (obj_selection_box.selector.entity != noone) {
    var _entity = obj_selection_box.selector.entity;
    var _info = _entity.infoData;
    var _fields = _info.fields;
    draw_set_font(Font1);

    var _i = 0;
    var _pos_x = _entity.x + _entity.sprite_width;
    var _pos_y = _entity.y - _entity.sprite_height;

    draw_sprite(spr_dialogbox_square, -1, _pos_x -5,  _pos_y -5);
    
    repeat (array_length(_fields)) {
        draw_text_ext( _pos_x,  _pos_y, string(_fields[_i].label) + ": " +  string(_fields[_i].value),  30, 300 );

        _pos_y += 8 ;
        _i++;
    }
    
    if (variable_struct_exists(_info, "children")) {
        var _children = _info.children[0];
           var _child_fields = _children.fields;
        
        var _j = 0;
         
        repeat (array_length(_child_fields)) {
        draw_text_ext( _pos_x,  _pos_y, string(_child_fields[_j].label) + ": " +  string(_child_fields[_j].value),  30, 300 );

        _pos_y +=  8;
        _j++;
     }
    }
}