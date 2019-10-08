/// @description Insert description here
// You can write your code in this editor



var my_mouse_x = device_mouse_x(0);
var my_mouse_y = device_mouse_y(0);
var button_width = sprite_get_width(sprite_index);
var button_height = sprite_get_height(sprite_index);


if my_mouse_x >= x - (button_width/2) and my_mouse_x <= x + (button_width/2) and my_mouse_y >= y - (button_height/2) and my_mouse_y <= y + (button_height/2) and device_mouse_check_button(0, mb_left)
{
	restart_to_new_session();
}

