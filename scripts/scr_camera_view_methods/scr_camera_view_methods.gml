function _camera_view_methods () {
    
    set_target  = function(_target) {
        follow = _target;    
    };
    
    
    target_is_valid = function () {
        return (!is_struct(follow) && instance_exists(follow) || is_struct(follow));
    };
    
    
    snap_to_follow = function () {
        if (!self.target_is_valid()) exit;
            
        var _target_x = follow.x - VIEW_W / 2;
        var _target_y = follow.y - VIEW_H / 2;
        
        camera_set_view_pos_clamped(_target_x, _target_y);
    }
    
    
    init_view = function () {
        
        view_enabled = true;
        view_visible[0] = true;
        camera_set_view_size(VIEW, BASE_W, BASE_H);
        camera_set_view_target(VIEW, noone);
        
       view_set_wport(0, BASE_W * window_scale);
        view_set_hport(0, BASE_H * window_scale);
        view_set_xport(0, 0);
        view_set_yport(0, 0);
    }
    
    
    follow_target = function () {
        // why end-step, we don't wanna to move our camera when the follow object still moving 
        if (!target_is_valid()) return;
            
        var _target_x = follow.x - VIEW_W / 2;
        var _target_y = follow.y - VIEW_H / 2;
        
        _target_x = lerp(VIEW_X, _target_x, .2);
        _target_y = lerp(VIEW_Y, _target_y, .2);

        camera_set_view_pos_clamped(_target_x,_target_y);
    }
    
    
    camera_set_view_pos_clamped = function (_target_x, _target_y) { 
        _target_x = clamp(_target_x, 0, room_width - VIEW_W);
        _target_y = clamp(_target_y, 0, room_height - VIEW_H);
        
        camera_set_view_pos(VIEW, _target_x, _target_y);
    }
}