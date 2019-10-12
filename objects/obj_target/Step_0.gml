/// @description Insert description here
// You can write your code in this editor


scr_target_movement_pattern(movement_pattern);

image_angle += rotation_speed;

consecutive_hit_timer -= 1
if consecutive_hit_timer <= 0
{
	consecutive_hit_amount = 0;
}

//if a knife hits us, delete it
var collided_knife = instance_place(x,y,obj_knife);

if collided_knife != noone and global.current_run_active == true
{
	hit_counter += 1;
	
	
	//play the sound
	consecutive_hit_amount += 1;
	consecutive_hit_timer = max_consecutive_hit_timer;
	consecutive_hit_amount = clamp(consecutive_hit_amount,0,10);
	
	var target_hit_sound = sound_knife_hit_target_common_default;
	audio_sound_gain(target_hit_sound,global.sound_effects_volume, 0);
	audio_sound_pitch(target_hit_sound, 1 + (0.05 * consecutive_hit_amount));
	audio_play_sound(target_hit_sound,10,false);
	
	
	
	//set this knife's length and direction location so it may rotate with the target
	var this_knifes_actual_length = point_distance(x,y,collided_knife.x,collided_knife.y);
	var this_knifes_direction = point_direction(x,y,collided_knife.x,collided_knife.y);
	
	//destroy collided knife now so that we can have a proper place meeting
	with(collided_knife)
	{
		instance_destroy();
	}
	
	//set this knife's length and direction location so it may rotate with the target	
	do
	{
		this_knifes_actual_length += 1;
	}
	until ( position_empty(x + lengthdir_x(this_knifes_actual_length,this_knifes_direction),y + lengthdir_y(this_knifes_actual_length,this_knifes_direction)))
	
	var this_knifes_fake_length = this_knifes_actual_length - 30 - (sprite_get_height(global.knife_sprite) - sprite_get_height(spr_knife_default));
	
	ds_grid_set(location_of_knives_grid,0,knives_on_target,this_knifes_fake_length);
	ds_grid_set(location_of_knives_grid,1,knives_on_target,this_knifes_actual_length);
	ds_grid_set(location_of_knives_grid,2,knives_on_target,this_knifes_direction);
	
	with(instance_create_depth(x + lengthdir_x(this_knifes_actual_length,this_knifes_direction),y + lengthdir_y(this_knifes_actual_length,this_knifes_direction),depth + 1,obj_dummy_knife))
	{
		sprite_index = global.knife_sprite;
		fake_x = x - lengthdir_x(this_knifes_actual_length - this_knifes_fake_length,this_knifes_direction);
		fake_y = y - lengthdir_y(this_knifes_actual_length - this_knifes_fake_length,this_knifes_direction);
	}
	
	
	
	knives_on_target += 1;
	global.correctly_thrown_knives += 1;
	
	//slap down some particles (ie: wood chips)
	with(obj_target_bits)
	{
		event_user(0);
	}
	
	
	flash_alpha = 0.5;	
	knockback_amount = max_knockback_amount;
}



if (knockback_amount > 0)
{
	knockback_amount -= 1;
	y -= knockback_amount;
	come_back_speed = 0;
}
else
{
	come_back_speed += 1;
	y += come_back_speed;
	y = clamp(y,min_y,max_y);
}








if (flash_alpha > 0)
{
	flash_alpha -= (0.5/8);
}
	





if global.current_run_active == false
{
	var knife_sprite_index = ds_grid_get(global.knife_grid,0,global.current_knife_number);
	sprite_set_offset(knife_sprite_index,sprite_get_width(knife_sprite_index)/2,0);
	//sprite_set_offset(sprite_index,sprite_get_width(sprite_index)/2,sprite_get_height(sprite_index)/2);
}



//update rotation and position of all my knives 
for(var i = 0; i < knives_on_target; i += 1;)
{
	var this_knifes_fake_length = ds_grid_get(location_of_knives_grid,0,i);
	var this_knifes_actual_length = ds_grid_get(location_of_knives_grid,1,i);
	var this_knifes_direction = ds_grid_get(location_of_knives_grid,2,i);
	
	//add to its rotation
	ds_grid_set(location_of_knives_grid,2,i,this_knifes_direction + rotation_speed);
	
	with(instance_find(obj_dummy_knife,i))
	{
		fake_x = other.x + lengthdir_x(this_knifes_fake_length,this_knifes_direction);	
		fake_y = other.y + lengthdir_y(this_knifes_fake_length,this_knifes_direction);
		
		x = other.x + lengthdir_x(this_knifes_actual_length,this_knifes_direction);	
		y = other.y + lengthdir_y(this_knifes_actual_length,this_knifes_direction);
		image_angle = this_knifes_direction + 90;
	}	
}


//update rotation/location for coins
//update rotation and position of all my coins 
var coins_on_target = instance_number(obj_coin);

for(var i = 0; i < coins_on_target; i += 1;)
{
	var this_coins_length = ds_grid_get(location_of_coins_grid,0,i);
	var this_coins_direction = ds_grid_get(location_of_coins_grid,1,i);
	
	ds_grid_set(location_of_coins_grid,1,i,this_coins_direction + rotation_speed);
	
	with(instance_find(obj_coin,i))
	{
		x = other.x + lengthdir_x(this_coins_length,this_coins_direction);	
		y = other.y + lengthdir_y(this_coins_length,this_coins_direction);
		image_angle = this_coins_direction + 90;
	}	
}



//if we reached the set number of knives we needed to throw are correctly stuck inside the target
if knives_on_target == total_knives_needed
{
		//play the sound
	var target_destroy_sound = sound_target_break;
	audio_sound_gain(target_destroy_sound,global.sound_effects_volume, 0);
	audio_play_sound(target_destroy_sound,10,false);
	consecutive_hit_amount = 0;
	
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
	global.starting_knives_amount = total_knives_needed;
	global.knives_left = total_knives_needed;
	
	
	//if its a boss pattern...set that suckerrr
	movement_pattern = ds_grid_get(global.target_grid,TARGET.MOVEMENT_PATTERN,global.current_target_number);
		
	//choose a random BASIC target movement pattern
	if global.current_target_number <= (TARGET_REGULAR.LAST_IN_LIST - 1)
	{
		movement_pattern = irandom_range(0,1);
	}
	
	
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
	
	
	
	
	//we no longer have knives in us
	knives_on_target = 0;
	
}

