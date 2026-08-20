enum FeedbackType {
    alert,
    alarm,
    positive,
    neutral
}

enum FeedbackState {
    opening,
    showing,
    closing
}


function FeedbackMessage(_message, _type, _time) constructor {
    message  = _message;
    type         = _type;
    timer       = _time;
    state        = FeedbackState.opening;
    frame      = 0;
    alpha       = 0;
    y                = 0;
    target_y  = 0;


    text_w = string_width(_message);
    text_h = string_height(_message);
}


function FeedbackManager(_spr, _max_messages, _spacing, _anim_speed) constructor {
    spr             = _spr;
    spr_w           = sprite_get_width(_spr);
    spr_h           = sprite_get_height(_spr);
    spr_frames      = sprite_get_number(_spr);
    last_frame      = spr_frames - 1;
    inv_last_frame  = (last_frame > 0) ? (1 / last_frame) : 1; 
    animation_speed = _anim_speed;
    max_messages    = _max_messages;
    message_spacing = _spacing;

    messages = [];

    colors = array_create(4, c_white);
    colors[FeedbackType.alert]    = c_red;
    colors[FeedbackType.alarm]    = c_yellow;
    colors[FeedbackType.positive] = c_lime;
    colors[FeedbackType.neutral]  = c_white;

    
    static show_feedback = function(_message, _type, _time) {
        array_insert(messages, 0, new FeedbackMessage(_message, _type, _time));
        if (array_length(messages) > max_messages) {
            array_resize(messages, max_messages);
        }
    };

    
    static update = function(_dt) {
        for (var _i = 0; _i < array_length(messages); _i++) {
            var _msg = messages[_i];
            _msg.target_y = _i * message_spacing;

            switch (_msg.state) {
                case FeedbackState.opening:
                    _msg.frame += animation_speed * _dt;
                    if (_msg.frame >= last_frame) {
                        _msg.frame = last_frame;
                        _msg.alpha = 1;
                        _msg.state = FeedbackState.showing;
                    } else {
                        _msg.alpha = _msg.frame * inv_last_frame;
                    }
                    break;

                case FeedbackState.showing:
                    _msg.timer -= _dt;
                    if (_msg.timer <= 0) {
                        _msg.timer = 0;
                        _msg.state = FeedbackState.closing;
                    }
                    break;

                case FeedbackState.closing:
                    _msg.frame -= animation_speed * _dt;
                    if (_msg.frame <= 0) {
                        array_delete(messages, _i, 1);
                        _i--;
                        continue;
                    }
                    _msg.alpha = _msg.frame * inv_last_frame;
                    break;
            }

            _msg.y = lerp(_msg.y, _msg.target_y, 12 * _dt);
        }
    };

    
    static draw = function(_x, _y) {
        var _count = array_length(messages);
        if (_count == 0) return;

        var _padding_x = 12;
        var _padding_y = 8;

        for (var _i = 0; _i < _count; _i++) {
            var _msg  = messages[_i];
            var _box_w = _msg.text_w + (_padding_x * 2);
            var _box_h = _msg.text_h + (_padding_y * 2);
            var _mx = _x;
            var _my = _y + _msg.y;

            draw_sprite_ext(spr, floor(_msg.frame), _mx, _my,
                _box_w / spr_w, _box_h / spr_h,
                0, colors[_msg.type], _msg.alpha);

            draw_set_alpha(_msg.alpha);
            draw_set_colour(c_white);
            draw_text(_mx - (_msg.text_w * 0.5), _my - (_msg.text_h * 0.5), _msg.message);
        }

        draw_set_alpha(1);
        draw_set_colour(c_white);
    };
}