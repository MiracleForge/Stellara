enum space_ship_mov {
    DRIVE,
    HYPER_DRIVE,
    DESTROYED,
};

enum guns_system {
    FREE,
    LOCKED_IN
}

function Ship(_x, _y, _data, _ship_name, _faction) constructor {
    x = _x;
    y = _y;

    draw_x = _x;
    draw_y = _y;
    
    data = _data;
    sprite = data.sprite;
    stats = data.stats;
    shield = data.shield;
    
    state = space_ship_mov.DRIVE;
    guns_state = guns_system.LOCKED_IN;
    
    identity = {
        name: _ship_name,
        faction: _faction,
        hostility: 0,
        transponder_active: true
    };

    transform = {
        angle: 0
    };

    physics = {
        hspeed: 0,
        vspeed: 0,
        angular_velocity: 0
    };
    
    locked_target = noone;

    trail = new Trail(x, y, 20, c_yellow, 1, 30);

    static apply_movement = function() {
        image_angle = resolve_facing_angle();

        x += physics.hspeed;
        y += physics.vspeed;
        draw_x = round(x);
        draw_y = round(y);

        var _speed = point_distance(0, 0, physics.hspeed, physics.vspeed);

        var _emit_dir = image_angle + 180;
        var _emit_offset = 10;
        var _ex = x + lengthdir_x(_emit_offset, _emit_dir);
        var _ey = y + lengthdir_y(_emit_offset, _emit_dir);

        var _kick = 2;
        var _evx = physics.hspeed + lengthdir_x(_kick, _emit_dir);
        var _evy = physics.vspeed + lengthdir_y(_kick, _emit_dir);

        trail.process(_speed, _ex, _ey, _evx, _evy);
    }
    
    lock_target = function(_target) {
    
        if (_target == noone) {
            locked_target = noone;
            guns_state = guns_system.FREE;
            return true;
        }
    
        locked_target = _target;
        guns_state = guns_system.LOCKED_IN;
    
        return true;
    };

    static resolve_facing_angle = function() {
        if (guns_state == guns_system.LOCKED_IN
            && locked_target != noone
            && instance_exists(locked_target)) {
    
            var _target_angle = point_direction( draw_x, draw_y, locked_target.x, locked_target.y );
    
            var _angle_diff = angle_difference( image_angle, _target_angle );
    
            var _turn_speed_to_target = 2;
    
            return image_angle - clamp( _angle_diff, -_turn_speed_to_target, _turn_speed_to_target);
        }
    
        return transform.angle;
    };
    
    get_locked_target = function() {
         return locked_target;
    };
    
    can_lock_target = function(_target) {
    if (_target == noone) return false;

    var _distance = point_distance(
        transform.x,
        transform.y,
        _target.x,
        _target.y
    );

    return _distance <= data.combat.attack_range;
};
        
        
    static getInfo = function() {
        return {
            type: "ship",
            fields: [
                { label: "Faction", value: global.faction_data[identity.faction].name, },
                { label: "Name", value: identity.name, },
                { label: "Class", value: data.shipInfo.class, },
            ],
        };
    }
    
    
    // shield
   static draw_shield = function () {
        
    }
}