/// @description Insert description here
// You can write your code in this editor
var collided_knife = instance_place(x,y,obj_knife);

if collided_knife != noone and global.current_run_active == true
{	
	global.currency += 1;
	instance_destroy();
}	
	
	
	
	