enum InputType {
    joystick,
    keyboard,
    gamepad,
    ai
}

input_data = {
    input: undefined,
    
        set_input: function(_type) {
        switch (_type) {
            case InputType.joystick: create_joystick(); break;

            case InputType.keyboard: create_keyboard(); break;
        }
    },

    create_joystick: function() {
        input = instance_find(obj_joy_stick, 0);

        if (input == noone) { input = instance_create_layer( 0, 0, "ly_control", obj_joy_stick ); }
    },

    create_keyboard: function() {
        input = {
            get_inputs: function() {
                var _kx = INPUT_HORIZONTAL;
                var _ky = INPUT_VERTICAL;

                var _active = (_kx != 0) || (_ky != 0);

                if (_active) {
                    var _len = point_distance(0, 0, _kx, _ky);

                    _kx /= _len;
                    _ky /= _len;
                }

                return {
                    active: _active,
                    x: _kx,
                    y: _ky
                };
            }
        };
    },



    get_inputs: function() {
        return input.get_inputs();
    }
};