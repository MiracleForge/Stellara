function _camera_view_methods () {
    
    set_target = function(_target) {
        follow = _target;    
    };
    
    
    target_is_valid = function () {
        return (!is_struct(follow) && instance_exists(follow) || is_struct(follow));
    };
    
    
    snap_to_follow = function () {
        if (!self.target_is_valid()) exit;
        
        var _view_w = camera_get_view_width(VIEW);
        var _view_h = camera_get_view_height(VIEW);
            
var _target_x = round(follow.draw_x- _view_w / 2);
var _target_y = round(follow.draw_y - _view_h / 2);
        
        camera_set_view_pos_clamped(_target_x, _target_y);
    };
    
    
    init_view = function () {
        
        view_enabled = true;
        view_visible[0] = true;
        
        camera_set_view_size(VIEW, BASE_W, BASE_H);
        camera_set_view_target(VIEW, noone);
        
        view_set_wport(0, BASE_W * window_scale);
        view_set_hport(0, BASE_H * window_scale);
        view_set_xport(0, 0);
        view_set_yport(0, 0);
    };
    
    
    follow_target = function () {
        if (!target_is_valid()) return;
        
        var _view_w = camera_get_view_width(VIEW);
        var _view_h = camera_get_view_height(VIEW);
        
        var _target_x = follow.x - _view_w / 2;
        var _target_y = follow.y - _view_h / 2;
        
        _target_x = lerp(VIEW_X, _target_x, 0.2);
        _target_y = lerp(VIEW_Y, _target_y, 0.2);

        camera_set_view_pos_clamped(_target_x, _target_y);
    };
    
    
    camera_set_view_pos_clamped = function (_target_x, _target_y) {
        
        var _view_w = camera_get_view_width(VIEW);
        var _view_h = camera_get_view_height(VIEW);
        
        _target_x = clamp(_target_x, 0, room_width - _view_w);
        _target_y = clamp(_target_y, 0, room_height - _view_h);
        
        camera_set_view_pos(VIEW, _target_x, _target_y);
    };
         
    
        zoom_input = function (_magnitude) {
        
        if (mouse_check_button_pressed(mb_right) && !zooming) {
            
            if (abs(zoom_current - ZOOM_DEFAULT) < 0.001) {
                zoom_target = _magnitude;
            } else {
                zoom_target = ZOOM_DEFAULT;
            }
            
            zooming = true;
        }
    };
    
    zoom = function () {
        if (!zooming) return;
    
        zoom_current = lerp(zoom_current, zoom_target, 0.1);
    
        if (abs(zoom_current - zoom_target) < 0.001) {
            zoom_current = zoom_target;
            zooming = false;
        }
    
        var _zoom_w = BASE_W * zoom_current;
        var _zoom_h = BASE_H * zoom_current;
    
        camera_set_view_size(VIEW, _zoom_w, _zoom_h);
    
        var _view_w = camera_get_view_width(VIEW);
        var _view_h = camera_get_view_height(VIEW);
    
var _target_x = round(follow.draw_x - _view_w / 2);
var _target_y = round(follow.draw_y - _view_h / 2);
    
        camera_set_view_pos_clamped(_target_x, _target_y);
    };
};