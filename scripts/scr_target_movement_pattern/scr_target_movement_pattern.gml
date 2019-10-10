

var what_movement_pattern = argument[0];

switch(what_movement_pattern)
{
	default:
	case 0:
		//default/regular/basic
		rotation_speed = default_rotation_speed;		
	break;
	
	case 1:
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















