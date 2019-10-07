/// scr_add_wall_to_grid();
/// @param wall_sprite



var target_sprite = argument[0];



//get and resize the grid to fit our new target in
var width_of_grid = ds_grid_width(global.wall_grid);
var height_of_grid = ds_grid_height(global.wall_grid);
ds_grid_resize(global.wall_grid,width_of_grid,height_of_grid + 1);


//add all the values to our new grid slot
for(var i = 0; i < width_of_grid; i += 1;)
{
	ds_grid_add(global.wall_grid,i,height_of_grid,argument[i]);
}






