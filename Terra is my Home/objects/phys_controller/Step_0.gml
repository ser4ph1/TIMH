/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 100E8344
/// @DnDArgument : "code" "/// @description Execute Code$(13_10)$(13_10)$(13_10)$(13_10)// get the fake depth of the tile we're currently on$(13_10)$(13_10)$(13_10)$(13_10)current_tile = tile_get_index(tilemap_get_at_pixel(global.zground_tiles, self.x, self.y));$(13_10)$(13_10)$(13_10)if (current_tile != previous_tile) {$(13_10)	self.layer_transition_slowdown = 1$(13_10)	previous_tile = current_tile$(13_10)	show_debug_message(current_tile)$(13_10)	show_debug_message(previous_tile)$(13_10)}$(13_10)$(13_10)previous_tile = current_tile$(13_10)$(13_10)if (self.layer_transition_slowdown > 0) {$(13_10)	self.layer_transition_slowdown -= 0.05$(13_10)	show_debug_message(layer_transition_slowdown)$(13_10)	self.phy_linear_damping += (self.layer_transition_slowdown * 2)$(13_10)} else {$(13_10)	self.phy_linear_damping = self.phy_linear_damping_reference$(13_10)}$(13_10)$(13_10)$(13_10)//show_debug_message(current_tile)$(13_10)$(13_10)$(13_10)// experimental localised mvement code, a bit too odd feeling and un-intuitive$(13_10)// variables named after the flight component$(13_10)// physics_apply_local_force(0.5, 0.5, self.desired_x_thrust, 0);$(13_10)// physics_apply_local_force(0.5, 0.5, 0, self.desired_strafe_thrust);$(13_10)physics_apply_torque(self.desired_torque_thrust);$(13_10)$(13_10)physics_apply_force(x, y, self.desired_x_thrust, 0);$(13_10)physics_apply_force(x, y, 0, self.desired_strafe_thrust);$(13_10)$(13_10)var direction_diff = angle_difference(self.phy_rotation * -1, self.desired_point_angle)$(13_10)$(13_10)if (direction_diff < 0) {$(13_10)	self.desired_torque_thrust = -self.max_torque_thrust * ((direction_diff * -1)/180)$(13_10)	self.phy_angular_damping = 3 / ((direction_diff * -1)/180)$(13_10)	$(13_10)} else if (direction_diff > 0) {$(13_10)	self.desired_torque_thrust = self.max_torque_thrust * (direction_diff/180)$(13_10)	self.phy_angular_damping = 3 / (direction_diff/180)$(13_10)}$(13_10)$(13_10)$(13_10)$(13_10)$(13_10)$(13_10)"
/// @description Execute Code



// get the fake depth of the tile we're currently on



current_tile = tile_get_index(tilemap_get_at_pixel(global.zground_tiles, self.x, self.y));


if (current_tile != previous_tile) {
	self.layer_transition_slowdown = 1
	previous_tile = current_tile
	show_debug_message(current_tile)
	show_debug_message(previous_tile)
}

previous_tile = current_tile

if (self.layer_transition_slowdown > 0) {
	self.layer_transition_slowdown -= 0.05
	show_debug_message(layer_transition_slowdown)
	self.phy_linear_damping += (self.layer_transition_slowdown * 2)
} else {
	self.phy_linear_damping = self.phy_linear_damping_reference
}


//show_debug_message(current_tile)


// experimental localised mvement code, a bit too odd feeling and un-intuitive
// variables named after the flight component
// physics_apply_local_force(0.5, 0.5, self.desired_x_thrust, 0);
// physics_apply_local_force(0.5, 0.5, 0, self.desired_strafe_thrust);
physics_apply_torque(self.desired_torque_thrust);

physics_apply_force(x, y, self.desired_x_thrust, 0);
physics_apply_force(x, y, 0, self.desired_strafe_thrust);

var direction_diff = angle_difference(self.phy_rotation * -1, self.desired_point_angle)

if (direction_diff < 0) {
	self.desired_torque_thrust = -self.max_torque_thrust * ((direction_diff * -1)/180)
	self.phy_angular_damping = 3 / ((direction_diff * -1)/180)
	
} else if (direction_diff > 0) {
	self.desired_torque_thrust = self.max_torque_thrust * (direction_diff/180)
	self.phy_angular_damping = 3 / (direction_diff/180)
}