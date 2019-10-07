/// @description Insert description here
// You can write your code in this editor





//create surface
shop_surface = surface_create(220,270);

selected_top_tab = 0;
text_in_tab_array[0] = "KNIVES";
text_in_tab_array[1] = "TARGETS";
text_in_tab_array[2] = "WALLS";


//an array, with each slot holding the id of lists that contain all our items for each tab
grid_of_items_in_this_tab_array[0] = global.knife_grid;
grid_of_items_in_this_tab_array[1] = global.target_grid;
grid_of_items_in_this_tab_array[2] = global.wall_grid;


//for scrolling in item slot
item_slot_scrolled_amount = 0;
old_mouse_y = 0;
