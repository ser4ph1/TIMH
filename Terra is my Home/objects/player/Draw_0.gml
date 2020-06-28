draw_self()
if mouse_check_button(mb_left) {
	dir = point_direction(self.x - 0.5, self.y - 0.5, mouse_x, mouse_y);
	xx = self.x + lengthdir_x(1000, dir);
	yy = self.y + lengthdir_y(1000, dir);
	draw_set_colour(c_aqua);
	draw_line(self.x, self.y, xx, yy);
}
