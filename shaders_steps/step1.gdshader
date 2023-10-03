shader_type spatial;

render_mode unshaded;

uniform float power = 3;

uniform float dot_spacing = 10;
uniform float dot_size = 2;
uniform float angle = 45;

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
	
	if (dist > 0.01)
	{
		col = vec3(0.0, 1.0, 1.0);
		if (NORMAL.x - VIEW.x > 0.0) col = vec3(1.0, 1.0, 0.0);
		if (NORMAL.y - VIEW.y < 0.0) col = vec3(1.0, 0.0, 1.0);
		
		col = dots(SCREEN_UV * VIEWPORT_SIZE, col, vec3(0.0, 0.0, 0.0), 0.0);
	}
	ALBEDO = col;
}
