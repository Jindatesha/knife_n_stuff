/// @description Insert description here
// You can write your code in this editor
//particle setup
global.target_bits_particle_system = part_system_create();

global.target_bits_part_type = part_type_create();
part_system_depth(global.target_bits_particle_system,depth);
part_type_life(global.target_bits_part_type,room_speed * 0.7,room_speed * 0.7);
part_type_alpha2(global.target_bits_part_type,1,0);
part_type_direction(global.target_bits_part_type,240,360,0,0);
part_type_gravity(global.target_bits_part_type,0.15,270);
part_type_speed(global.target_bits_part_type,0.3,0.8,0.1,0);
part_type_orientation(global.target_bits_part_type,0,360,9,10,true);
what_particle_sprite = ds_grid_get(global.target_grid,2,global.which_target_number);
part_type_sprite(global.target_bits_part_type,what_particle_sprite,false,false,true);

var bottom_of_target_x = x;
var bottom_of_target_y = y + (sprite_get_height(spr_target)/2) - 10;
global.target_bits_part_emitter = part_emitter_create(global.target_bits_particle_system);
part_emitter_region(global.target_bits_particle_system,global.target_bits_part_type,bottom_of_target_x - 15,bottom_of_target_x + 15,bottom_of_target_y,bottom_of_target_y,ps_shape_line,ps_distr_linear);

