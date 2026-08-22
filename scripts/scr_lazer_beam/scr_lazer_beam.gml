function LaserBeam(_color, _radius) constructor {
    color = _color;
    radius = _radius;

    static draw = function(_x1, _y1, _x2, _y2, _segments, _jitter) {
        var _dir = point_direction(_x1, _y1, _x2, _y2);
        var _dist = point_distance(_x1, _y1, _x2, _y2);
        var _step = _dist / _segments;

        // gera pontos intermediários com leve jitter (efeito elétrico)
        var _points = array_create(_segments + 1);
        for (var i = 0; i <= _segments; i++) {
            var _t = i / _segments;
            var _px = lerp(_x1, _x2, _t);
            var _py = lerp(_y1, _y2, _t);

            if (i > 0 && i < _segments) {
                var _n = random_range(-_jitter, _jitter);
                _px += lengthdir_x(_n, _dir + 90);
                _py += lengthdir_y(_n, _dir + 90);
            }
            _points[i] = { px: _px, py: _py };
        }

        draw_primitive_begin(pr_trianglelist);
        for (var i = 0; i < _segments; i++) {
            var _p1 = _points[i];
            var _p2 = _points[i + 1];
            var _seg_dir = point_direction(_p1.px, _p1.py, _p2.px, _p2.py);

            var _x1a = _p1.px + lengthdir_x(radius, _seg_dir + 90);
            var _y1a = _p1.py + lengthdir_y(radius, _seg_dir + 90);
            var _x2a = _p2.px + lengthdir_x(radius, _seg_dir + 90);
            var _y2a = _p2.py + lengthdir_y(radius, _seg_dir + 90);
            var _x1b = _p1.px + lengthdir_x(radius, _seg_dir - 90);
            var _y1b = _p1.py + lengthdir_y(radius, _seg_dir - 90);
            var _x2b = _p2.px + lengthdir_x(radius, _seg_dir - 90);
            var _y2b = _p2.py + lengthdir_y(radius, _seg_dir - 90);

            draw_vertex_color(_x1a, _y1a, color, 1);
            draw_vertex_color(_x2a, _y2a, color, 1);
            draw_vertex_color(_x1b, _y1b, color, 1);
            draw_vertex_color(_x1b, _y1b, color, 1);
            draw_vertex_color(_x2a, _y2a, color, 1);
            draw_vertex_color(_x2b, _y2b, color, 1);
        }
        draw_primitive_end();
    }
}