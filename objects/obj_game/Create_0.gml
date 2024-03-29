/// @description Insert description here
// You can write your code in this editor

//game run speed
game_set_speed(60, gamespeed_fps);

updated_fps = 0;
time_to_update_fps = 0;
average_fps_list = ds_list_create();

//macros
#macro view view_camera[0]

//camera settings
ideal_width = 320;
ideal_height = 480;
camera_set_view_size(view,ideal_width,ideal_height);


#macro view_w camera_get_view_width(view)
#macro view_h camera_get_view_height(view)

//colors
#macro c_ui_yellow make_color_rgb(228,178,42)
#macro c_ui_blue make_color_rgb(174,234,162)



//font
draw_set_color(c_ui_yellow);
draw_set_font(font_monofonto);


//sound globals
global.sound_effects_volume = 1;
global.music_volume = 1;




//enum of all the targets

//regular target/object  grid
enum TARGET_REGULAR
{
	DEFAULT,
	DEFAULT_TOO,
	LAST_IN_LIST
}



//boss targets
enum TARGET_BOSS
{
	DEFAULT = TARGET_REGULAR.LAST_IN_LIST,
	PIE,
	//DEFAULT_TOO,
	LAST_IN_LIST
}




enum TARGET
{
	SPRITE,
	NAME,
	UNLOCKED,
	COST,
	EQUIPPED,
	ANIMATION_SPRITE,
	BREAK_OFF_BITS,
	ON_HIT_SOUND,
	MOVEMENT_PATTERN,
	AMOUNT_OF_KNIVES_TO_THROW
	
}

//grid of all the targets
//start with common and move up to epic
//width: image,break apart animation sprite,break off bits image,on hit sound effect,
global.target_grid = ds_grid_create(10,0);



//add all the targets and their values
//common
scr_add_target_to_grid(spr_target,"simple",true,0,true,spr_target,spr_target_normal_default_bits,sound_knife_hit_target_common_default,0,10);
scr_add_target_to_grid(spr_target_common_1,"diff",true,0,false,spr_target_common_1,spr_target_normal_1_bits,sound_knife_hit_target_common_default,0,10);

//bosses
//common
scr_add_target_to_grid(spr_target_boss_common_1,"DONUT",true,0,false,spr_target_boss_common_1,spr_target_boss_common_1_bits,sound_knife_hit_target_common_default,2,5);
scr_add_target_to_grid(spr_target_boss_pie,"PIE",true,0,false,spr_target_boss_pie,spr_target_boss_pie_bits,sound_knife_hit_target_common_default,2,5);






//boss targets
enum KNIFE_COMMON
{
	DEFAULT = 0,
	SCISSOR,
	BUTTERKNIFE,
	LAST_IN_LIST
}

enum KNIFE_EPIC // epic
{
	DEFAULT = KNIFE_COMMON.LAST_IN_LIST,
	STINGRAY,
	LAST_IN_LIST
}

enum KNIFE_CHAMPION //champion
{
	DEFAULT = KNIFE_EPIC.LAST_IN_LIST,
	DEFAULT_TOO,
	LAST_IN_LIST
}

//knife grid
global.knife_grid = ds_grid_create(5,0);


//add all the knives to the grid
#region common knives

//default
scr_add_knife_to_grid(spr_knife_default,"Basic",true,0,true);
scr_add_knife_to_grid(spr_knife_scissor,"Scissor",false,1,false);
scr_add_knife_to_grid(spr_knife_butterknife,"Butterknife",false,1,false);
#endregion


#region Epic knives

scr_add_knife_to_grid(spr_knife_rambo,"Ramboh",false,1,false);
scr_add_knife_to_grid(spr_knife_stingray,"Stingray",false,1,false);

#endregion


#region Champion

scr_add_knife_to_grid(spr_knife_dart,"Dart",false,1,false);

#endregion






//knife grid
global.wall_grid = ds_grid_create(5,0);


