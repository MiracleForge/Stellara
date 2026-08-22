target = noone;

// instancia do "desenhador" de laser (reaproveitando a técnica de fita)
laser_beam = new LaserBeam(c_red, 0.1); // cor base, espessura

segments = 6;   // quantos pedaços a linha é dividida (efeito elétrico)
jitter = 2;     // intensidade do tremor perpendicular
// Create do laser
life_timer = 0;
jitter_start = 6;      // jitter inicial (bem elétrico)
jitter_end = 0;        // jitter final (feixe liso)
jitter_decay_time = 20; // frames até estabilizar
current_jitter = 0;

// já nasce posicionado certo, sem esperar o Step (evita o flash de 1 frame)
x = obj_player.player.ship.draw_x;
y = obj_player.player.ship.draw_y;