

var my_mouse_x = device_mouse_x(0);
var my_mouse_y = device_mouse_y(0);
var button_width = sprite_get_width(sprite_index);
var button_height = sprite_get_height(sprite_index);


if my_mouse_x >= x - (button_width/2) and my_mouse_x <= x + (button_width/2) and my_mouse_y >= y - (button_height/2) and my_mouse_y <= y + (button_height/2) and device_mouse_check_button(0, mb_left)
{
	//make sure end run ui doesnt keep popping back up
	obj_game.can_create_end_run_menu = false;
	
	//swap background
	obj_game.background_image = spr_background_shop;


	//clean other objects in room
	with(obj_end_run_menu)
	{
		instance_destroy();
	}
	
	with(obj_button_restart)
	{
		instance_destroy();
	}
	
	with(obj_main_menu)
	{
		instance_destroy();
	}
	
	
	//create the ui object for the shop
	instance_create_depth(x,y,depth,obj_ui_shop);
	
	
	
	
	//destroy ourselves as well
	instance_destroy();
}

