/// @description Insert description here
// You can write your code in this editor



//top ribbon
var ribbon_width = sprite_get_width(spr_ui_shop_top_ribbon);
var ribbon_height = sprite_get_height(spr_ui_shop_top_ribbon);
var ribbon_starting_x = (view_w - ribbon_width)/2;
draw_sprite(spr_ui_shop_top_ribbon,0,ribbon_starting_x,0);




#region top left currency 
	//backing
	var side_padding_from_initial_ribbon = 8;
	var currency_backing_starting_x = ribbon_starting_x + side_padding_from_initial_ribbon;
	var currency_backing_starting_y = 8;
	var currency_backing_width = sprite_get_width(spr_ui_shop_currency_backing);
	draw_sprite(spr_ui_shop_currency_backing,0,currency_backing_starting_x,currency_backing_starting_y);

	//coin
	var coin_width = sprite_get_width(spr_ui_currency);
	var currency_coin_starting_x = round(currency_backing_starting_x + (coin_width/2) + 5);
	var currency_coin_starting_y = round(currency_backing_starting_y + (sprite_get_height(spr_ui_shop_currency_backing)/2));
	draw_sprite(spr_ui_currency_object,0,currency_coin_starting_x,currency_coin_starting_y);

	//how many coins we have
	var currency_text_starting_x = currency_coin_starting_x + (coin_width/2) + 5;
	var currency_text_starting_y = currency_coin_starting_y;
	draw_set_valign(fa_middle);
	draw_set_halign(fa_left);
	draw_text(currency_text_starting_x,currency_text_starting_y,string(global.currency));
	
	//add additional currency button
	var currency_add_button_starting_x = currency_backing_starting_x + currency_backing_width + (sprite_get_width(spr_ui_shop_add_currency_button)/2) + 4;
	var currency_add_button_starting_y = currency_coin_starting_y;
	draw_sprite(spr_ui_shop_add_currency_button,0,currency_add_button_starting_x,currency_add_button_starting_y);
	
#endregion


//exit shop button
var exit_shop_button_starting_x = view_w - (ribbon_starting_x + side_padding_from_initial_ribbon + (sprite_get_width(spr_ui_shop_exit_button)/2) + 7);
var exit_shop_button_starting_y = currency_add_button_starting_y;
draw_sprite(spr_ui_shop_exit_button,0,exit_shop_button_starting_x,exit_shop_button_starting_y);



#region tabs
	
	var tab_starting_location_x = currency_coin_starting_x + (coin_width/2);
	var tab_starting_location_y = view_h * 0.14;	
	var tab_width = sprite_get_width(spr_ui_shop_top_tabs);
	var tab_height = sprite_get_height(spr_ui_shop_top_tabs);
	var tab_spacer_x = 5;
	var top_sub_image = 0;
	var amount_to_middle_tab = tab_height;
	var my_text_color = c_white;
	var num_of_tabs = 3;
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	draw_set_font(font_monofonto_small);


	for(var i = 0; i < num_of_tabs; i += 1;)
	{
		if i == selected_top_tab
		{
			top_sub_image = 1;
			amount_to_middle_tab = (tab_height/2);
		}
		else
		{
			top_sub_image = 0;
			amount_to_middle_tab = (tab_height/2) + 2;
		}
		
		//backing of tab
		draw_sprite(spr_ui_shop_top_tabs,top_sub_image,tab_starting_location_x + ((tab_width + tab_spacer_x) * i),tab_starting_location_y);
	
		//text in tab				
		draw_text_color(tab_starting_location_x + ((tab_width + tab_spacer_x) * i) + (tab_width/2),tab_starting_location_y + amount_to_middle_tab,string(text_in_tab_array[i]),my_text_color,my_text_color,my_text_color,my_text_color,1)
	
	}
	
	

#endregion


//draw bars
var top_line_location_x = tab_starting_location_x;
var top_line_location_y = tab_starting_location_y + tab_height - 4;
//top
draw_sprite(spr_ui_shop_top_line,0,top_line_location_x,top_line_location_y);

//bot
draw_sprite(spr_ui_shop_top_line,0,top_line_location_x,top_line_location_y + surface_get_height(shop_surface));




#region surface (all the items in our shop)

	surface_set_target(shop_surface);
	draw_clear_alpha(c_black, 0);
	//draw the stuff
	var item_list_id = grid_of_items_in_this_tab_array[selected_top_tab];
	var num_of_items_in_this_tab = ds_grid_height(item_list_id);
	var item_slot_width = sprite_get_width(spr_ui_shop_item_slot);
	var item_slot_height = sprite_get_height(spr_ui_shop_item_slot);
	var item_slot_spacer_w = 9;
	var item_slot_spacer_h = 13;
	var slots_per_row = 3;
	var this_item_slot_x = 0;
	var this_item_slot_y = 0;
	var this_item_sprite;
	var this_item_scale;
	for(var i = 0; i < num_of_items_in_this_tab; i += 1;)
	{
		//backing
		this_item_slot_x = (item_slot_width /2) + ((item_slot_width + item_slot_spacer_w) * (i mod slots_per_row));
		this_item_slot_y = ((item_slot_height/2) + item_slot_spacer_h) + ((item_slot_height + item_slot_spacer_h) * (i div slots_per_row)) + item_slot_scrolled_amount;
		
		draw_sprite(spr_ui_shop_item_slot,0,this_item_slot_x,this_item_slot_y);

		//item sprite
		this_item_sprite = ds_grid_get(global.knife_grid,0,i);
		this_item_scale = 0.75;
		draw_sprite_ext(this_item_sprite,0,this_item_slot_x + (sprite_get_xoffset(this_item_sprite) * this_item_scale) - ((sprite_get_width(this_item_sprite) * this_item_scale)/2),this_item_slot_y + (sprite_get_yoffset(this_item_sprite) * this_item_scale) - ((sprite_get_height(this_item_sprite) * this_item_scale)/2),this_item_scale,this_item_scale,0,c_white,1);
	}
	
	
	//reset the surface
	
	surface_reset_target();
	
	//now that we have the location of the surface ...check to see if we are scrolling* in it
	var item_slot_starting_loc_x = top_line_location_x;
	var item_slot_starting_loc_y = top_line_location_y + sprite_get_height(spr_ui_shop_top_line);
	
	var my_mouse_x = device_mouse_x(0);
	var my_mouse_y = device_mouse_y(0);
	
	if device_mouse_check_button(0,mb_left)
	{
		item_slot_scrolled_amount -= (old_mouse_y - my_mouse_y);
	}
	
	item_slot_scrolled_amount = clamp(item_slot_scrolled_amount,-(((((item_slot_height/1.5) + item_slot_spacer_h) * 2) + ((item_slot_height/2) + item_slot_spacer_h) + (item_slot_height + item_slot_spacer_h) * (num_of_items_in_this_tab div slots_per_row))) + (surface_get_height(shop_surface)),(item_slot_height/1.5) + item_slot_spacer_h);
	
	
	old_mouse_y = my_mouse_y;

	draw_surface(shop_surface,item_slot_starting_loc_x,item_slot_starting_loc_y);
	
#endregion




