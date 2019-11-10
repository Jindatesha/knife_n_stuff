
/// @param this_knifes_actual_length
/// @param this_knifes_direction
/// @param knives_are_pre_placed

var this_knifes_actual_length = argument[0];
var this_knifes_direction = argument[1];
var knives_are_pre_placed = argument[2];

//set this knife's length and direction location so it may rotate with the target	
do
{
	this_knifes_actual_length += 1;
	
	if knives_are_pre_placed == true
	{
		if collision_circle(x + lengthdir_x(this_knifes_actual_length,this_knifes_direction),y + lengthdir_y(this_knifes_actual_length,this_knifes_direction),sprite_get_width(spr_knife_collision_mask),obj_dummy_knife,false,true)
		{
			this_knifes_actual_length = 0;
			this_knifes_direction = irandom_range(0,360);
		}
	}
}
until ( position_empty(x + lengthdir_x(this_knifes_actual_length,this_knifes_direction),y + lengthdir_y(this_knifes_actual_length,this_knifes_direction)))
	
var this_knifes_fake_length = this_knifes_actual_length - 30 - (sprite_get_height(global.knife_sprite) - sprite_get_height(spr_knife_default));
	
ds_grid_set(location_of_knives_grid,0,knives_on_target + knives_pre_set_on_target,this_knifes_fake_length);
ds_grid_set(location_of_knives_grid,1,knives_on_target + knives_pre_set_on_target,this_knifes_actual_length);
ds_grid_set(location_of_knives_grid,2,knives_on_target + knives_pre_set_on_target,this_knifes_direction);
ds_grid_set(location_of_knives_grid,3,knives_on_target + knives_pre_set_on_target,random_range(2.5,6));
ds_grid_set(location_of_knives_grid,4,knives_on_target + knives_pre_set_on_target,random_range(4,10));
	
with(instance_create_depth(x + lengthdir_x(this_knifes_actual_length,this_knifes_direction),y + lengthdir_y(this_knifes_actual_length,this_knifes_direction),depth + 1,obj_dummy_knife))
{
	sprite_index = global.knife_sprite;
	fake_x = x - lengthdir_x(this_knifes_actual_length - this_knifes_fake_length,this_knifes_direction);
	fake_y = y - lengthdir_y(this_knifes_actual_length - this_knifes_fake_length,this_knifes_direction);
}
	