function KeyboardInput() constructor {
    get_inputs = function() {
        var _kx = (keyboard_check(vk_right) or keyboard_check(ord("D"))) 
                 - (keyboard_check(vk_left) or keyboard_check(ord("A")));
        var _ky = (keyboard_check(vk_down) or keyboard_check(ord("S"))) 
                 - (keyboard_check(vk_up) or keyboard_check(ord("W")));

        var _active = (_kx != 0) or (_ky != 0);

        if (_active) {
            var _len = point_distance(0, 0, _kx, _ky);
            _kx /= _len;
            _ky /= _len;
        }

        return { active: _active, x: _kx, y: _ky };
    }
}