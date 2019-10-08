/// @description Insert description here
// You can write your code in this editor
var ribbon_starting_x = (view_w/2) - (sprite_get_width(spr_ui_ribbon)/2);
var ribbon_starting_y = view_h * 0.12;
draw_sprite(spr_ui_ribbon,0,ribbon_starting_x,ribbon_starting_y);

draw_set_halign(fa_middle);
draw_set_valign(fa_center);

//score
draw_set_color(c_white);
draw_set_font(font_monofonto_large);

draw_text(ribbon_starting_x + (sprite_get_width(spr_ui_ribbon)/2),ribbon_starting_y + 40,string(global.correctly_thrown_knives));

draw_set_font(font_monofonto);


//stage 
draw_set_color(c_ui_yellow);
draw_text(ribbon_starting_x + (sprite_get_width(spr_ui_ribbon)/2),ribbon_starting_y + 87,"STAGE " + string(global.stage_number));

draw_set_valign(fa_top);


