//start a new run/session
	global.stage_number = 1;
	global.correctly_thrown_knives = 0;
	global.current_target_number = TARGET_REGULAR.DEFAULT;	
	global.current_level_in_stage = 0;
	global.knife_collided = false;
	global.current_run_active = true;
	
	var total_knives_needed = ds_grid_get(global.target_grid,TARGET.AMOUNT_OF_KNIVES_TO_THROW,global.current_target_number);
	global.starting_knives_amount = total_knives_needed;
	global.knives_left = total_knives_needed;
	
	//create the target/object
	instance_create_depth(view_w /2,view_h * 0.35,depth + 1,obj_target);
	
	var knife_sprite_index = ds_grid_get(global.knife_grid,0,global.current_knife_number);
	sprite_set_offset(knife_sprite_index,sprite_get_width(knife_sprite_index)/2,0);
	
	with(obj_game)
	{
		ui_alpha = 1;
		can_create_end_run_menu = true;
		background_image = spr_background_basic;
	}
	
	
	with(obj_button_shop)
	{
		instance_destroy();
	}
	
	
	with(obj_end_run_menu)
	{
		instance_destroy();
	}
	
	instance_destroy();