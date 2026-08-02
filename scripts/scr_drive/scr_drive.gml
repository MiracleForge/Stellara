function scr_drive(_ship, _inputs)
{
    var physics = _ship.physics;
    var transform = _ship.transform;
    var stats = _ship.stats;
    
    if (!_inputs.active) {
        physics.angular_velocity = lerp(physics.angular_velocity, 0, 0.15);
        physics.hspeed = approach(physics.hspeed, 0, stats.friction);
        physics.vspeed = approach(physics.vspeed, 0, stats.friction);
        return;
    }
    
    var _ax = abs(_inputs.x);
    var _ay = abs(_inputs.y);
    
    var _has_dir = (_ax >= INPUT_DEAD_ZONE || _ay >= INPUT_DEAD_ZONE);
    if (!_has_dir) {
        physics.angular_velocity = lerp(physics.angular_velocity, 0, 0.2);
        physics.hspeed = approach(physics.hspeed, 0, stats.friction);
        physics.vspeed = approach(physics.vspeed, 0, stats.friction);
        return;
    }
    
    var _target_angle = point_direction(0, 0, _inputs.x, _inputs.y);
    var _diff = angle_difference(_target_angle, transform.angle);
    var _diff_abs = abs(_diff);
    var _desired_av = sign(_diff) * min(_diff_abs, stats.turn_speed);
    
    physics.angular_velocity = lerp( physics.angular_velocity, _desired_av, ANGULAR_SMOOTHING );
    
    if (_diff_abs < abs(physics.angular_velocity)) {
        transform.angle = _target_angle;
        physics.angular_velocity = 0;
    } else{
        transform.angle += physics.angular_velocity;
    }
    
    var _t = _diff_abs / 180;
    var _turn_drag = power(_t, TURN_DRAG_EXPONENT) * DRAG_COEFFICIENT;
    var _input_mag = min(sqrt(_ax * _ax + _ay * _ay), 1);
    
    var _spd_current = sqrt( physics.hspeed * physics.hspeed + physics.vspeed * physics.vspeed );
    
    var _dot = 0;
    if (_spd_current > 0.01){
        _dot = (
            (_inputs.x * physics.hspeed) +
            (_inputs.y * physics.vspeed)
        ) / _spd_current;
    }
    
    var _counter_fric = max(0, -_dot) * _input_mag * 0.18;
    physics.hspeed *= (1 - _counter_fric);
    physics.vspeed *= (1 - _counter_fric);
    var _dir = transform.angle;
    var _hs = physics.hspeed + lengthdir_x(
        stats.acceleration * _input_mag,
        _dir
    );
    var _vs = physics.vspeed + lengthdir_y( stats.acceleration * _input_mag, _dir );
    
    _hs = lerp(_hs, physics.hspeed + _inputs.x * stats.acceleration, 0.2);
    _vs = lerp(_vs, physics.vspeed + _inputs.y * stats.acceleration, 0.2);
    var _spd = sqrt(_hs * _hs + _vs * _vs);
    if (_spd > stats.max_speed)
    {
        var _scale = stats.max_speed / _spd;
        _hs *= _scale;
        _vs *= _scale;
    }
    physics.hspeed = _hs * (1 - _turn_drag);
    physics.vspeed = _vs * (1 - _turn_drag);
}