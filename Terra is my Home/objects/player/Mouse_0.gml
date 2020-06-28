/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 272AB73C
/// @DnDArgument : "code" "dir = point_direction(self.x, self.y, mouse_x, mouse_y);$(13_10)xx = self.x + lengthdir_x(1000, dir);$(13_10)yy = self.y + lengthdir_y(1000, dir);$(13_10)draw_set_colour(c_aqua);$(13_10)draw_line(self.x, self.y, xx, yy);"
dir = point_direction(self.x, self.y, mouse_x, mouse_y);
xx = self.x + lengthdir_x(1000, dir);
yy = self.y + lengthdir_y(1000, dir);
draw_set_colour(c_aqua);
draw_line(self.x, self.y, xx, yy);