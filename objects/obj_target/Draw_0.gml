/// @description Insert description here
// You can write your code in this editor



//draw_self();
if global.is_doing_boss_intro == true
{
	target_scale += 0.024;
	target_scale = clamp(target_scale,0,1);
}

if has_created_obj_destroyed_target == false
{
	draw_sprite_ext(sprite_index,0,x,y,target_scale,target_scale,image_angle,c_white,1);
}

#region white flash if needed
	if (flash_alpha > 0)
	{
		shader_set(shader_flash);
		
		draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,flash_color,flash_alpha);
		
		shader_reset();
	}
#endregion




