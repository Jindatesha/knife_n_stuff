/// @description Insert description here
// You can write your code in this editor
//knockback
max_knockback_amount = 5;
knockback_amount = 0;
min_y = y - (max_knockback_amount * 1.1);
max_y = y;
come_back_speed = 0;
location_of_knives_grid = ds_grid_create(5,10);
location_of_coins_grid = ds_grid_create(2,3);
default_rotation_speed = 1.65;
rotation_speed = default_rotation_speed;

knives_pre_set_on_target = 0;
knives_on_target = 0;
total_knives_needed = 10;

target_sprite = ds_grid_get(global.target_grid,0,global.current_target_number);


//for white flash
flash_alpha = 0;
flash_color = c_white;

target_scale = 1;


//different patterns
hit_counter = 0;
movement_pattern = 0;
my_move_pattern_dir = 1;
is_swapping_move_pattern = false;


max_consecutive_hit_timer = room_speed * 0.55;
consecutive_hit_timer = 0;
consecutive_hit_amount = 0;


has_created_obj_destroyed_target = false;
time_for_target_split = room_speed * 1;
started_split_animation_for_knives = false;
initial_dummy_knife_x_offset = 0;
initial_dummy_knife_y_offset = 0;

