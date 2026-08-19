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
    guns_state = guns_system.FREE;
    
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
    
    locked_target = noone
    trail_steps = 50;
trail_points = [];
for (var i = 0; i < trail_steps; i++) {
    array_push(trail_points, { px: _x, py: _y, vx: 0, vy: 0 });
}
trail_head = 0;   // índice do ponto mais novo no array físico
trail_count = trail_steps; // quantos pontos estão "ativos" (mantém comportamento inicial igual ao antigo)

trail_fade_speed = 30;
trail_fade_timer = 0;

trail_color = c_yellow;
trail_radius = 2

// converte índice lógico (0 = mais novo) pra índice físico no array circular
static trail_phys_index = function(_logical_i) {
    return (trail_head + _logical_i) mod trail_steps;
}

static trail_update = function(_x, _y, _vx, _vy) {
    var _min_distance = 1;
    if (trail_count > 0) {
        var _head = trail_points[trail_head];
        if (point_distance(_x, _y, _head.px, _head.py) < _min_distance) {
            return;
        }
    }

    // anda o head pra "trás" no buffer circular (sem deslocar nada)
    trail_head = (trail_head - 1 + trail_steps) mod trail_steps;

    // reaproveita o struct que já existia nesse slot, só sobrescreve os campos
    var _slot = trail_points[trail_head];
    _slot.px = _x;
    _slot.py = _y;
    _slot.vx = _vx;
    _slot.vy = _vy;

    if (trail_count < trail_steps) {
        trail_count++;
    }
}

static trail_integrate = function() {
    var _drag = 0.94;
    for (var i = 0; i < trail_count; i++) {
        var _p = trail_points[trail_phys_index(i)];
        _p.px += _p.vx;
        _p.py += _p.vy;
        _p.vx *= _drag;
        _p.vy *= _drag;
    }
}

static trail_process = function(_speed, _angle = transform.angle) {
    trail_integrate();

    if (_speed > 0.01) {
        var _emit_dir = _angle + 180;
        var _emit_offset = 16;
        var _ex = x + lengthdir_x(_emit_offset, _emit_dir);
        var _ey = y + lengthdir_y(_emit_offset, _emit_dir);

        var _kick = 2;
        var _evx = physics.hspeed + lengthdir_x(_kick, _emit_dir);
        var _evy = physics.vspeed + lengthdir_y(_kick, _emit_dir);

        trail_update(_ex, _ey, _evx, _evy);
        trail_fade_timer = 0;
    } else {
        trail_fade_timer += delta_time;
        if (trail_fade_timer >= trail_fade_speed * 1000) {
            if (trail_count > 0) {
                trail_count--; // "some" o ponto mais antigo sem tocar no array
            }
            trail_fade_timer = 0;
        }
    }
}

static trail_draw = function() {
    if (trail_count < 2) return;

    draw_primitive_begin(pr_trianglelist);
    for (var i = 0; i < trail_count - 1; i++) {
        var _p1 = trail_points[trail_phys_index(i)];
        var _p2 = trail_points[trail_phys_index(i + 1)];
        var _x1 = _p1.px, _y1 = _p1.py;
        var _x2 = _p2.px, _y2 = _p2.py;
        var _dir = point_direction(_x1, _y1, _x2, _y2);
        var _radius = 1;
        var _ratio = i / (trail_count - 1);
        var _alpha = 1 - _ratio;
        var _color = merge_color(c_red, c_yellow, _ratio);

        var _x1a = _x1 + lengthdir_x(_radius, _dir + 90);
        var _y1a = _y1 + lengthdir_y(_radius, _dir + 90);
        var _x2a = _x2 + lengthdir_x(_radius, _dir + 90);
        var _y2a = _y2 + lengthdir_y(_radius, _dir + 90);
        var _x1b = _x1 + lengthdir_x(_radius, _dir - 90);
        var _y1b = _y1 + lengthdir_y(_radius, _dir - 90);
        var _x2b = _x2 + lengthdir_x(_radius, _dir - 90);
        var _y2b = _y2 + lengthdir_y(_radius, _dir - 90);

        draw_vertex_color(_x1a, _y1a, _color, _alpha);
        draw_vertex_color(_x2a, _y2a, _color, _alpha);
        draw_vertex_color(_x1b, _y1b, _color, _alpha);
        draw_vertex_color(_x1b, _y1b, _color, _alpha);
        draw_vertex_color(_x2a, _y2a, _color, _alpha);
        draw_vertex_color(_x2b, _y2b, _color, _alpha);
    }
    draw_primitive_end();
}

    
static apply_movement = function(_angle) {
    x += physics.hspeed;
    y += physics.vspeed;
    draw_x = round(x);
    draw_y = round(y);

    var _speed = point_distance(0, 0, physics.hspeed, physics.vspeed);
    trail_process(_speed, _angle);
}
    
    
    lock_target = function(_target) {
        if (_target == noone) return false;
        locked_target = _target;
        return true;
    };

    // dentro de Ship
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