global.trail_manager = id;
trail_fade_amount = 0.97
trail_surf = surface_create(room_width, room_height);
trail_duration_ms = 1000; // 3 segundos de vida por carimbo — ajuste aqui
stamps = []; // cada item: {x, y, color, radius, born_time}

request_stamp = function(_x, _y, _color, _radius) {
    array_push(stamps, {
        x: _x, y: _y, color: _color, radius: _radius, born_time: current_time
    });
}