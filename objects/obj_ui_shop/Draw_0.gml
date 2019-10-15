/// @description Insert description here
// You can write your code in this editor

//mouse x/y
var my_mouse_x = device_mouse_x(0);
var my_mouse_y = device_mouse_y(0);





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
var exit_shop_button_width = sprite_get_width(spr_ui_shop_exit_button);
var exit_shop_button_starting_x = view_w - (ribbon_starting_x + side_padding_from_initial_ribbon + (exit_shop_button_width/2) + 7);
var exit_shop_button_starting_y = currency_add_button_starting_y;
draw_sprite(spr_ui_shop_exit_button,0,exit_shop_button_starting_x,exit_shop_button_starting_y);

//if i click it...leave this menu
var mouse_in_circle = point_in_circle(my_mouse_x,my_mouse_y,exit_shop_button_starting_x,exit_shop_button_starting_y,exit_shop_button_width);
if mouse_in_circle != true
{
	exit_shop_button_clicked = false;
}


if device_mouse_check_button_pressed(0,mb_left) and mouse_in_circle
{
	exit_shop_button_clicked = true;
}



if device_mouse_check_button_released(0,mb_left) and mouse_in_circle and (exit_shop_button_clicked == true)
{
	//exit the menu
	restart_to_new_session();
}


#region tabs
	
	var tab_starting_location_x = currency_coin_starting_x + (coin_width/2);
	var tab_starting_location_y = view_h * 0.14;	
	var tab_width = sprite_get_width(spr_ui_shop_top_tabs);
	var tab_height = sprite_get_height(spr_ui_shop_top_tabs);
	var tab_spacer_x = 5;
	var top_sub_image = 0;
	var amount_to_middle_tab = tab_height;
	var my_text_color = c_white;
	var num_of_tabs = 2;
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	draw_set_font(font_monofonto_small);
	var mouse_in_tab,this_tabs_location_x;

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
		
		this_tabs_location_x = tab_starting_location_x + ((tab_width + tab_spacer_x) * i);
		
		
		mouse_in_tab = point_in_rectangle(my_mouse_x,my_mouse_y, this_tabs_location_x, tab_starting_location_y,this_tabs_location_x + tab_width, tab_starting_location_y + tab_height);
		
		if mouse_in_tab != true
		{
			tab_hovered_array[i] = false;
		}


		if device_mouse_check_button_pressed(0,mb_left) and mouse_in_tab
		{
			tab_hovered_array[i] = true;
		}



		if device_mouse_check_button_released(0,mb_left) and mouse_in_tab and (tab_hovered_array[i] == true)
		{
			selected_top_tab = i;
		}
		
		
		//backing of tab
		draw_sprite(spr_ui_shop_top_tabs,top_sub_image,this_tabs_location_x,tab_starting_location_y);
	
		//text in tab				
		draw_text_color(this_tabs_location_x + (tab_width/2),tab_starting_location_y + amount_to_middle_tab,string(text_in_tab_array[i]),my_text_color,my_text_color,my_text_color,my_text_color,1)
	
	}
	
	

#endregion


//draw bars
var top_line_location_x = tab_starting_location_x;
var top_line_location_y = tab_starting_location_y + tab_height - 4;
//top
draw_sprite(spr_ui_shop_top_line,0,top_line_location_x,top_line_location_y);

//bot
var bot_line_location_y = top_line_location_y + surface_get_height(shop_surface);
draw_sprite(spr_ui_shop_top_line,0,top_line_location_x,bot_line_location_y);




