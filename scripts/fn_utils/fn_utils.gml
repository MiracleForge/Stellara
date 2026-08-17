/// @function approach(value, target, amount)
/// @description Gradually moves a value toward a target
/// without overshooting.
/// @param {real} value Current value.
/// @param {real} target Target value.
/// @param {real} amount Step amount per update.
/// @returns {real} New value moved toward the target.
function approach(value, target, amount) {
    if (value < target) return min(value + amount, target);
    else return max(value - amount, target);
}


function trail_update(_x, _y)
{
    var _min_distance = 1;

    if (array_length(trail_x) > 0)
    {
        if (point_distance(
            _x,
            _y,
            trail_x[0],
            trail_y[0]
        ) < _min_distance)
        {
            return;
        }
    }

    array_insert(trail_x, 0, _x);
    array_insert(trail_y, 0, _y);

    if (array_length(trail_x) > trail_steps)
    {
        array_pop(trail_x);
        array_pop(trail_y);
    }
}

function trail_draw()
{
    var _size = array_length(trail_x);

    if (_size < 2)
        return;

    draw_primitive_begin(pr_trianglelist);

    for (var i = 0; i < _size - 1; i++)
    {
        var _x1 = trail_x[i];
        var _y1 = trail_y[i];

        var _x2 = trail_x[i + 1];
        var _y2 = trail_y[i + 1];

        var _dir = point_direction(_x1, _y1, _x2, _y2);

        // Espessura constante
        var _radius = 1;

        // Progresso do início até o final
        var _ratio = i / (_size - 1);

        // Transparência
        var _alpha = 1 - _ratio;

        // Vermelho forte -> amarelo
        var _color = merge_color(
            c_red,
            c_yellow,
            _ratio
        );

        // Primeiro lado
        var _x1a = _x1 + lengthdir_x(_radius, _dir + 90);
        var _y1a = _y1 + lengthdir_y(_radius, _dir + 90);

        var _x2a = _x2 + lengthdir_x(_radius, _dir + 90);
        var _y2a = _y2 + lengthdir_y(_radius, _dir + 90);

        // Segundo lado
        var _x1b = _x1 + lengthdir_x(_radius, _dir - 90);
        var _y1b = _y1 + lengthdir_y(_radius, _dir - 90);

        var _x2b = _x2 + lengthdir_x(_radius, _dir - 90);
        var _y2b = _y2 + lengthdir_y(_radius, _dir - 90);


        // Triângulo 1
        draw_vertex_color(
            _x1a, _y1a,
            _color, _alpha
        );

        draw_vertex_color(
            _x2a, _y2a,
            _color, _alpha
        );

        draw_vertex_color(
            _x1b, _y1b,
            _color, _alpha
        );


        // Triângulo 2
        draw_vertex_color(
            _x1b, _y1b,
            _color, _alpha
        );

        draw_vertex_color(
            _x2a, _y2a,
            _color, _alpha
        );

        draw_vertex_color(
            _x2b, _y2b,
            _color, _alpha
        );
    }

    draw_primitive_end();
}