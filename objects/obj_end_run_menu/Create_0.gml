/// @description Insert description here
// You can write your code in this editor


//go to item shop
instance_create_depth(view_w/2,view_h * 0.57,depth,obj_button_shop);


//restart/ start a new run
with(instance_create_depth(view_w/2,view_h * 0.76,depth,obj_button_restart))
{
	my_text = "RESTART";
}


home_button_width = sprite_get_width(spr_ui_button_home);
home_ui_starting_x = (view_w * 0.06) + (home_button_width/2);
home_ui_starting_y = (view_h * 0.008) + (sprite_get_height(spr_ui_button_home)/2);
home_button_clicked = false;



currency_ui_starting_x = view_w * 0.94;
currency_ui_starting_y = view_h * 0.008;

my_color = c_ui_yellow;







