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
if knives_on_target == total_knives_needed and has_created_obj_destroyed_target == false
{
	has_created_obj_destroyed_target = true; 
	
	for(var i = 0; i < sprite_get_number(spr_texture_break_target); i += 1;)
	{
		with(instance_create_depth(x,y,depth - 2,obj_destroyed_target))
		{
			my_sub_image = i;
			initial_targets_image = other.sprite_index;
			time_for_target_split = other.time_for_target_split;
			#region set direction
	switch(my_sub_image)
	{
		case 0:
		{
			direction = irandom_range(320,360);
		}
		break;
	
		case 1:
		{
			direction = irandom_range(140,170);
		}
		break;
	
		case 2:
		{
			direction = irandom_range(60,110);
		}
		break;
	
		case 3:
		{
			direction = irandom_range(220,260);
		}
		break;
	
		case 4:
		{
			direction = irandom_range(270,300);
		}
		break;
	}
#endregion

		}
	}
	
	//play the sound
	var target_destroy_sound = sound_target_break;
	audio_sound_gain(target_destroy_sound,global.sound_effects_volume, 0);
	audio_play_sound(target_destroy_sound,10,false);
	
	
	alarm[1] = time_for_target_split;
	
}