//add all the knives to the grid
//common
scr_add_wall_to_grid(spr_background_basic,"Basic",true,0,true);






//knife stuff
global.starting_knives_amount = 10;
global.knives_left = global.starting_knives_amount;
knife_starting_loc_x = view_w / 2;
knife_ending_loc_y = (view_h * 0.8) - sprite_get_height(spr_knife_default) + sprite_get_height(spr_ui_knives_left);
knife_starting_loc_y = knife_ending_loc_y + 35;
knife_current_loc_y = knife_starting_loc_y;
draw_knife_alpha = 0;

//knife ui stuff
knives_left_ui_loc_x =  view_w * 0.06;
knives_left_ui_loc_y =  view_h * 0.8;
knives_left_ui_gap = sprite_get_height(spr_ui_knives_left) - 5;


//ui for stages
stage_ui_starting_x = view_w / 2;
stage_ui_starting_y = view_h * 0.04;
global.current_level_in_stage = 0;

//stage number#
stage_ui_number_starting_x = view_w / 2;
stage_ui_number_starting_y = (view_h * 0.04) + sprite_get_height(spr_ui_stage) + 4;
global.stage_number = 1;

//ui for in-game currency
//have this right aligned
currency_ui_starting_x = view_w * 0.94;
currency_ui_starting_y = view_h * 0.008;
global.currency = 0;


//total correctly thrown this run
correct_knives_loc_x = view_w * 0.06;
correct_knives_loc_y = view_h * 0.008;
global.correctly_thrown_knives = 0;



//which target are we talking about?
var which_grid_id = global.target_grid;
var false_grid_pos,what_value;
for(var i = 0; i < ds_grid_height(which_grid_id); i += 1;)
{
	what_value = ds_grid_get(which_grid_id,4,i);
	if what_value == true
	{
		false_grid_pos = i;
		break;
	}
}
		
global.current_target_number = false_grid_pos;
global.target_sprite = ds_grid_get(which_grid_id,0,global.current_target_number);






//which knife are we talking about?
//equip this thing
//which one was false?
var which_grid_id = global.knife_grid;
var false_grid_pos,what_value;
for(var i = 0; i < ds_grid_height(which_grid_id); i += 1;)
{
	what_value = ds_grid_get(which_grid_id,4,i);
	if what_value == true
	{
		false_grid_pos = i;
		break;
	}
}
		
global.current_knife_number = false_grid_pos;
global.knife_sprite = ds_grid_get(which_grid_id,0,global.current_knife_number);



//wall
var which_grid_id = global.wall_grid;
var false_grid_pos,what_value;
for(var i = 0; i < ds_grid_height(which_grid_id); i += 1;)
{
	what_value = ds_grid_get(which_grid_id,4,i);
	if what_value == true
	{
		false_grid_pos = i;
		break;
	}
}
		
global.current_wall_number = false_grid_pos;
global.wall_sprite = ds_grid_get(which_grid_id,0,global.current_wall_number);





//so we can draw it
draw_knife = true;



//for flash white effect
global.knife_collided = false;
flash_alpha = 0;
flash_color = c_white;

//is this run/session still active (havent failed yet)
global.current_run_active = true;


//making sure we can create the ned run ui but not if we click shop boi
can_create_end_run_menu = true;

//fade ui if run is over
ui_alpha = 1;

//background image
background_image = spr_background_basic;

//for boss intro/animations
global.is_doing_boss_intro = false;
started_timer_to_boss_battle = false;
initial_time_till_boss_starts = room_speed * 1;
ui_warning_alpha_angle = 0;
ui_warning_alpha = 1;



//create the target/object
//instance_create_depth(view_w /2,view_h * 0.35,depth + 1,obj_target);

instance_create_depth(view_w /2,view_h * 0.35,depth + 2,obj_target_bits);

//
instance_create_depth(x,y,depth,obj_main_menu);




