/// @description Inherit Parent then continue
event_inherited();

//set physics globals from parent controller
//physics globals to be passed to our child upon creation
//NOTE im creating fixtures upon object creation and defining their collision based on their
//sprite sizes (default rectangle for simplicities sake).
self.fixture = physics_fixture_create();
physics_fixture_set_box_shape(self.fixture, self.sprite_width/2, self.sprite_height/2);

physics_fixture_set_collision_group(self.fixture, ds_map_find_value(phys_control_state, "collision_group"));

var density = (self.sprite_height * self.sprite_width) / 10
physics_fixture_set_density(self.fixture, density)
physics_fixture_set_friction(self.fixture, ds_map_find_value(phys_control_state, "friction"))
self.ref_friction = self.friction
physics_fixture_set_linear_damping(self.fixture, ds_map_find_value(phys_control_state, "linear_damping"))
self.ref_linear_damping = self.phy_linear_damping
physics_fixture_set_angular_damping(self.fixture, ds_map_find_value(phys_control_state, "angular_damping"))
physics_fixture_set_restitution(self.fixture, ds_map_find_value(phys_control_state, "restitution"))


//determine the sprites dividable width and height and offset our fixture to the 
//relative point of mass within that sprite. 
if (self.sprite_width % 2 == 0) {
	var x_fixture_offset = 0
} else if (self.sprite_width % 2 == 1) {
	var x_fixture_offset = -0.5
}

if (self.sprite_height % 2 == 0) {
	var y_fixture_offset = 0
} else if (self.sprite_height % 2 == 1) {
	var y_fixture_offset = -0.5
}

physics_fixture_bind_ext(self.fixture, self, x_fixture_offset, y_fixture_offset)

