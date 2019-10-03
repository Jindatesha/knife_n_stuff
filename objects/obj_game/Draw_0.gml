/// @description Insert description here
// You can write your code in this editor




//draw the knife
if draw_knife == true and global.current_run_active == true
{
	draw_sprite(spr_knife_default,0,knife_starting_loc_x,knife_starting_loc_y);
}

var still_have_this_knife = 0;
//draw the ui for how many knives you need to throw
for(var i = 0; i < starting_knives_amount; i += 1;)
{
	
	if global.knives_left > i
	{
		still_have_this_knife = 1;
	}
	else
	{
		still_have_this_knife = 0;
	}
	
	
	//draw the actual sprite
	draw_sprite(spr_ui_knives_left,still_have_this_knife,knives_left_ui_loc_x,knives_left_ui_loc_y - (knives_left_ui_gap * i));
}




#region total knives correctly thrown in target/object this run

draw_set_halign(fa_left);
draw_text(correct_knives_loc_x,correct_knives_loc_y,string(global.correctly_thrown_knives));
	

#endregion



#region stage ui
var what_stage_ui_width = sprite_get_width(spr_ui_stage);
var levels_in_stage = 5;
var what_sprite = 0;
if global.current_level_in_stage == 4
{
	levels_in_stage = 1;
}
for(var i = 0; i < levels_in_stage; i += 1;)
{
	if levels_in_stage > 1
	{
		if i < 4
		{
			what_sprite = 0;
			if i <= global.current_level_in_stage
			{
				what_sprite = 1;
			}
		}
		else
		{
			what_sprite = 2;
		}
	}
	else
	{
		what_sprite = 3;
	}
	
	//draw the actual ui bit
	draw_sprite(spr_ui_stage,what_sprite,stage_ui_starting_x + (i * what_stage_ui_width) - ((levels_in_stage * what_stage_ui_width)/2),stage_ui_starting_y);
}



//what stage number are you on
draw_set_halign(fa_middle);
draw_text(stage_ui_number_starting_x,stage_ui_number_starting_y,"STAGE " + string(global.stage_number));

#endregion


#region currency ui
	
	draw_set_halign(fa_right);
	draw_text(currency_ui_starting_x - sprite_get_width(spr_ui_currency) - 5,currency_ui_starting_y,string(global.currency));
	draw_sprite(spr_ui_currency,0,currency_ui_starting_x,currency_ui_starting_y);
	
	
#endregion



#region white flash if needed
	if (flash_alpha > 0)
	{
		gpu_set_blendmode(bm_add);
		
		draw_sprite_stretched_ext(spr_white_block,0,0,0,view_w,view_h,c_white,flash_alpha);
		
		gpu_set_blendmode(bm_normal);
	}
	else
	{
		if global.current_run_active == false
		{
			var knife_sprite_index = ds_grid_get(global.knife_grid,0,global.current_knife_number);
			sprite_set_offset(knife_sprite_index,sprite_get_width(knife_sprite_index)/2,0);
			
			
			with(obj_dummy_knife)
			{
				instance_destroy();
			}
			
			
			with(obj_target)
			{
				ds_grid_destroy(location_of_knives_grid);
				instance_destroy();
			}
			

		
		
			//if menu doesnt exist, create one
			if !instance_exists(obj_end_run_menu)
			{
				instance_create_depth(x,y,depth - 1,obj_end_run_menu);
			}
		
		}
	}
#endregion
