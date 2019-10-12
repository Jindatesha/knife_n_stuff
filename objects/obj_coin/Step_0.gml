/// @description Insert description here
// You can write your code in this editor
var collided_knife = instance_place(x,y,obj_knife);

if collided_knife != noone and global.current_run_active == true
{	
	global.currency += 1;
	
	var gain_coin_sound = sound_gain_coin;
	audio_sound_gain(gain_coin_sound,global.sound_effects_volume, 0);
	audio_play_sound(gain_coin_sound,10,false);
	
	//before we delete ourselves...remove this particular coin from the ds grid in obj_target
	with(obj_target)
	{
		var row;
		var num_of_coins = instance_number(obj_coin);
		
		if num_of_coins > 1
		{
			for(var i = 0; i < num_of_coins; i += 1;)
			{
				if instance_find(obj_coin, i) == other.id
				{
					row = i;
					break;
				}
			}

			scr_remove_grid_row(location_of_coins_grid,row);
			ds_grid_resize(location_of_coins_grid,ds_grid_width(location_of_coins_grid),3);
		}
	}
	
	
	instance_destroy();
}	
	
	
	
	