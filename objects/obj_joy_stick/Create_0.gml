joy_x = 0;
joy_y = 0;

move_x = 0;
move_y = 0;

is_active = false;
max_radius = 300;

get_inputs = function () {
   return {
    active:  is_active,
    x: move_x / max_radius,
    y: move_y / max_radius,  
} 
}



anim_timer = 0;
anim_frame = 0;
anim_spd = 1; // segundos por frame