/// @description Execute Code

// get the fake depth of the tile we're currently on
self.current_tile = tile_get_index(tilemap_get_at_pixel(global.zground_tiles, self.x, self.y));

if (self.current_tile != self.previous_tile) {
	self.layer_transition_slowdown = 1;
	self.previous_tile = self.current_tile;
	show_debug_message(self.current_tile);
	show_debug_message(self.previous_tile);
	
	
	if (self.current_tile == 10) {
		layer_shader(global.z5, shader0)
		layer_shader(global.z4, z_above_shader)
		layer_shader(global.z3, z_above_shader)
		layer_shader(global.z2, z_above_shader)
		layer_shader(global.z1, z_above_shader)	
		
	} else if (self.current_tile == 7) {
		layer_shader(global.z5, z_below_shader)
		layer_shader(global.z4, shader0)
		layer_shader(global.z3, z_above_shader)
		layer_shader(global.z2, z_above_shader)
		layer_shader(global.z1, z_above_shader)	
		
	} else if (self.current_tile == 6) {
		layer_shader(global.z5, z_below_shader)
		layer_shader(global.z4, z_below_shader)
		layer_shader(global.z3, shader0)
		layer_shader(global.z2, z_above_shader)
		layer_shader(global.z1, z_above_shader)	
	
	} else if (self.current_tile == 5) {
		layer_shader(global.z5, z_below_shader)
		layer_shader(global.z4, z_below_shader)
		layer_shader(global.z3, z_below_shader)
		layer_shader(global.z2, shader0)
		layer_shader(global.z1, z_above_shader)	
	
	} else if (self.current_tile == 4) {
		layer_shader(global.z5, z_below_shader)
		layer_shader(global.z4, z_below_shader)
		layer_shader(global.z3, z_below_shader)
		layer_shader(global.z2, z_below_shader)
		layer_shader(global.z1, shader0)	
	}
	
	
	
	
	
	
}

self.previous_tile = self.current_tile;

if (self.layer_transition_slowdown > 0) {
	if (layer_transition_slowdown > 0.9) {
		self.phy_linear_velocity_x = 0
		self.phy_linear_velocity_y = 0
	}
	self.layer_transition_slowdown -= 0.05;
	show_debug_message(layer_transition_slowdown);
	self.phy_linear_damping += (self.layer_transition_slowdown * 2);
} else {
	self.phy_linear_damping = self.ref_linear_damping;
} 


//show_debug_message(current_tile)


// experimental localised mvement code, a bit too odd feeling and un-intuitive
// variables named after the flight component
// physics_apply_local_force(0.5, 0.5, self.desired_x_thrust, 0);
// physics_apply_local_force(0.5, 0.5, 0, self.desired_strafe_thrust);

physics_apply_torque(self.desired_torque_thrust);

physics_apply_force(x, y, self.desired_x_thrust, 0);
physics_apply_force(x, y, 0, self.desired_strafe_thrust);

var direction_diff = angle_difference(self.phy_rotation * -1, self.desired_point_angle);

if (direction_diff < 0) {
	self.desired_torque_thrust = -self.max_torque_thrust * ((direction_diff * -1)/180);
	self.phy_angular_damping = 3 / ((direction_diff * -1)/180);
	
} else if (direction_diff > 0) {
	self.desired_torque_thrust = self.max_torque_thrust * (direction_diff/180);
	self.phy_angular_damping = 3 / (direction_diff/180);
}