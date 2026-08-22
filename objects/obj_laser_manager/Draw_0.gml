var _key = ds_map_find_first(lasers);
while (!is_undefined(_key)) {
    lasers[? _key].draw();
    _key = ds_map_find_next(lasers, _key);
}