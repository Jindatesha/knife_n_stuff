/// @description Insert description here
// You can write your code in this editor




//draw the knife
draw_sprite(spr_knife_default,0,knife_starting_loc_x,knife_starting_loc_y);


var still_have_this_knife = 0;
//draw the ui for how many knives you need to throw
for(var i = 0; i < starting_knives_amount; i += 1;)
{
	
	if global.knives_left > i
	{
		still_have_this_knife = 1;
	}
	else
	{
		still_have_this_knife = 0;
	}
	
	
	//draw the actual sprite
	draw_sprite(spr_ui_knives_left,still_have_this_knife,knives_left_ui_loc_x,knives_left_ui_loc_y - (knives_left_ui_gap * i));
}




