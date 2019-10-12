/// @description Insert description here
// You can write your code in this editor





//create surface
shop_surface = surface_create(220,270);

selected_top_tab = 0;
text_in_tab_array[0] = "KNIVES";
text_in_tab_array[1] = "TARGETS";
text_in_tab_array[2] = "WALLS";


//an array, with each slot holding the id of lists that contain all our items for each tab
grid_id_in_this_tab_array[0] = global.knife_grid;
grid_id_in_this_tab_array[1] = global.target_grid;
grid_id_in_this_tab_array[2] = global.wall_grid;


current_item_number_in_this_tab_array[0] = global.current_knife_number;
current_item_number_in_this_tab_array[1] = global.current_target_number;
current_item_number_in_this_tab_array[2] = global.current_wall_number;

current_sprite_in_this_tab_array[0] = spr_ui_all_knives;
current_sprite_in_this_tab_array[1] = spr_ui_all_targets;
current_sprite_in_this_tab_array[2] = spr_ui_all_walls;

//for scrolling in item slot
item_slot_scrolled_amount = 0;
old_mouse_y = 0;



//exit button
exit_shop_button_clicked = false;

//slots array to determine if we properly clicked these or not
item_slot_array[0] = false;


//tab array to determine if we properly clicked these or not
tab_hovered_array[0] = false;







