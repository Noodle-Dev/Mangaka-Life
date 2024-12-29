shader_type canvas_item;

uniform float density: hint_range(4.0, 25.0) = 10.0;
uniform vec4 color1: source_color;
uniform vec4 color2: source_color;


void fragment() {
	float x = (UV.x-.5);
	float y = (UV.y-.5);
	float v = (sqrt((x*x)+(y*y)) * density);
	float can_color = mod(v, 2.0);
	vec4 color;
	if (can_color > 1.0) {
		color.rgb = color1.rgb;
	}else{
		color.rgb = color2.rgb;
	}
	color.a = 1.0;
	COLOR = vec4(color.rgba);
}