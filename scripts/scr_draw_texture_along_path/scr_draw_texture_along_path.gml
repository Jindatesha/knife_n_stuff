//Draw texture on path



draw_path(path_ribbon,x,y,true);



//initialize them all as local variables
var next_point_percentage,path_x,path_y,next_path_x,next_path_y,dir,texture_width,length_to_vertex,vertex_x,vertex_y,vertex_1_x,vertex_1_y,vertex_2_x,vertex_2_y,amount_of_cuts;

amount_of_cuts = 100;
next_point_percentage = 1/amount_of_cuts;
texture_width = 40;
length_to_vertex = texture_width/2;


draw_primitive_begin(pr_trianglestrip);


for (var i = 0; i <= 1; i += next_point_percentage)
{
	path_x = path_get_x(path_ribbon,i);
	path_y = path_get_y(path_ribbon,i);

	next_path_x = path_get_x(path_ribbon,i + (next_point_percentage/4));
	next_path_y = path_get_y(path_ribbon,i + (next_point_percentage/4));


	

	dir = point_direction(path_x,path_y,next_path_x,next_path_y) + 90;

	

	vertex_x = lengthdir_x(length_to_vertex,dir);
	vertex_y = lengthdir_y(length_to_vertex,dir);


	
	vertex_1_x = path_x + vertex_x;
	vertex_1_y = path_y + vertex_y;
	
	vertex_2_x = path_x - vertex_x;
	vertex_2_y = path_y - vertex_y;
	
	
	
	#region do a reversed one for the last segment
		if i == 1
		{
			path_x = path_get_x(path_ribbon,i);
			path_y = path_get_y(path_ribbon,i);

			next_path_x = path_get_x(path_ribbon,i - (next_point_percentage/4));
			next_path_y = path_get_y(path_ribbon,i - (next_point_percentage/4));


	

			dir = point_direction(path_x,path_y,next_path_x,next_path_y) - 90;

	

			vertex_x = lengthdir_x(length_to_vertex,dir);
			vertex_y = lengthdir_y(length_to_vertex,dir);


	
			vertex_1_x = path_x + vertex_x;
			vertex_1_y = path_y + vertex_y;
	
			vertex_2_x = path_x - vertex_x;
			vertex_2_y = path_y - vertex_y;
		}
	#endregion
	
	draw_vertex(vertex_1_x,vertex_1_y);
	draw_vertex(vertex_2_x,vertex_2_y);
	
	/*
	draw_circle(vertex_1_x,vertex_1_y,5,false);
	draw_circle(vertex_2_x,vertex_2_y,5,false);
	draw_line(vertex_1_x,vertex_1_y,vertex_2_x,vertex_2_y);
	*/
}




draw_primitive_end();