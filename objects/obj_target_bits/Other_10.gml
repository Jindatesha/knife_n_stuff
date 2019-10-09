/// @description slap down some target bitssss


what_particle_sprite = ds_grid_get(global.target_grid,6,global.current_taget_number);
part_type_sprite(global.target_bits_part_type,what_particle_sprite,false,false,true);

var how_many_particles = 3;
part_emitter_burst(global.target_bits_particle_system,global.target_bits_part_emitter,global.target_bits_part_type,how_many_particles);
