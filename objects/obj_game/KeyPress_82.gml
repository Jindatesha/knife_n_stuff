/// @description Insert description here
// You can write your code in this editor


//global.target_bits_part_emitter

part_type_destroy(global.target_bits_part_type);
part_emitter_destroy_all(global.target_bits_particle_system);
part_system_destroy(global.target_bits_particle_system);

draw_knife = true;

game_restart();