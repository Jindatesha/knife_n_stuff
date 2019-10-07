/// @description Insert description here
// You can write your code in this editor


//if we tap to throw a knife
if mouse_check_button_pressed(mb_left) and global.knives_left > 0 and global.current_run_active == true
{
	global.knives_left -= 1;
	
	instance_create_depth(knife_starting_loc_x,knife_starting_loc_y,depth,obj_knife);
	draw_knife = false;
	alarm[0] = room_speed * 0.5;
}




if global.knife_collided == true
{
	global.knife_collided = false;
	flash_alpha = 0.6;
}

if (flash_alpha > 0)
{
	flash_alpha -= 0.02;
}


