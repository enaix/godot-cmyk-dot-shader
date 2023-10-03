shader_type spatial;

render_mode unshaded;

uniform float power = 3;

uniform float dot_spacing = 10;
uniform float dot_size = 2;
uniform float dots_hiding_threshold = 0.003;

const float a_1 = 2.0;
const float a_2 = 0.1;
const float a_3 = 0.12;

const float b_1 = 0.0;
const float b_2 = 0.0;
const float b_3 = 2.0;

const float c_1 = -0.3;

const float a_x = 14.3;
const float a_y = 13.2;
const float a_z = 43.3;
const float a_s = 10000.0;

vec3 dots(vec2 pos, vec3 dotcol, vec3 black, float a)
{
	pos = mat2(vec2(cos(a), sin(a)), vec2(-sin(a), cos(a))) * pos;
	if (pow(mod(pos.x, dot_spacing) - dot_size, 2) + pow(mod(pos.y, dot_spacing) - dot_size, 2) <= dot_size*dot_size)
	{
		return dotcol;
	}
	return black;
}

void fragment()
{
	vec3 col = vec3(0.0, 0.0, 0.0);
	float dist = pow(1.0 - dot(NORMAL, VIEW), power);
	float cam_dist = pow(length(VERTEX - VIEW), 2)*dots_hiding_threshold;
	
	if (dist > 0.01)
	{
		col = vec3(0.0, 1.0, 1.0);
		if (NORMAL.x - VIEW.x*cos(TIME+b_1)*a_1+c_1 > 0.0) col = vec3(1.0, 1.0, 0.0);
		if (NORMAL.y - VIEW.y < 0.05 + sin(TIME+b_2)*a_2+cos(TIME+b_3)*a_3) col = vec3(1.0, 0.0, 1.0);
	}
	if (dist > 0.01 && dist < 0.1 - cam_dist)
	{
		col = dots(SCREEN_UV * VIEWPORT_SIZE, col, vec3(0.0, 0.0, 0.0), a_x*col.x*sin(TIME)/a_s + a_y*col.y + a_z*col.z);
	}
	ALBEDO = col;
}
