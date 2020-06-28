
//=== Determine Width and Height ==//
var _spr = map_a,
	_ww = sprite_get_width(_spr),
	_hh = sprite_get_height(_spr);

//=== Create Surface ===//
var _surf = surface_create(_ww, _hh);
surface_set_target(_surf);
draw_clear_alpha(0, 0);
draw_sprite(_spr, -1, 0, 0);
surface_reset_target();

//=== Surface to Buffer ===//
_buff = buffer_create(4 * _ww * _hh, buffer_fixed, 1);
buffer_get_surface(_buff, _surf, 0, 0, 0);
surface_free(_surf);// we don't need the surface anymore

var my_grid = ds_grid_create(2000,2000)
local_y = 0
local_x = 0



//this is our navmesh so to speak, it will render using a graded white to black tilemap and those
//color values are then used to aid physical interaction with the world and AI pathfinding. 
global.zground = layer_create(6, "zground");
global.zground_tiles = layer_tilemap_create(global.zground,0,0,tset_forest_world,room_width,room_height);

//these are our rendering and potential collision layers, shaders are necessary here to give the impression of height
global.z5 = layer_create(5, "z5");
//layer_shader(global.z5, shader0)
global.z5_tiles = layer_tilemap_create(global.z5,0,0,tset_forest_world,room_width,room_height);

global.z4 = layer_create(4, "z4");
//layer_shader(global.z4, shader0)
global.z4_tiles = layer_tilemap_create(global.z4,0,0,tset_forest_world,room_width,room_height);

global.z3 = layer_create(3, "z3");
//layer_shader(global.z3, shader0)
global.z3_tiles = layer_tilemap_create(global.z3,0,0,tset_forest_world,room_width,room_height);

global.z2 = layer_create(2, "z2");
//layer_shader(global.z2, shader0)
global.z2_tiles = layer_tilemap_create(global.z2,0,0,tset_forest_world,room_width,room_height);

global.z1 = layer_create(1, "z1");
//layer_shader(global.z1, shader0)
global.z1_tiles = layer_tilemap_create(global.z1,0,0,tset_forest_world,room_width,room_height);






for (i = 0; i < (_ww * _hh); i += 1) {
	//tile = layer_tile_create(global.ground_layer, local_x, local_y, tset_forest_world, left, top, width, height);
		
	if (local_x > (_ww - 1)) {
		local_x = 0
		local_y += 1
	} else {
		
		//=== Extracting Color Info ===//
		// this is an example for a single pixel, you can of course loop all pixels, or access only specific ones!
		// Pixel coordinates [x,y] start at [0,0] and should not exceed [_ww-1,_hh-1]
		var _x = local_x,
			_y = local_y,
			pixel = buffer_peek(_buff, 4 * (_x + _y * _ww), buffer_u32),	// extracts info in ABGR Format
			a = (pixel >> 24) & $ff,	// Alpha [0-255]	
			r = pixel & $ff,			// Red [0-255]	
			g = (pixel >> 8) & $ff,		// Green [0-255]	
			b = (pixel >> 16) & $ff;	// Blue [0-255]	
		
			color = r + g + b
		
		//ds_grid_set(my_grid, local_x, local_y, color)
		
		if (color == 621) {
			tilemap_set_at_pixel(global.z5_tiles, 10, local_x, local_y)
			tilemap_set_at_pixel(global.zground_tiles, 10, local_x, local_y)
		} else if (color == 592) {
			tilemap_set_at_pixel(global.z4_tiles, 7, local_x, local_y)
			tilemap_set_at_pixel(global.zground_tiles, 7, local_x, local_y)
		} else if (color == 693) {
			tilemap_set_at_pixel(global.z3_tiles, 6, local_x, local_y)
			tilemap_set_at_pixel(global.zground_tiles, 6, local_x, local_y)
		} else if (color == 568) {
			tilemap_set_at_pixel(global.z2_tiles, 5, local_x, local_y)
			tilemap_set_at_pixel(global.zground_tiles, 5, local_x, local_y)
		} else if (color == 468) {
			tilemap_set_at_pixel(global.z1_tiles, 4, local_x, local_y)
			tilemap_set_at_pixel(global.zground_tiles, 4, local_x, local_y)
		}
		
		local_x += 1
	}
}

show_debug_message("finished!")

instance_create_depth(1000,1000,0,player)
instance_create_depth(1000,1000,0,player_camera)

// === Cleanup ===//
buffer_delete(_buff);