/// @description Insert description here
// You can write your code in this editor

//macros
#macro view view_camera[0]
#macro view_w camera_get_view_width(view)
#macro view_h camera_get_view_height(view)


//camera settings
ideal_width = 320;
ideal_height = 480;
camera_set_view_size(view,ideal_width,ideal_height);


//knife stuff
starting_knives_amount = 10;
global.knives_left = starting_knives_amount;
knife_starting_loc_x = view_w / 2;
knife_starting_loc_y = view_h * 0.7;

//knife ui stuff
knives_left_ui_loc_x =  view_w * 0.08;
knives_left_ui_loc_y =  view_h * 0.74;
knives_left_ui_gap = sprite_get_height(spr_ui_knives_left) - 5;