#region surface (all the items in our shop)

	surface_set_target(shop_surface);
	draw_clear_alpha(c_black, 0);
	//draw the stuff
	var item_grid_id = grid_id_in_this_tab_array[selected_top_tab];
	var num_of_items_in_this_tab = ds_grid_height(item_grid_id);
	var item_slot_width = sprite_get_width(spr_ui_shop_item_slot);
	var item_slot_height = sprite_get_height(spr_ui_shop_item_slot);
	var item_slot_spacer_w = 9;
	var item_slot_spacer_h = 13;
	var slots_per_row = 3;
	var this_item_slot_x = 0;
	var this_item_slot_y = 0;
	var this_item_sprite;
	var this_item_scale;
	var ui_line_height = sprite_get_height(spr_ui_shop_top_line);
	var item_slot_starting_loc_x = top_line_location_x;
	var item_slot_starting_loc_y = top_line_location_y + ui_line_height;
	var mouse_in_rectangle;
	var unlocked;
	var item_cost_color = c_white;
	var this_slot_selected = 0;
	var this_items_cost;
	var rarity_gap = 170;
	var knives_rarity_gap = 0;
	var knives_in_section = 0;
	
	
	for(var i = 0; i < num_of_items_in_this_tab; i += 1;)
	{
		
		//dealing with knives
		if selected_top_tab == 0
		{
			if i >= KNIFE_COMMON.DEFAULT and i < KNIFE_COMMON.LAST_IN_LIST
			{
				knives_rarity_gap = rarity_gap * 0;
				knives_in_section = 0;
			}
			else
			{
				if i >= KNIFE_EPIC.DEFAULT and i < KNIFE_EPIC.LAST_IN_LIST
				{
					knives_rarity_gap = rarity_gap * 1;
					knives_in_section = KNIFE_COMMON.LAST_IN_LIST;
				}
				else
				{
					knives_rarity_gap = rarity_gap * 2;
					knives_in_section = KNIFE_EPIC.LAST_IN_LIST;
				}
			
			}
		}
		
		
		
		
		//backing
		this_item_slot_x = (item_slot_width /2) + ((item_slot_width + item_slot_spacer_w) * ((i - knives_in_section) mod slots_per_row));
		this_item_slot_y = ((item_slot_height/2) + item_slot_spacer_h) + ((item_slot_height + item_slot_spacer_h) * ((i - knives_in_section) div slots_per_row)) + item_slot_scrolled_amount + knives_rarity_gap;


		var knife_separator_gap = 5;
		var knife_separator_text = "";
		var surface_width = surface_get_width(shop_surface);
		var knife_sep_loc_y = this_item_slot_y - (rarity_gap/2);
		
		if (selected_top_tab == 0)
		{		
			if i == KNIFE_EPIC.DEFAULT or i == KNIFE_CHAMPION.DEFAULT
			{
				if i == KNIFE_EPIC.DEFAULT
				{
					knife_separator_text = "EPIC";
				}
				else
				{
					knife_separator_text = "CHAMPION";
				}
				var width_of_knife_separator_text = string_width(knife_separator_text);
				var difference_from_total_width = surface_width - width_of_knife_separator_text;
				var line_ui_slice_width = ((difference_from_total_width)/2) - knife_separator_gap;
				
				
				//left line
				scr_draw_3_slice_stretched(spr_ui_shop_bar_3_slice,line_ui_slice_width,0,knife_sep_loc_y);
			
			
				//knife separator text
				draw_set_halign(fa_center);
				draw_set_valign(fa_middle);
				draw_text(line_ui_slice_width + (width_of_knife_separator_text/2) + knife_separator_gap,knife_sep_loc_y,string(knife_separator_text));
			
			
				//right line
				scr_draw_3_slice_stretched(spr_ui_shop_bar_3_slice,line_ui_slice_width,line_ui_slice_width + (width_of_knife_separator_text) + (knife_separator_gap * 2),knife_sep_loc_y);

			}
		}
		
		
		

		
		unlocked = ds_grid_get(item_grid_id,2,i);
		this_items_cost = ds_grid_get(item_grid_id,3,i);
		
		#region if clicked...
			mouse_in_rectangle = point_in_rectangle(my_mouse_x,my_mouse_y, item_slot_starting_loc_x + this_item_slot_x - (item_slot_width/2), item_slot_starting_loc_y + this_item_slot_y - (item_slot_height/2),item_slot_starting_loc_x + this_item_slot_x + (item_slot_width/2), item_slot_starting_loc_y + this_item_slot_y + (item_slot_height/2));
		
			if mouse_in_rectangle != true
			{
				item_slot_array[i] = false;
			}


			if device_mouse_check_button_pressed(0,mb_left) and mouse_in_rectangle
			{
				item_slot_array[i] = true;
			}



			if device_mouse_check_button_released(0,mb_left) and mouse_in_rectangle and (item_slot_array[i] == true)
			{
				//first off check to see if its unlocked
				if unlocked == false
				{
					//see if u can buy it
					if global.currency >= this_items_cost
					{
						//unlock it
						ds_grid_set(item_grid_id,2,i,true);
						unlocked = true;
						
						//pay for it
						global.currency -= this_items_cost;
					}
				}
				
				
				if unlocked == true
				{
					//equip this thing
					//which one was false?
					var false_grid_pos;
					for(var e = 0; e < num_of_items_in_this_tab; e += 1;)
					{
						if ds_grid_get(item_grid_id,4,e) == true
						{
							false_grid_pos = e;
							break;
						}
					}
			
					ds_grid_set(item_grid_id,4,false_grid_pos,false);
			
					//set equipped to true
					ds_grid_set(item_grid_id,4,i,true);	
			
					current_item_number_in_this_tab_array[selected_top_tab] = i;
					//current_sprite_in_this_tab_array[selected_top_tab] = ds_grid_get(item_grid_id,0,current_item_number_in_this_tab_array[selected_top_tab]);
			
					#region because we have just made a change in one of the global holders...change our globals to match
						global.knife_grid = grid_id_in_this_tab_array[0];
						global.wall_grid = grid_id_in_this_tab_array[1];

						global.current_knife_number = current_item_number_in_this_tab_array[0];
						global.current_wall_number = current_item_number_in_this_tab_array[1];

						global.knife_sprite = ds_grid_get(global.knife_grid,0,global.current_knife_number);
						global.wall_sprite = ds_grid_get(global.wall_grid,0,global.current_wall_number);
					#endregion
				}
			}
		#endregion
		
		
		//item sprite
		this_item_sprite = current_sprite_in_this_tab_array[selected_top_tab];
		
		draw_sprite(this_item_sprite,i,this_item_slot_x,this_item_slot_y);
	
	
		//draw the dark locked bit if you dont have this item unlocked
		
		if unlocked == false
		{
			draw_sprite(spr_ui_shop_dark_locked_bit,0,this_item_slot_x,this_item_slot_y);
		}
	
		
		#region item slot backing
			if current_item_number_in_this_tab_array[selected_top_tab] == i
			{
				this_slot_selected = 1;
			}
			else
			{
				this_slot_selected = 0;
			}
		
		
			draw_sprite(spr_ui_shop_item_slot,this_slot_selected,this_item_slot_x,this_item_slot_y);
		#endregion
		
		
		//draw ribbon and cost IF its locked
		if unlocked == false
		{
			draw_sprite(spr_ui_shop_ribbon_cost,0,this_item_slot_x - (item_slot_width /2) ,this_item_slot_y - (item_slot_height /2) );
			//draw_set_font(font_monofonto);
			draw_text_transformed_color(this_item_slot_x - (item_slot_width /2) + 26,this_item_slot_y - (item_slot_height /2) + 17,this_items_cost,1,1,39,item_cost_color,item_cost_color,item_cost_color,item_cost_color,1);
		}
		 
	}
	
	
	//reset the surface	
	surface_reset_target();
	
	//now that we have the location of the surface ...check to see if we are scrolling* in it
	

	
	if device_mouse_check_button(0,mb_left)
	{
		item_slot_scrolled_amount -= (old_mouse_y - my_mouse_y);
	}
	
	item_slot_scrolled_amount = clamp(item_slot_scrolled_amount,-(((((item_slot_height/1.5) + item_slot_spacer_h) * 2) + ((item_slot_height/2) + item_slot_spacer_h) + (item_slot_height + item_slot_spacer_h) * (num_of_items_in_this_tab div slots_per_row))) + (surface_get_height(shop_surface)) - ((rarity_gap * 1.4)),(item_slot_height/1.5) + item_slot_spacer_h);
	
	
	old_mouse_y = my_mouse_y;

	draw_surface(shop_surface,item_slot_starting_loc_x,item_slot_starting_loc_y);
	
#endregion
var item_number = current_item_number_in_this_tab_array[selected_top_tab];
//draw_set_font(font_monofonto);
draw_text(top_line_location_x + (sprite_get_width(spr_ui_shop_top_line)/2),bot_line_location_y + ui_line_height + 16,ds_grid_get(item_grid_id,1,current_item_number_in_this_tab_array[selected_top_tab]));

