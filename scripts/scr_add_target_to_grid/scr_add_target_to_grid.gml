/// scr_add_target_to_grid();
/// @param target_sprite
/// @param name
/// @param unlocked
/// @param cost
/// @param equipped
/// @param target_animation_sprite_sheet
/// @param target_break_off_bits
/// @param target_on_hit_sound_effect
/// @param movement_pattern
/// @param amount_of_knives_to_throw


//get and resize the grid to fit our new target in
var width_of_grid = ds_grid_width(global.target_grid);
var height_of_grid = ds_grid_height(global.target_grid);
ds_grid_resize(global.target_grid,width_of_grid,height_of_grid + 1);


//add all the values to our new grid slot
for(var i = 0; i < width_of_grid; i += 1;)
{
	ds_grid_add(global.target_grid,i,height_of_grid,argument[i]);
}






