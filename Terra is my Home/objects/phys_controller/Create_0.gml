self.depth = 0
self.current_tile = 0
self.previous_tile = 0


//temporary refrencial mappings of movement physics.
//these will have to be moved to an external db storage of some kind to facilitate the larger amount of 
//vehicle types we will require.

//e.g. var foot_phys will read more like var tank_scorpion_light_tank or var starfighter_needle_interceptor
var foot_phys = ds_map_create();
ds_map_add(foot_phys, "max_forward_thrust", 0.010);
ds_map_add(foot_phys, "max_reverse_thrust", -0.010);
ds_map_add(foot_phys, "max_strafe_thrust", 0.010);
ds_map_add(foot_phys, "max_torque_thrust", 0.01);
ds_map_add(foot_phys, "density", 0.1);
ds_map_add(foot_phys, "restitution", 0.1);
ds_map_add(foot_phys, "collision_group", 1);
ds_map_add(foot_phys, "linear_damping", 5);
ds_map_add(foot_phys, "angular_damping", 0.1);
ds_map_add(foot_phys, "friction", 0.1);

var flight_phys = ds_map_create();
ds_map_add(flight_phys, "max_forward_thrust", 0.16);
ds_map_add(flight_phys, "max_reverse_thrust", -0.16);
ds_map_add(flight_phys, "max_strafe_thrust", 0.16);
ds_map_add(flight_phys, "max_torque_thrust", 0.005);
ds_map_add(flight_phys, "density", 0.5);
ds_map_add(flight_phys, "restitution", 0.1);
ds_map_add(flight_phys, "collision_group", 1);
ds_map_add(flight_phys, "linear_damping", 0.5);
ds_map_add(flight_phys, "angular_damping", 0.5);
ds_map_add(flight_phys, "friction", 0.01);


//the map containing maps, will be fed by external file data in future using a for loop
//each map contained in here is a set of reference data telling an entity how it should move 
//about in the game world (e.g. power armour moves differently to on foot).
var phys_control_map = ds_map_create();
ds_map_add(phys_control_map, "foot_phys", foot_phys);
ds_map_add(phys_control_map, "flight_phys", flight_phys);

//phys control state is set by string index, I NEED a way of securely determining what an item
//or entities physical movement state is indexed to.
self.phys_control_state_map_index = "foot_phys";
self.phys_control_state = ds_map_find_value(phys_control_map, phys_control_state_map_index);





//movement variables 
self.max_forward_thrust =  ds_map_find_value(phys_control_state, "max_forward_thrust");
self.max_reverse_thrust = ds_map_find_value(phys_control_state, "max_reverse_thrust");
self.desired_x_thrust = 0;

self.max_strafe_thrust = ds_map_find_value(phys_control_state, "max_strafe_thrust");
self.desired_strafe_thrust = 0;

self.max_torque_thrust = ds_map_find_value(phys_control_state, "max_torque_thrust");
self.desired_torque_thrust = 0;

self.desired_point_angle = 0;





// interaction variables

// control state 
// 0 = walking
// 1 = driving
// 2 = flying
// -1 = restrained
// -2 = unconscious
self.control_state = 0;

self.layer_transition_slowdown = 0;