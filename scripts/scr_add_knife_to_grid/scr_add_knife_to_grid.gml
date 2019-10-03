/// scr_add_knife_to_grid();
/// @param knife_sprite



var target_sprite = argument[0];



//get and resize the grid to fit our new target in
var width_of_grid = ds_grid_width(global.knife_grid);
var height_of_grid = ds_grid_height(global.knife_grid);
ds_grid_resize(global.knife_grid,width_of_grid,height_of_grid + 1);


//add all the values to our new grid slot
for(var i = 0; i < width_of_grid; i += 1;)
{
	ds_grid_add(global.knife_grid,i,height_of_grid,argument[i]);
}






