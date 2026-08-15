function SelectionBox()
constructor {
    entity = noone;

    pos_x = mouse_x;
    pos_y = mouse_y;
    
    sprite_w = sprite_get_width(spr_selector_default);
    sprite_h = sprite_get_height(spr_selector_default);

    selectorColor=  c_white;
    fontColor = c_white;
    image_index = 0;
    image_speed = 0.06;
    
    selectorTopRightX = 0;
    selectorTopRightY = 0;

    update = function() {
        pos_x = mouse_x;
        pos_y = mouse_y;
        
        image_index += image_speed;

        if (image_index >= sprite_get_number(spr_selector_default)) image_index = 0;
    };
    
reset = function ()
{
    entity = noone;
    selectorColor = c_white;
    fontColor = c_white;
};

  selectOnClick = function()
  {
      if (mouse_check_button_pressed(mb_left)) {
          var clicked = instance_position( pos_x, pos_y, obj_clickable );
  
          if (clicked == entity) {
            reset();
          } else if (clicked != noone) { 
              entity = clicked;
              var _colors = getSelectableColor(entity);
               selectorColor = _colors.selector;
               fontColor = _colors.text;
          } else {
            reset();
          }
      }
  };
    
    getSelectableColor = function (_entity)
    {
        var _type = _entity.infoData.type;

        return getEntityTypeColor(_type);
    };
    
static draw = function()
{
    draw_sprite_ext(spr_selector_default, image_index, pos_x, pos_y, 1, 1, -1, c_white, SELECTOR_ALPHA);
    if (entity != noone) {
        var _scale = clamp( max( entity.sprite_width / sprite_w, entity.sprite_height / sprite_h ) * 1.3, 1, 4 );

        var _w = sprite_w * _scale;
        var _h = sprite_h * _scale;

        // offset da origem da sprite, já escalado
        var _xoff = sprite_get_xoffset(spr_selector_default) * _scale;
        var _yoff = sprite_get_yoffset(spr_selector_default) * _scale;

        // canto superior esquerdo
        var _left   = entity.x - _xoff;
        var _top    = entity.y - _yoff;

        // canto superior direito
        selectorTopRightX = _left + _w;
        selectorTopRightY = _top;

        draw_sprite_ext(spr_selector_default, -1, entity.x, entity.y, _scale, _scale, 0, selectorColor, SELECTOR_ALPHA);
    }
}
}