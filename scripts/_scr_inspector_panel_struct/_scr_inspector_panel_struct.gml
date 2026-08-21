function SelectionInfoPanel() constructor {

    cache_entity = noone;
    cache_info = undefined;

    selector_color = c_white;
    font_color = c_white;

    top_right_x = 0;
    top_right_y = 0;

    lines = [];
    line_height = 0;

    x = 0;
    y = 0;
    w = 0;
    h = 0;

    scale_x = 1;
    scale_y = 1;

    box_w = sprite_get_width(BOX_SQUARE);
    box_h = sprite_get_height(BOX_SQUARE);

    tip_w = sprite_get_width(spr_tip);
    tip_h = sprite_get_height(spr_tip);

    show_actions = false;

    attk_sprite = -1;
    talk_sprite = -1;

    attk_x = 0;
    talk_x = 0;
    key_y = 0;


    update = function(_data) {

        if (is_undefined(_data)) {
            cache_entity = noone;
            return;
        }

        var _entity = _data.entity;

        if (_entity == noone) {
            cache_entity = noone;
            return;
        }

        selector_color = _data.color;
        font_color = _data.font_color;

        top_right_x = _data.top_right_x;
        top_right_y = _data.top_right_y;
        
        if (_entity != cache_entity || _entity.infoData != cache_info) {
            cache_entity = _entity;
            cache_info = _entity.infoData;
             obj_selection_box.selector.getSelectableColor(_entity);
            rebuild_selection_cache(self, _entity);
        }
        
        updateLayout();
        updateActions();
    };


    updateLayout = function() {

        var _origin_x = top_right_x + TIP_OFFSET_X;
        var _origin_y = top_right_y + TIP_OFFSET_Y;

        x = _origin_x + tip_w;
        y = _origin_y - (h / 2);
    };


    updateActions = function() {

        show_actions = false;

        if (cache_entity == noone) return;

        if (cache_entity.infoData.type == "player") return;

        if (obj_selection_box.selector.isSelectionTarget(cache_entity)) {
            return;
        }

        show_actions = true;

        var _box_w_scaled = box_w * scale_x;

        key_y = y + box_h * scale_y;

        attk_x = x + _box_w_scaled * 0.8;
        talk_x = x + _box_w_scaled * 0.6;

        var _input_type = obj_input.input_data.current_input;

        attk_sprite = global.input_sprite_map.attk[_input_type];
        talk_sprite = global.input_sprite_map.talk[_input_type];
    };


    draw = function() {

        if (cache_entity == noone) return;

        setupDraw();

        drawTip();
        drawBox();
        drawActions();
        drawText();

        finishDraw();
    };


    setupDraw = function() {

        draw_set_font(global.my_font.infopanel);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_colour(font_color);
    };


    drawTip = function() {

        var _origin_x = top_right_x + TIP_OFFSET_X;
        var _origin_y = top_right_y + TIP_OFFSET_Y;

        draw_sprite_ext( spr_tip, -1, _origin_x, _origin_y - (tip_h / 2), 1, 1, -1, selector_color, BOX_ALPHA );
    };



    drawBox = function() {

        draw_sprite_ext( BOX_SQUARE, -1, x, y, scale_x, scale_y, 0, selector_color, BOX_ALPHA );
    };


    drawActions = function() {

        if (!show_actions) return;

        draw_sprite_ext( attk_sprite, -1, attk_x, key_y, 1, 1, 0, selector_color,1 );

        draw_sprite_ext( talk_sprite, -1, talk_x, key_y, 1, 1, 0, selector_color, 1 );
    };


    drawText = function() {

        var _text_x = x + BOX_PAD_X;
        var _text_y = y + BOX_PAD_TOP;

        var _count = array_length(lines);

        for (var _i = 0; _i < _count; _i++) {
            draw_text(_text_x, _text_y, lines[_i]);
            _text_y += line_height;
        }
    };


    finishDraw = function() {

        draw_set_font(-1);
        draw_set_colour(c_white);
    };
}