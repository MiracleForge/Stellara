enum space_ship_state {
    DRIVE,
    HYPER_DRIVE,
    DESTROYED
};


function Ship(_x, _y, _data, _ship_name, _faction) constructor {
    x = _x;
    y = _y;

    draw_x = _x;
    draw_y = _y;
    
    data = _data;
    sprite = data.sprite;
    stats = data.stats;
    state = space_ship_state.DRIVE;
    
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

    trail_steps = 50;
    trail_x = array_create(trail_steps, _x);
    trail_y = array_create(trail_steps, _y);
    trail_fade_speed = 30;
    trail_fade_timer = 0;
    
        trail_color = c_yellow;
    trail_radius = 2

    static trail_update = function(_x, _y) {
        var _min_distance = 1;
        if (array_length(trail_x) > 0) {
            if (point_distance(_x, _y, trail_x[0], trail_y[0]) < _min_distance) {
                return;
            }
        }
        array_insert(trail_x, 0, _x);
        array_insert(trail_y, 0, _y);
        if (array_length(trail_x) > trail_steps) {
            array_pop(trail_x);
            array_pop(trail_y);
        }
    }

    static trail_process = function(_speed) {
        if (_speed > 0.01) {
            trail_update(x, y);
            trail_fade_timer = 0;
        } else {
            trail_fade_timer += delta_time;
            if (trail_fade_timer >= trail_fade_speed * 1000) {
                if (array_length(trail_x) > 0) {
                    array_pop(trail_x);
                    array_pop(trail_y);
                }
                trail_fade_timer = 0;
            }
        }
    }

    
    static trail_draw = function() {
        var _size = array_length(trail_x);
        if (_size < 2) return;

        draw_primitive_begin(pr_trianglelist);
        for (var i = 0; i < _size - 1; i++) {
            var _x1 = trail_x[i];
            var _y1 = trail_y[i];
            var _x2 = trail_x[i + 1];
            var _y2 = trail_y[i + 1];
            var _dir = point_direction(_x1, _y1, _x2, _y2);
            var _radius = 1;
            var _ratio = i / (_size - 1);
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

    
 static apply_movement = function() {
        x += physics.hspeed;
        y += physics.vspeed;
        draw_x = round(x);
        draw_y = round(y);

        var _speed = point_distance(0, 0, physics.hspeed, physics.vspeed);
        trail_process(_speed);
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