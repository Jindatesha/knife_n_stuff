/// @description Insert description here
// You can write your code in this editor


if global.current_run_active == true and ive_collided == false
{
	//fly upwards
	y -= move_speed;

	//if we collide with a dummy knife(a previous knife stuck in the target...)
	var collided_knife = instance_place(x,y,obj_dummy_knife);

	if collided_knife != noone
	{
		/* 
		white flash,screen shake on all ui and target, white circle appears and 
		expands somewhat and fades,knife to rotate and fall to bottom of screen,
		everything left on screen fades out (leaving background) 
		....
		***then game over screen pulls up***
		display score that run...
		continue but you have to watch an ad -> if second try then knives shop screen
		restart button
		*/
		
		//current width = 12
		
		var ricochet_sound = sound_knife_ricochet;
		audio_sound_gain(ricochet_sound,global.sound_effects_volume, 0);
		audio_play_sound(ricochet_sound,10,false);
	
		global.knife_collided = true;
		global.current_run_active = false;
		random_knive_richochet_x = irandom_range(0,3);
		switch(random_knive_richochet_x)
		{
			case 0:
				random_knive_richochet_x = -(move_speed/3);
			break;
			
			case 1:
				random_knive_richochet_x = -(move_speed/2);
			break;
			
			case 2:
				random_knive_richochet_x = (move_speed/2);
			break;
			
			case 3:
				random_knive_richochet_x = (move_speed/3);
			break;
		}
		ive_collided = true;

		
	}

}
else
{
	y += move_speed/2;
	x += random_knive_richochet_x;
	
	image_angle += random_knive_richochet_x * 4;
	
	if y > (view_h * 2)
	{
		instance_destroy();
	}
	
}


if global.current_run_active == false
{
	var knife_sprite_index = ds_grid_get(global.knife_grid,0,global.current_knife_number);
	sprite_set_offset(knife_sprite_index,sprite_get_width(knife_sprite_index)/2,sprite_get_height(knife_sprite_index)/2);
}

