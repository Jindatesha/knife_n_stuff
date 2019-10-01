/// @description Insert description here
// You can write your code in this editor



//if we tap to throw a knife
if mouse_check_button_pressed(mb_left) and global.knives_left > 0
{
	global.knives_left -= 1;
	
	instance_create_depth(knife_starting_loc_x,knife_starting_loc_y,depth,obj_knife);
}