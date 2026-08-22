var _key = ds_map_find_first(lasers);
while (!is_undefined(_key)) {
    var _next_key = ds_map_find_next(lasers, _key); // pega o próximo ANTES de possivelmente deletar
    var _lc = lasers[? _key];
    
    if (!_lc.update()) {
        ds_map_delete(lasers, _key);
    }
    
    _key = _next_key;
}