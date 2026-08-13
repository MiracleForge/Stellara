function _camera_window_methods(){
    
    calculate_max_window_scale = function () {
        var _max_h_scale = DISP_H / BASE_H;
        var _max_w_scale = DISP_W /BASE_W;
        
        if (frac(_max_h_scale == 0)) _max_h_scale --;
            
        return floor(min(_max_h_scale, _max_w_scale));
    }
    
    
    init_window = function () {
        
        window_set_size(BASE_W * window_scale, BASE_H * window_scale);
        window_center();
        
        surface_resize(APP_SURF, BASE_W * window_scale, BASE_H * window_scale);
        display_set_gui_size(BASE_W, BASE_H);
    }
}
