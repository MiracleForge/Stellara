global.input_sprite_map = {
    attk: array_create(4, spr_gamepad_x), 
    talk: array_create(4, spr_key_z),   
};

global.input_sprite_map.attk[InputType.keyboard] = spr_key_x;
global.input_sprite_map.talk[InputType.keyboard] = spr_key_z;


global.input_sprite_map.attk[InputType.joystick] = spr_gamepad_x;
global.input_sprite_map.talk[InputType.joystick] = spr_key_z; 