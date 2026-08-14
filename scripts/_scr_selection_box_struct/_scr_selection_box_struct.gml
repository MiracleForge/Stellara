function SelectionBox()
constructor {
    entity = noone;

    pos_x = mouse_x;
    pos_y = mouse_y;
    
    sprite_w = sprite_get_width(spr_selector_default);
    sprite_h = sprite_get_height(spr_selector_default);

    update = function() {
        pos_x = mouse_x;
        pos_y = mouse_y;
    };

  selectOnClick = function()
  {
      if (mouse_check_button_pressed(mb_left)) {
          var clicked = instance_position( pos_x, pos_y, obj_clickable );
  
          if (clicked == entity) {
              entity = noone;
          } else if (clicked != noone) {
              entity = clicked;
          } else {
              entity = noone;
          }
      }
  };
    
    static draw = function()
    {
        draw_sprite_ext(spr_selector_default, -1, pos_x, pos_y, 1, 1, -1, c_white, SELECTOR_ALPHA);

        if (entity != noone)
        {
            var _scale = max(entity.sprite_width / sprite_w, entity.sprite_height / sprite_h);
            draw_sprite_ext(spr_selector_default, 0, entity.x, entity.y, _scale, _scale, 0, c_white, SELECTOR_ALPHA);
        }
    }
}