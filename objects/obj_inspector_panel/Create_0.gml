// Cache da seleção
selection_cache_entity = noone;   // guarda qual entidade foi usada pra montar o cache
selection_lines = [];             // array com as linhas de texto já prontas
selection_line_height = 0;        // altura de cada linha
selection_box_x = 0;
selection_box_y = 0;
selection_box_w = 0;
selection_box_h = 0;

box_square_w = sprite_get_width(BOX_SQUARE);
box_square_h = sprite_get_height(BOX_SQUARE);
tip_w = sprite_get_width(spr_tip);
tip_h = sprite_get_height(spr_tip);