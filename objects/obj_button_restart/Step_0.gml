/// @description Insert description here
// You can write your code in this editor



var my_mouse_x = device_mouse_x(0);
var my_mouse_y = device_mouse_y(0);
var button_width = sprite_get_width(sprite_index);
var button_height = sprite_get_height(sprite_index);


if my_mouse_x >= x - (button_width/2) and my_mouse_x <= x + (button_width/2) and my_mouse_y >= y - (button_height/2) and my_mouse_y <= y + (button_height/2) and device_mouse_check_button(0, mb_left)
{
	//start a new run/session
	global.stage_number = 1;
	global.correctly_thrown_knives = 0;
	global.which_target_number = TARGET_REGULAR.DEFAULT;
	global.knives_left = 10;
	global.current_level_in_stage = 0;
	global.knife_collided = false;
	global.current_run_active = true;
	//create the target/object
	instance_create_depth(view_w /2,view_h * 0.35,depth + 1,obj_target);
	
	var knife_sprite_index = ds_grid_get(global.knife_grid,0,global.current_knife_number);
	sprite_set_offset(knife_sprite_index,sprite_get_width(knife_sprite_index)/2,0);
	
	with(obj_end_run_menu)
	{
		instance_destroy();
	}
	
	instance_destroy();
}

