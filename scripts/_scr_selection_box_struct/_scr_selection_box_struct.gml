function SelectionBox() constructor {
    entity = noone;
    pos_x = mouse_x;
    pos_y = mouse_y;

    sprite_w = sprite_get_width(spr_selector_default);
    sprite_h = sprite_get_height(spr_selector_default);

    selectorXOffset  = sprite_get_xoffset(spr_selector_default);
    selectorYOffset  = sprite_get_yoffset(spr_selector_default);
    selectorFrameCount = sprite_get_number(spr_selector_default);

    selectorColor = c_white;
    fontColor = c_white;
    image_index = 0;
    image_speed = 0.06;
    is_hovering = false;

    selectorTopRightX = 0;
    selectorTopRightY = 0;

    _scale = 1;
    _scaledW = 0;
    _scaledXOff = 0;
    _scaledYOff = 0;

    update = function() {
        pos_x = mouse_x;
        pos_y = mouse_y;

        var _who = instance_position(pos_x, pos_y, obj_clickable);
        is_hovering = (_who && entity != _who);
        image_index += image_speed;
        if (image_index >= selectorFrameCount) image_index = 0;
    };

    reset = function() {
        entity = noone;
        selectorColor = c_white;
        fontColor = c_white;
    };


    updateSelectorMetrics = function() {
        if (entity == noone) return;
        _scale = clamp( max( entity.sprite_width / sprite_w, entity.sprite_height / sprite_h ) * 1.3, 1, 4 );
        _scaledW    = sprite_w * _scale;
        _scaledXOff = selectorXOffset * _scale;
        _scaledYOff = selectorYOffset * _scale;
    };

    selectOnClick = function() {
        if (mouse_check_button_pressed(mb_left)) {
            var clicked = instance_position(pos_x, pos_y, obj_clickable);

            if (clicked == entity) {
                reset();
            } else if (clicked != noone) {
                entity = clicked;
                var _colors = getSelectableColor(entity);
                selectorColor = _colors.selector;
                fontColor = _colors.text;
                updateSelectorMetrics(); 
            } else {
                reset();
            }
        }
    };

    getSelectableColor = function(_entity) {
        var _type = _entity.infoData.type;
        return getEntityTypeColor(_type);
    };

    static draw = function() {

        if (entity != noone) {
            selectorTopRightX = (entity.x - _scaledXOff) + _scaledW;
            selectorTopRightY = entity.y - _scaledYOff;

            draw_sprite_ext(spr_selector_default, -1, entity.x, entity.y, _scale, _scale, 0, selectorColor, SELECTOR_ALPHA);
        }
        
       var _selector = is_hovering ? spr_selector_default : spr_selector_hover;
           draw_sprite_ext(_selector, image_index, pos_x, pos_y, 1, 1, -1, c_white, SELECTOR_ALPHA);
    };
}