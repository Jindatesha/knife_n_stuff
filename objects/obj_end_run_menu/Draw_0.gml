/// @description Insert description here
// You can write your code in this editor


//mouse x/y
var my_mouse_x = device_mouse_x(0);
var my_mouse_y = device_mouse_y(0);

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
draw_set_color(c_ui_blue);
draw_text(ribbon_starting_x + (sprite_get_width(spr_ui_ribbon)/2),ribbon_starting_y + 87,"STAGE " + string(global.stage_number));

draw_set_valign(fa_top);


#region home button


//if i click it...leave this menu
var mouse_in_circle = point_in_circle(my_mouse_x,my_mouse_y,home_ui_starting_x,home_ui_starting_x,home_button_width);
if mouse_in_circle != true
{
	home_button_clicked = false;
}


if device_mouse_check_button_pressed(0,mb_left) and mouse_in_circle
{
	home_button_clicked = true;
}



if device_mouse_check_button_released(0,mb_left) and mouse_in_circle and (home_button_clicked == true)
{
	instance_create_depth(x,y,depth,obj_main_menu);
}

//draw the button
draw_sprite(spr_ui_button_home,0,home_ui_starting_x,home_ui_starting_y);

#endregion




#region currency ui
	draw_set_halign(fa_right);
	draw_text_ext_color(currency_ui_starting_x - sprite_get_width(spr_ui_currency) - 5,currency_ui_starting_y,string(global.currency),0,300,my_color,my_color,my_color,my_color,1);
	draw_sprite(spr_ui_currency,0,currency_ui_starting_x,currency_ui_starting_y);	
#endregion