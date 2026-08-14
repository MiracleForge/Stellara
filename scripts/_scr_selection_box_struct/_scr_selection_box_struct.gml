function SelectionBox()
constructor {
    entity = noone;

    pos_x = mouse_x;
    pos_y = mouse_y;
    
    sprite_w = sprite_get_width(spr_selector_default);
    sprite_h = sprite_get_height(spr_selector_default);

    selectorColor=  c_white;
    image_index = 0;
    image_speed = 0.06;

    update = function() {
        pos_x = mouse_x;
        pos_y = mouse_y;
        
        image_index += image_speed;

        if (image_index >= sprite_get_number(spr_selector_default)) image_index = 0;
    };
    
    reset = function () {
        entity = noone;
        selectorColor = c_white;
    };

  selectOnClick = function()
  {
      if (mouse_check_button_pressed(mb_left)) {
          var clicked = instance_position( pos_x, pos_y, obj_clickable );
  
          if (clicked == entity) {
            reset();
          } else if (clicked != noone) {
              entity = clicked;
            selectorColor = getSelectableColor(entity);
          } else {
            reset();
          }
      }
  };
    
    getSelectableColor = function (_entity) {
           var _info = _entity.infoData.type;
        
           return _info == "player" ? c_red : c_white;
    }
    
    static draw = function()
    {
        draw_sprite_ext(spr_selector_default, image_index, pos_x, pos_y, 1, 1, -1, c_white, SELECTOR_ALPHA);

        if (entity != noone) {
            var _scale = max(entity.sprite_width / sprite_w, entity.sprite_height / sprite_h) * 1.3;
            
            draw_sprite_ext(spr_selector_default,  -1, entity.x, entity.y, _scale, _scale, 0, selectorColor, SELECTOR_ALPHA);
        }
    }
}