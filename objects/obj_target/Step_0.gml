/// @description Insert description here
// You can write your code in this editor




image_angle += rotation_speed;


//if a knife hits us, delete it
var collided_knife = instance_place(x,y,obj_knife);

if collided_knife != noone
{
	
	//set this knife's length and direction location so it may rotate with the target
	var this_knifes_length = point_distance(x,y,collided_knife.x,collided_knife.y) - 37;
	var this_knifes_direction = point_direction(x,y,collided_knife.x,collided_knife.y);
	ds_grid_set(location_of_knives_grid,0,knives_on_target,this_knifes_length);
	ds_grid_set(location_of_knives_grid,1,knives_on_target,this_knifes_direction);
	
	instance_create_depth(collided_knife.x,collided_knife.y,depth + 1,obj_dummy_knife);
	
	with(collided_knife)
	{
		instance_destroy();
	}
	
	knives_on_target += 1;
	global.correctly_thrown_knives += 1;
	
	//slap down some particles (ie: wood chips)
	with(obj_target_bits)
	{
		event_user(0);
	}
	

	
}


//update rotation and position of all my knives 
for(var i = 0; i < knives_on_target; i += 1;)
{
	var d = i;
	var this_knifes_length = ds_grid_get(location_of_knives_grid,0,i);
	var this_knifes_direction = ds_grid_get(location_of_knives_grid,1,i);
	
	ds_grid_set(location_of_knives_grid,1,i,this_knifes_direction + rotation_speed);
	
	with(instance_find(obj_dummy_knife,i))
	{
		x = other.x + lengthdir_x(this_knifes_length,this_knifes_direction);	
		y = other.y + lengthdir_y(this_knifes_length,this_knifes_direction);
		image_angle = this_knifes_direction + 90;
	}	
}



//if we reached the set number of knives we needed to throw are correctly stuck inside the target
if knives_on_target == 10
{
	//moves to next level in stage(up to boss)
	global.current_level_in_stage += 1;
	global.stage_number += 1;
	
	//was this the boss fight?
	if global.current_level_in_stage >= 4
	{
		//swap our target image
		global.which_target_number = irandom_range(TARGET_BOSS_COMMON.DEFAULT,TARGET_BOSS_COMMON.LAST_IN_LIST - 1);

		
		if global.current_level_in_stage > 4
		{
			//reset the level for stage
			global.current_level_in_stage = 0;
			
			global.which_target_number = irandom_range(0,TARGET_REGULAR.LAST_IN_LIST - 1);
		}
		
		target_sprite = ds_grid_get(global.target_grid,0,global.which_target_number);
		//target_sprite = spr_target_common_1;
		sprite_index = target_sprite;
	}
	
	//destroy the knives in our target/object
	with(obj_dummy_knife)
	{
		instance_destroy();
	}
	
	//we no longer have knives in us
	knives_on_target = 0;
	
	//reset number of knives that we can throw
	global.knives_left = 10;
}

