draw_sprite_ext(spr_selector_default, -1, selector.pos_x,  selector.pos_y, 1, 1, -1,c_white,0.6);

if ( selector.entity != noone) {
    var _inst =  selector.entity;
   var _width  = _inst.sprite_width;
var _height = _inst.sprite_height;

var _selector_width  = sprite_get_width(spr_selector_default);
var _selector_height = sprite_get_height(spr_selector_default);

var _scale = max(
    _width / _selector_width,
    _height / _selector_height
);

draw_sprite_ext(
    spr_selector_default,
    0,
    _inst.x,
    _inst.y,
    _scale,
    _scale,
    0,
    c_white,
    0.6
);
}