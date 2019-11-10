

var what_movement_pattern = argument[0];

switch(what_movement_pattern)
{
	default:
	case 0:
		//default/regular/basic
		rotation_speed = default_rotation_speed * 1.6;		
	break;
	
	
	
	case 1:
		//another default...speed up and slow back down			

		rotation_speed += (0.03) * my_move_pattern_dir;
		var max_speed = (default_rotation_speed * 3);		
		rotation_speed = clamp(rotation_speed,0,max_speed);
		
		if rotation_speed >= max_speed and is_swapping_move_pattern == false
		{
			is_swapping_move_pattern = true;
			alarm[0] = room_speed * 0.3; 
		}
		
		if rotation_speed <= 0 and is_swapping_move_pattern == false
		{
			is_swapping_move_pattern = true;
			alarm[0] = room_speed * 0.3; 
		}
		
		
	break;
	
	
	
	
	case 2:
	//swirly-dirly	
		if hit_counter > 1
		{
			hit_counter = 0;
		}
		
		
		if hit_counter == 1
		{
			rotation_speed = default_rotation_speed * 1.5;
		}
		else
		{
			rotation_speed = -default_rotation_speed * 1.5;
		}
	break;
	
}















