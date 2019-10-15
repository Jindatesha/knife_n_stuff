/// @description Insert description here
// You can write your code in this editor
if spr_create
    {
	    spr_create = false;
	    var surf, spr,image_to_copy_from,image_to_paste_to;
		image_to_copy_from = initial_targets_image;
		image_to_paste_to = spr_texture_break_target;
	    surf = surface_create(sprite_get_width(image_to_paste_to), sprite_get_height(image_to_paste_to));
	    surface_set_target(surf);
	    draw_clear_alpha(c_black, 0);
	    draw_sprite(image_to_copy_from,0,sprite_get_xoffset(image_to_copy_from), sprite_get_yoffset(image_to_copy_from));
	    sprite_index = sprite_create_from_surface(surf, 0, 0, sprite_get_width(image_to_paste_to), sprite_get_height(image_to_paste_to), false, false, sprite_get_xoffset(image_to_copy_from), sprite_get_yoffset(image_to_copy_from));	   
		draw_clear_alpha(c_black, 0);
	    draw_sprite(image_to_paste_to, my_sub_image, sprite_get_xoffset(image_to_paste_to), sprite_get_yoffset(image_to_paste_to));
	    spr = sprite_create_from_surface(surf, 0, 0, sprite_width, sprite_height, false, false, sprite_get_xoffset(image_to_paste_to), sprite_get_yoffset(image_to_paste_to));
	    surface_reset_target();
	    surface_free(surf);
	    sprite_set_alpha_from_sprite(sprite_index, spr);
	    sprite_delete(spr);
    }
	
	


my_alpha -= 1/time_for_target_split;
my_rotation += my_rotation_speed * my_rotation_dir;

if my_alpha <= 0
{
	sprite_delete(sprite_index);
	instance_destroy();
}
else
{
	draw_sprite_ext(sprite_index, 0, x, y,1,1,my_rotation,c_white,my_alpha);
}