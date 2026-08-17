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
    selector_state = "default";
    
    locked_image_index = 0;
    locked_image_speed = 0.4;
    
    is_hovering = false;
    hovered_instance = noone;

    selectorTopRightX = 0;
    selectorTopRightY = 0;

    _scale = 1;
    _scaledW = 0;
    _scaledXOff = 0;
    _scaledYOff = 0;

    
static update = function() {
    pos_x = mouse_x;
    pos_y = mouse_y;

    hovered_instance = instance_position(pos_x, pos_y, obj_clickable);
    is_hovering = (hovered_instance != noone && entity != hovered_instance);

    image_index += image_speed;

    if (image_index >= selectorFrameCount) image_index = 0;

    switch (selector_state) {
    case "locking":
    
        locked_image_index += locked_image_speed;
    
        var _last_frame = sprite_get_number(spr_selector_locked) - 1;
    
        if (locked_image_index >= _last_frame) {
            locked_image_index = _last_frame;
            selector_state = "locked";
        }
    
    break;

        case "unlocking":
            locked_image_index -= locked_image_speed;

            if (locked_image_index <= 0) {
                locked_image_index = 0;
                selector_state = "default";
                reset();
            }
        break;
    }
};

    
   static reset = function() {
        entity = noone;
        selectorColor = c_white;
        fontColor = c_white;
    };


  static  updateSelectorMetrics = function() {
        if (entity == noone) return;
        _scale = clamp( max( entity.sprite_width / sprite_w, entity.sprite_height / sprite_h ) * 1.3, 1, 4 );
        _scaledW    = sprite_w * _scale;
        _scaledXOff = selectorXOffset * _scale;
        _scaledYOff = selectorYOffset * _scale;
    };

    
static selectOnClick = function() {
    if (!mouse_check_button_pressed(mb_left)) return;

     var _clicked = hovered_instance;

    if (_clicked == noone || _clicked == entity) {

        if (entity != noone) selector_state = "unlocking";

    } else {

        entity = _clicked;

        getSelectableColor(entity);
        updateSelectorMetrics();

        locked_image_index = 0;
        selector_state = "locking";
    }
};

    
static getSelectableColor = function(_entity) {
    var _type = _entity.infoData.type;

    if (_type == "ship_entity" || _type == "player") {
        var _faction = _entity.infoData.faction;

        if (_entity.infoData.transponder) {
            var _faction_data = global.faction_data[_faction];

            selectorColor = _faction_data.transponder.color;
            fontColor = _faction_data.transponder.text;
        }
        else {
            selectorColor = c_yellow;
            fontColor = c_yellow;
        }
        return;
    }

    selectorColor = c_white;
    fontColor = c_white;
};

    
  static draw = function() {

    if (entity != noone) {

        selectorTopRightX = (entity.x - _scaledXOff) + _scaledW;
        selectorTopRightY = entity.y - _scaledYOff;

        if (selector_state != "default") {
            draw_sprite_ext( spr_selector_locked, floor(locked_image_index), entity.x, entity.y, _scale, _scale, 0, selectorColor, SELECTOR_ALPHA );
        }
    }

    var _selector = is_hovering ? spr_selector_default : spr_selector_hover;

    draw_sprite_ext( _selector, image_index, pos_x, pos_y, 1, 1, 0, c_white, SELECTOR_ALPHA );
};
}