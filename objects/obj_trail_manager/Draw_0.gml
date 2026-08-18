shader_set(shd_trail);
var _tex_w = surface_get_width(trail_surf);
var _tex_h = surface_get_height(trail_surf);
shader_set_uniform_f(shader_get_uniform(shd_trail, "u_time"), current_time / 1000.0);
shader_set_uniform_f(shader_get_uniform(shd_trail, "u_texel"), 1.0 / _tex_w, 1.0 / _tex_h);
shader_set_uniform_f(shader_get_uniform(shd_trail, "u_glow_strength"), 1.8);
shader_set_uniform_f(shader_get_uniform(shd_trail, "u_distortion"), 0.0);
draw_surface(trail_surf, 0, 0);
shader_reset();