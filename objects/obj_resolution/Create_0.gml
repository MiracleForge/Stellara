cam_h = camera_get_view_height(view_camera[0]);

lw = window_get_width();
lh = window_get_height();

function update_res () {
    var _cur_w = window_get_width();
    var _cur_h = window_get_height();
    var _cur_aspect = _cur_w / _cur_h;
    
    // update camera 
    var _cam_w = cam_h * _cur_aspect;
    var _cam_h = cam_h;
    camera_set_view_size(view_camera[0], _cam_w, _cam_h);
    
    // set resolution
    window_set_size(_cam_w, _cam_h);
    surface_resize(application_surface, _cam_w, _cam_h);
    display_set_gui_size(camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]))
}

update_res();