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
    
    locked_target = obj_test

    trail = new Trail(x, y, 50, c_yellow, 1, 30);

    static apply_movement = function() {
        image_angle = resolve_facing_angle();

        x += physics.hspeed;
        y += physics.vspeed;
        draw_x = round(x);
        draw_y = round(y);

        var _speed = point_distance(0, 0, physics.hspeed, physics.vspeed);

        var _emit_dir = image_angle + 180;
        var _emit_offset = 16;
        var _ex = x + lengthdir_x(_emit_offset, _emit_dir);
        var _ey = y + lengthdir_y(_emit_offset, _emit_dir);

        var _kick = 2;
        var _evx = physics.hspeed + lengthdir_x(_kick, _emit_dir);
        var _evy = physics.vspeed + lengthdir_y(_kick, _emit_dir);

        trail.process(_speed, _ex, _ey, _evx, _evy);
    }
    
    lock_target = function(_target) {
        if (_target == noone) return false;
        locked_target = _target;
        return true;
    };

    static resolve_facing_angle = function() {
        if (guns_state == guns_system.LOCKED_IN
            && locked_target != noone
            && instance_exists(locked_target)) {
            return point_direction(draw_x, draw_y, locked_target.x, locked_target.y);
        }
        return transform.angle;
    }

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
}