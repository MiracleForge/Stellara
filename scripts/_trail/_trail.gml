function Trail(_x, _y, _steps, _color, _radius, _fade_speed) constructor {
    steps = _steps;
    color = _color;
    radius = _radius;
    fade_speed = _fade_speed;
    fade_timer = 0;

    points = [];
    for (var i = 0; i < steps; i++) {
        array_push(points, { px: _x, py: _y, vx: 0, vy: 0 });
    }
    head = 0;
    count = steps;

    static phys_index = function(_logical_i) {
        return (head + _logical_i) mod steps;
    }

    static push_point = function(_x, _y, _vx, _vy) {
        var _min_distance = 1;
        if (count > 0) {
            var _head_p = points[head];
            if (point_distance(_x, _y, _head_p.px, _head_p.py) < _min_distance) {
                return;
            }
        }

        head = (head - 1 + steps) mod steps;
        var _slot = points[head];
        _slot.px = _x;
        _slot.py = _y;
        _slot.vx = _vx;
        _slot.vy = _vy;

        if (count < steps) count++;
    }

    static integrate = function() {
        var _drag = 0.94;
        for (var i = 0; i < count; i++) {
            var _p = points[phys_index(i)];
            _p.px += _p.vx;
            _p.py += _p.vy;
            _p.vx *= _drag;
            _p.vy *= _drag;
        }
    }

    static process = function(_speed, _emit_x, _emit_y, _emit_vx, _emit_vy) {
        if (_speed > 0.01) {
            integrate();
            push_point(_emit_x, _emit_y, _emit_vx, _emit_vy);
            fade_timer = 0;
        }
        else {
            fade_timer += delta_time;
    
            if (fade_timer >= fade_speed * 200) {
                if (count > 0) count--;
                fade_timer = 0;
            }
        }
    };

    static draw = function() {
        if (count < 2) return;

        draw_primitive_begin(pr_trianglelist);
        for (var i = 0; i < count - 1; i++) {
            var _p1 = points[phys_index(i)];
            var _p2 = points[phys_index(i + 1)];
            var _x1 = _p1.px, _y1 = _p1.py;
            var _x2 = _p2.px, _y2 = _p2.py;
            var _dir = point_direction(_x1, _y1, _x2, _y2);
            var _ratio = i / (count - 1);
            var _alpha = 1 - _ratio;
            var _c = merge_color(c_red, color, _ratio);

            var _x1a = _x1 + lengthdir_x(radius, _dir + 90);
            var _y1a = _y1 + lengthdir_y(radius, _dir + 90);
            var _x2a = _x2 + lengthdir_x(radius, _dir + 90);
            var _y2a = _y2 + lengthdir_y(radius, _dir + 90);
            var _x1b = _x1 + lengthdir_x(radius, _dir - 90);
            var _y1b = _y1 + lengthdir_y(radius, _dir - 90);
            var _x2b = _x2 + lengthdir_x(radius, _dir - 90);
            var _y2b = _y2 + lengthdir_y(radius, _dir - 90);

            draw_vertex_color(_x1a, _y1a, _c, _alpha);
            draw_vertex_color(_x2a, _y2a, _c, _alpha);
            draw_vertex_color(_x1b, _y1b, _c, _alpha);
            draw_vertex_color(_x1b, _y1b, _c, _alpha);
            draw_vertex_color(_x2a, _y2a, _c, _alpha);
            draw_vertex_color(_x2b, _y2b, _c, _alpha);
        }
        draw_primitive_end();
    }
}