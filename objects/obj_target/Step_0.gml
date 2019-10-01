/// @description Insert description here
// You can write your code in this editor




image_angle += rotation_speed;


//if a knife hits us, delete it
var collided_knife = instance_place(x,y,obj_knife);

if collided_knife != noone
{
	
	//set this knife's length and direction location so it may rotate with the target
	var this_knifes_length = point_distance(x,y,collided_knife.x,collided_knife.y) - 15;
	var this_knifes_direction = point_direction(x,y,collided_knife.x,collided_knife.y);
	ds_grid_set(location_of_knives_grid,0,knives_on_target,this_knifes_length);
	ds_grid_set(location_of_knives_grid,1,knives_on_target,this_knifes_direction);
	
	instance_create_depth(collided_knife.x,collided_knife.y,depth + 1,obj_dummy_knife);
	
	with(collided_knife)
	{
		instance_destroy();
	}
	
	knives_on_target += 1;
	
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

