/// @description Insert description here
// You can write your code in this editor

//mouse x/y
var my_mouse_x = device_mouse_x(0);
var my_mouse_y = device_mouse_y(0);


#region home button


//if i click it...leave this menu
var mouse_in_circle = point_in_circle(my_mouse_x,my_mouse_y,settings_ui_starting_x,settings_ui_starting_y,settings_button_width);
if mouse_in_circle != true
{
	settings_button_clicked = false;
}


if device_mouse_check_button_pressed(0,mb_left) and mouse_in_circle
{
	settings_button_clicked = true;
}



if device_mouse_check_button_released(0,mb_left) and mouse_in_circle and (settings_button_clicked == true)
{
	//instance_create_depth(x,y,depth,obj_main_menu);
}

//draw the button
draw_sprite(spr_ui_button_settings,0,settings_ui_starting_x,settings_ui_starting_y);

#endregion




#region currency ui
	draw_set_halign(fa_right);
	draw_text_ext_color(currency_ui_starting_x - sprite_get_width(spr_ui_currency) - 5,currency_ui_starting_y,string(global.currency),0,300,my_color,my_color,my_color,my_color,1);
	draw_sprite(spr_ui_currency,0,currency_ui_starting_x,currency_ui_starting_y);	
#endregion