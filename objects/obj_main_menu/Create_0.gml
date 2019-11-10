/// @description Insert description here
// You can write your code in this editor


//clean up in case we are being created from pressing the home button
with(obj_end_run_menu)
{
	instance_destroy();
}

with(obj_button_shop)
{
	instance_destroy();
}

with(obj_button_restart)
{
	instance_destroy();
}




button_gap = 10;
button_space_between = (sprite_get_width(spr_button_restart)/2) + (button_gap/2);


with(obj_game)
{
	ui_alpha = 0;
	global.knives_left = 0;
}


//shop button
instance_create_depth(round((view_w/2) - button_space_between),round(view_h * 0.65),depth,obj_button_shop);


//play button
with(instance_create_depth(round((view_w/2) + button_space_between),round(view_h * 0.65),depth,obj_button_restart))
{
	my_text = "PLAY";
}




settings_button_width = sprite_get_width(spr_ui_button_settings);
settings_ui_starting_x = (view_w * 0.06) + (settings_button_width/2);
settings_ui_starting_y = (view_h * 0.008) + (sprite_get_height(spr_ui_button_settings)/2);
settings_button_clicked = false;


currency_ui_starting_x = view_w * 0.94;
currency_ui_starting_y = view_h * 0.008;
my_color = c_ui_yellow;
