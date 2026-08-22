function LaserController(_owner_ref, _target_ref) constructor {
    owner = _owner_ref;
    target = _target_ref;
    color = c_red;
    radius = 0.5;
    impact_radius = 0.1;
    
    segments = 6;
    jitter_start = 6;
    jitter_end = 2;
    jitter_decay_time = 20;
    current_jitter = 0;
    life_timer = 0;
    
    x = owner.player.ship.draw_x;
    y = owner.player.ship.draw_y;
    end_x = x;
    end_y = y;
    
    // ↓↓↓ É AQUI que troca ↓↓↓
    impact_count = 4;
    impact_segments = 3;
    impact_dx = array_create(impact_count);
    impact_dy = array_create(impact_count);
    for (var i = 0; i < impact_count; i++) {
        var _ang = random(360);
        var _len = random_range(6, 14);
        impact_dx[i] = lengthdir_x(_len, _ang);
        impact_dy[i] = lengthdir_y(_len, _ang);
    }
    // ↑↑↑ Isso substitui o bloco antigo de impact_angles/impact_lengths ↑↑↑
    
    var _max_points = max(segments, impact_segments) + 1;
    pts_x = array_create(_max_points);
    pts_y = array_create(_max_points);
    
    cached_target_radius = 0;
    bbox_refresh_timer = 0;
    bbox_refresh_interval = 15;// recalcula a cada 15 frames (~4x por segundo), suficiente pra naves que não mudam de escala toda hora
    
    static set_target = function(_new_target) {
        if (target != _new_target) {
            target = _new_target;
            life_timer = 0;
            bbox_refresh_timer = 0; // força recálculo imediato no próximo update
        }
    }
    
    static is_valid = function() {
        return instance_exists(target);
    }
    
    static refresh_bbox = function() {
        var _bbox_left = sprite_get_bbox_left(target.sprite_index);
        var _bbox_right = sprite_get_bbox_right(target.sprite_index);
        var _bbox_top = sprite_get_bbox_top(target.sprite_index);
        var _bbox_bottom = sprite_get_bbox_bottom(target.sprite_index);
        
        var _bbox_w = (_bbox_right - _bbox_left) * target.image_xscale;
        var _bbox_h = (_bbox_bottom - _bbox_top) * target.image_yscale;
        
        cached_target_radius = min(_bbox_w, _bbox_h) * 0.5;
    }
    
   static update = function() {
    life_timer++;
    
    if (life_timer < jitter_decay_time) {
        var _t = life_timer / jitter_decay_time;
        current_jitter = lerp(jitter_start, jitter_end, _t);
    } else {
        current_jitter = jitter_end;
    }
    
    if (!instance_exists(target)) return false;
    
    x = owner.player.ship.draw_x;
    y = owner.player.ship.draw_y;
    
    bbox_refresh_timer++;
    if (bbox_refresh_timer >= bbox_refresh_interval) {
        refresh_bbox();
        bbox_refresh_timer = 0;
    }
    
    var _dx = target.x - x;
    var _dy = target.y - y;
    var _dist = sqrt(_dx * _dx + _dy * _dy);
    
    var _target_radius = min(cached_target_radius, _dist - 1);
    _target_radius = max(_target_radius, 0);
    
    if (_dist > 0) {
        var _inv_dist = _target_radius / _dist; // fator de escala pra recuar o ponto
        end_x = target.x - _dx * _inv_dist;
        end_y = target.y - _dy * _inv_dist;
    } else {
        end_x = target.x;
        end_y = target.y;
    }
    
    return true;
}
    
    // preenche os buffers reutilizáveis (pts_x/pts_y) em vez de criar array novo
    static build_points = function(_x1, _y1, _x2, _y2, _seg_count, _jit) {
        var _dx = _x2 - _x1;
        var _dy = _y2 - _y1;
        var _len = sqrt(_dx * _dx + _dy * _dy);
        var _nx = 0, _ny = 0;
        
        if (_len > 0) {
            _nx = -_dy / _len;
            _ny = _dx / _len;
        }
        
        for (var i = 0; i <= _seg_count; i++) {
            var _t = i / _seg_count;
            var _px = lerp(_x1, _x2, _t);
            var _py = lerp(_y1, _y2, _t);
            if (i > 0 && i < _seg_count) {
                var _n = random_range(-_jit, _jit);
                _px += _nx * _n;
                _py += _ny * _n;
            }
            pts_x[i] = _px;
            pts_y[i] = _py;
        }
    }
    
    // só emite os vértices (sem begin/end) — permite agrupar vários segmentos numa única chamada de primitive
    // --- substitui point_direction + lengthdir por vetor direto (mais rápido) ---
    static emit_segment_vertices = function(_seg_count, _radius) {
        for (var i = 0; i < _seg_count; i++) {
            var _x1 = pts_x[i],     _y1 = pts_y[i];
            var _x2 = pts_x[i + 1], _y2 = pts_y[i + 1];
            
            var _dx = _x2 - _x1;
            var _dy = _y2 - _y1;
            var _len = sqrt(_dx * _dx + _dy * _dy);
            
            if (_len <= 0) continue; // evita divisão por zero em segmentos degenerados
            
            var _nx = (-_dy / _len) * _radius; // perpendicular normalizada, já escalada pelo raio
            var _ny = (_dx / _len) * _radius;
            
            var _x1a = _x1 + _nx, _y1a = _y1 + _ny;
            var _x2a = _x2 + _nx, _y2a = _y2 + _ny;
            var _x1b = _x1 - _nx, _y1b = _y1 - _ny;
            var _x2b = _x2 - _nx, _y2b = _y2 - _ny;
            
            draw_vertex_color(_x1a, _y1a, color, 1);
            draw_vertex_color(_x2a, _y2a, color, 1);
            draw_vertex_color(_x1b, _y1b, color, 1);
            draw_vertex_color(_x1b, _y1b, color, 1);
            draw_vertex_color(_x2a, _y2a, color, 1);
            draw_vertex_color(_x2b, _y2b, color, 1);
        }
    }
    
    // --- OTIMIZAÇÃO: um único draw_primitive_begin/end pro laser inteiro ---
  static draw = function() {
    if (!instance_exists(target)) return;
    
    draw_primitive_begin(pr_trianglelist);
    
    // feixe principal
    build_points(x, y, end_x, end_y, segments, current_jitter);
    emit_segment_vertices(segments, radius);
    
    // raminhos de impacto (usa os deltas já calculados no Create, sem lengthdir aqui)
    for (var i = 0; i < impact_count; i++) {
        var _bx = end_x + impact_dx[i];
        var _by = end_y + impact_dy[i];
        build_points(end_x, end_y, _bx, _by, impact_segments, 2);
        emit_segment_vertices(impact_segments, impact_radius);
    }
    
    draw_primitive_end();
}
}