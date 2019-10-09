/// @description Insert description here
// You can write your code in this editor

max_y = y;
come_back_speed = 0;
location_of_knives_grid = ds_grid_create(3,10);
location_of_coins_grid = ds_grid_create(2,3);
rotation_speed = 3;

knives_on_target = 0;

target_sprite = ds_grid_get(global.target_grid,0,global.current_taget_number);

max_knockback_amount = 5;
knockback_amount = 0;


//for white flash
flash_alpha = 0;
flash_color = c_white;









