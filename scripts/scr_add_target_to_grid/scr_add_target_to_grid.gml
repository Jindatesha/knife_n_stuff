/// scr_add_target_to_grid();
/// @param target_sprite
/// @param target_animation_sprite_sheet
/// @param target_break_off_bits
/// @param target_on_hit_sound_effect


var target_sprite = argument[0];
var target_animation_sprite_sheet = argument[1];
var target_break_off_bits = argument[2];
var target_on_hit_sound_effect = argument[3];


//get and resize the grid to fit our new target in
var width_of_grid = ds_grid_width(global.target_grid);
var height_of_grid = ds_grid_height(global.target_grid);
ds_grid_resize(global.target_grid,width_of_grid,height_of_grid + 1);


//add all the values to our new grid slot
for(var i = 0; i < width_of_grid; i += 1;)
{
	ds_grid_add(global.target_grid,i,height_of_grid,argument[i]);
}






