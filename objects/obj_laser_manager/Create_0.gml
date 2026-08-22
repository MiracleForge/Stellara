lasers = ds_map_create(); // key: string(owner_id) -> LaserController

fire = function(_owner, _target, _type, _color) {
    var _key = string(_owner);
    if (ds_map_exists(lasers, _key)) {
        lasers[? _key].set_target(_target);
    } else {
        ds_map_add(lasers, _key, new LaserController(_owner, _target, _type, _color));
    }
}

stop = function(_owner) {
    var _key = string(_owner);
    if (ds_map_exists(lasers, _key)) {
        ds_map_delete(lasers, _key);
    }
}