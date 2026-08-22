// Draw do laser
if (instance_exists(target)) {
    laser_beam.draw(x, y, target.x, target.y, segments, current_jitter);
}
