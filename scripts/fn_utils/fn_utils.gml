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


function getEntity(_entity_id) {
    _entity_id = real(_entity_id);

    if (instance_exists(_entity_id)) {
        return _entity_id;
    }

    return noone;
}