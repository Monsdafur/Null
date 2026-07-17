shader_type canvas_item;

uniform sampler2D albedo : filter_nearest;
uniform int stride;
uniform bool enabled;

vec3 correct_color(vec3 c) {
	ivec3 ci = ivec3(floor(c * 255.0));
	ci += (stride - (ci % stride)) - 1;
	return vec3(ci) / 255.0;
} 

void fragment() {
	vec4 color = texture(albedo, UV);
	if (enabled) {
		color.rgb = correct_color(color.rgb);
	}
	COLOR = vec4(color.rgb, color.a);
}