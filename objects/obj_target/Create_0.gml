/// @description Insert description here
// You can write your code in this editor


location_of_knives_grid = ds_grid_create(2,10);
rotation_speed = 3;

knives_on_target = 0;

target_sprite = ds_grid_get(global.target_grid,0,global.which_target_number);
