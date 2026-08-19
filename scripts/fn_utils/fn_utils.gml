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

