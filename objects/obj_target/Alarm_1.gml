/// @description create new target


	var dummy_knife_sprite = obj_dummy_knife.sprite_index;
	sprite_set_offset(dummy_knife_sprite, initial_dummy_knife_x_offset,initial_dummy_knife_y_offset);		


	//we no longer have knives in us
	knives_on_target = 0;
	knives_pre_set_on_target = 0;

	ds_grid_clear(location_of_knives_grid,-1);


	has_created_obj_destroyed_target = false;

	consecutive_hit_amount = 0;
	rotation_speed = default_rotation_speed;
	my_move_pattern_dir = 1;
	is_swapping_move_pattern = false;
	
	//moves to next level in stage(up to boss)
	global.current_level_in_stage += 1;
	global.stage_number += 1;
	hit_counter = 0;
	
	with(obj_coin)
	{
		instance_destroy();
	}
	
	//destroy the knives in our target/object
	with(obj_dummy_knife)
	{
		instance_destroy();
	}
	
	//does this new target im about to make...have coin(s) on it?
	var random_number = irandom_range(1,100);
	var how_many_coins = 0;
	
	if random_number >= 50
	{
		random_number = irandom_range(1,100);
		
		if random_number <= 10
		{
			how_many_coins = 3;
		}
		else
		{
			if random_number <= 30
			{
				how_many_coins = 2;
			}
			else
			{
				how_many_coins = 1;
			}
		}
	}
	
	
	
	
	//was this the boss fight?
	if global.current_level_in_stage >= 4
	{
		//swap our target image
		global.current_target_number = irandom_range(TARGET_BOSS.DEFAULT,TARGET_BOSS.LAST_IN_LIST - 1);
		
		
		
		//only do this if its a boss battle specifically
		if global.current_level_in_stage == 4
		{
			global.is_doing_boss_intro = true;
			target_scale = 0.1;
		}
		
		
		
		//this is resetting from boss battle back to regular targets
		if global.current_level_in_stage > 4
		{
			//reset the level for stage
			global.current_level_in_stage = 0;
			
			global.current_target_number = irandom_range(0,TARGET_REGULAR.LAST_IN_LIST - 1);
		}
		
		
		
		
		target_sprite = ds_grid_get(global.target_grid,TARGET.SPRITE,global.current_target_number);
		//target_sprite = spr_target_common_1;
		sprite_index = target_sprite;
	}
	
	
	
	total_knives_needed = ds_grid_get(global.target_grid,TARGET.AMOUNT_OF_KNIVES_TO_THROW,global.current_target_number);
	
	
	
	//if its a boss pattern...set that suckerrr
	movement_pattern = ds_grid_get(global.target_grid,TARGET.MOVEMENT_PATTERN,global.current_target_number);
		
	//choose a random BASIC target movement pattern
	if global.current_target_number <= (TARGET_REGULAR.LAST_IN_LIST - 1)
	{
		
		movement_pattern = irandom_range(0,1);//max number here...gradually more difficult	
			
		var random_pre_set_knives_in_target = irandom_range(0,4);
		
		repeat(random_pre_set_knives_in_target)
		{
			scr_place_dummy_knife(20,irandom_range(0,360),true);
			knives_pre_set_on_target += 1;
		}
		
		total_knives_needed -= random_pre_set_knives_in_target + movement_pattern;		
	}
	
	
	global.starting_knives_amount = total_knives_needed;
	global.knives_left = total_knives_needed;
	
	
	
	//put the coins on the target (as long as this isnt a boss fight)
	if how_many_coins > 0 and global.current_level_in_stage < 4 
	{
		var this_coins_direction = irandom_range(0,360);
		var this_coins_length = 0;
			
		for(var i = 0; i < how_many_coins; i += 1;)
		{	
			coins_on_target = instance_number(obj_coin);
			this_coins_direction = irandom_range(0,360);
			this_coins_length = 0;
			//set this knife's length and direction location so it may rotate with the target	
			do
			{
				this_coins_length += 1;
				
				if collision_circle(x + lengthdir_x(this_coins_length,this_coins_direction),y + lengthdir_y(this_coins_length,this_coins_direction),sprite_get_width(spr_knife_collision_mask),obj_dummy_knife,false,true)
				{
					this_coins_length = 0;
					this_coins_direction = irandom_range(0,360);
				}
			}
			until ( position_empty(x + lengthdir_x(this_coins_length,this_coins_direction),y + lengthdir_y(this_coins_length,this_coins_direction)))
			
			this_coins_length += sprite_get_width(spr_ui_currency_object)/2;
			
			ds_grid_set(location_of_coins_grid,0,i,this_coins_length);
			ds_grid_set(location_of_coins_grid,1,i,this_coins_direction);
	
			with(instance_create_depth(x + lengthdir_x(this_coins_length,this_coins_direction),y + lengthdir_y(this_coins_length,this_coins_direction),depth + 1,obj_coin))
			{
				mask_index = spr_ui_currency_collision;
			}
		}
	}
	
	
	
	

	
	started_split_animation_for_knives = false;
	
	
	