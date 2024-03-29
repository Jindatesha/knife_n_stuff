/// @description Insert description here
// You can write your code in this editor

//draw framerate
draw_set_halign(fa_left);
time_to_update_fps -= 1

if time_to_update_fps <= 0
{
	
	ds_list_add(average_fps_list,round(fps_real));
	var total_qeuery_size = 20;
	
	if ds_list_size(average_fps_list) >= total_qeuery_size
	{
		time_to_update_fps = room_speed * 0.7;
		
		var total_fps = 0;
		
		
		for(var i = 0; i < total_qeuery_size; i += 1;)
		{
			total_fps += ds_list_find_value(average_fps_list,i)
		}
		
		updated_fps = round(total_fps/total_qeuery_size);
		ds_list_clear(average_fps_list);
	}
}

draw_text(40,view_h - 40,string(updated_fps));


//draw the knife
if draw_knife == true and global.current_run_active == true
{
	knife_current_loc_y -= 4;
	knife_current_loc_y = clamp(knife_current_loc_y,knife_ending_loc_y,knife_starting_loc_y);
	draw_knife_alpha += 0.14;
	draw_knife_alpha = clamp(draw_knife_alpha,0,1);
	if draw_knife_alpha > ui_alpha
	{
		draw_knife_alpha = ui_alpha;
	}
	
	draw_sprite_ext(global.knife_sprite,0,knife_starting_loc_x,knife_current_loc_y,1,1,0,c_white,draw_knife_alpha);
}


//start to fade ui if current run is over
if global.current_run_active == false or global.is_doing_boss_intro == true
{
	ui_alpha -= 0.04;
	ui_alpha = clamp(ui_alpha,0,1);
}


var my_color = c_ui_yellow;


#region knives left ui show how many we need/have thrown this stage

	var still_have_this_knife = 0;
	//draw the ui for how many knives you need to throw
	for(var i = 0; i < global.starting_knives_amount; i += 1;)
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
		draw_sprite_ext(spr_ui_knives_left,still_have_this_knife,knives_left_ui_loc_x,knives_left_ui_loc_y - (knives_left_ui_gap * i),1,1,0,c_white,ui_alpha);
	}

#endregion


#region total knives correctly thrown in target/object this run
draw_set_halign(fa_left);
draw_text_ext_color(correct_knives_loc_x,correct_knives_loc_y,string(global.correctly_thrown_knives),0,300,my_color,my_color,my_color,my_color,ui_alpha);
	
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
	draw_sprite_ext(spr_ui_stage,what_sprite,stage_ui_starting_x + (i * what_stage_ui_width) - ((levels_in_stage * what_stage_ui_width)/2),stage_ui_starting_y,1,1,0,c_white,ui_alpha);
}



//what stage number are you on
draw_set_halign(fa_middle);
if global.current_level_in_stage != 4
{
	draw_text_ext_color(stage_ui_number_starting_x,stage_ui_number_starting_y,"STAGE " + string(global.stage_number),0,300,my_color,my_color,my_color,my_color,ui_alpha);
}
else
{
	//its a boss battle
	if global.is_doing_boss_intro == true
	{		
		if started_timer_to_boss_battle == false
		{
			started_timer_to_boss_battle = true;
			alarm[1] = initial_time_till_boss_starts;
		}
		
		ui_warning_alpha_angle -= 7;
		ui_warning_alpha += sin(degtorad(ui_warning_alpha_angle))/10;
		ui_warning_alpha = clamp(ui_warning_alpha,0.2,0.8);
		draw_sprite_ext(spr_ui_warning,0,view_w/2,view_h * 0.4,1,1,0,c_white,ui_warning_alpha);
		
	}
	else
	{
	
		
		var bosses_name = ds_grid_get(global.target_grid,1,global.current_target_number);
		draw_text_ext_color(stage_ui_number_starting_x,stage_ui_number_starting_y,"BOSS: " + bosses_name,0,300,my_color,my_color,my_color,my_color,ui_alpha);
	}
}
#endregion


#region currency ui
	
	draw_set_halign(fa_right);
	draw_text_ext_color(currency_ui_starting_x - sprite_get_width(spr_ui_currency) - 5,currency_ui_starting_y,string(global.currency),0,300,my_color,my_color,my_color,my_color,ui_alpha);
	draw_sprite_ext(spr_ui_currency,0,currency_ui_starting_x,currency_ui_starting_y,1,1,0,c_white,ui_alpha);
	
	
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
			
			
			with(obj_coin)
			{
				instance_destroy();
			}
			
			
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
			if !instance_exists(obj_end_run_menu) and can_create_end_run_menu == true
			{
				can_create_end_run_menu = false;
				instance_create_depth(x,y,depth - 1,obj_end_run_menu);
			}
		
		}
	}
#endregion
