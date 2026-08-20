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
    
    _selection_targets = [];


 static update = function() {
    pos_x = mouse_x;
    pos_y = mouse_y;

    hovered_instance = instance_position(pos_x, pos_y, obj_clickable);
    is_hovering = (hovered_instance != noone && entity != hovered_instance);

    ConfirmTarget();

    image_index += image_speed;
    image_index = image_index mod selectorFrameCount;

    //  já pertence ao sistema de mira.
    if (entity == noone || isSelectionTarget(entity)) {
        return;
    }

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


    static updateSelectorMetrics = function() {
        if (entity == noone) return;

        _scale = getSelectorScale(entity);

        _scaledW    = sprite_w * _scale;
        _scaledXOff = selectorXOffset * _scale;
        _scaledYOff = selectorYOffset * _scale;
    };


    static selectOnClick = function() {
        if (!mouse_check_button_pressed(mb_left)) return;
    
        var _clicked = hovered_instance;
    
        if (_clicked == noone || _clicked == entity) {
    
            if (entity != noone) {
                selector_state = "unlocking";
            }
    
            return;
        }
    
        entity = _clicked;
    
        getSelectableColor(entity);
        updateSelectorMetrics();
    
        if (isSelectionTarget(entity)) {
            locked_image_index = sprite_get_number(spr_selector_locked) - 1;
            selector_state = "locked";
        }
        else {
            locked_image_index = 0;
            selector_state = "locking";
        }
    };


    static ConfirmTarget = function() {
        if (!INPUT_ATTACK) return;

        var _ship = obj_player.player.ship;
        var _target_entity = hovered_instance;
    
        if (_target_entity == noone || _target_entity == noone) {
            _target_entity = _ship.get_locked_target();
        }
    
        if (_target_entity == noone) {
            _target_entity = entity;
        }
    
        if (_target_entity == noone || _target_entity.infoData.type == "player") return;
    
        if (isSelectionTarget(_target_entity)) {
            remove_selection_target(_target_entity);
            _ship.lock_target(noone);
    
            if (_target_entity == entity) {
                reset();
            }
    
            return;
        }
    
         if (!_ship.can_lock_target(_target_entity)) return;
            
        add_selection_target(_target_entity);
        _ship.lock_target(_target_entity);
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

        if ( entity != noone && selector_state != "default" && !isSelectionTarget(entity) ) {
            draw_sprite_ext( spr_selector_locked, floor(locked_image_index), entity.x, entity.y, _scale, _scale, 0, selectorColor, SELECTOR_ALPHA );
        }

        var _selector = is_hovering
            ? spr_selector_default
            : spr_selector_hover;

        draw_sprite_ext( _selector, image_index, pos_x, pos_y, 1, 1, 0, c_white, SELECTOR_ALPHA );
    };


    static DrawTargetSystem = function() {
        var _targets = get_selection_targets();

        for (var i = 0; i < array_length(_targets); i++) {

            var _entity = _targets[i];
            var _target_scale = getSelectorScale(_entity);

            draw_sprite_ext( spr_selector_default, -1, _entity.x, _entity.y, _target_scale, _target_scale, 0, c_red, SELECTOR_ALPHA );
        }
    };


    static add_selection_target = function(_entity) {
        if (!instance_exists(_entity)) return;

        if (!array_contains(_selection_targets, _entity)) {
            array_push(_selection_targets, _entity);
        }
    };


    static remove_selection_target = function(_entity) {
        var _index = array_get_index(_selection_targets, _entity);

        if (_index != -1) {
            array_delete(_selection_targets, _index, 1);
        }
    };


    static get_selection_targets = function() {
        return _selection_targets;
    };
    
    
    static getSelectorScale = function(_entity) {
    if (_entity == noone) return 1;

    return clamp( max( _entity.sprite_width / sprite_w, _entity.sprite_height / sprite_h ) * 1.3, 1, 4 );
};
    
    
    static getTopRightPosition = function() {
        if (entity == noone) return undefined;
    
        return {
            x: (entity.x - _scaledXOff) + _scaledW,
            y: entity.y - _scaledYOff
        };
    };
    
    isSelectionTarget = function(_entity) {
    return _entity != noone && array_contains(_selection_targets, _entity);
};
    
     static getInfoPanelData = function() {
  
      if (entity == noone) {
          return undefined;
      }
  
      return {
          entity: entity,
          color: selectorColor,
          font_color: fontColor,
  
          top_right_x: (entity.x - _scaledXOff) + _scaledW,
          top_right_y: entity.y - _scaledYOff
      };
  };
}