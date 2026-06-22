shader_type canvas_item;

uniform sampler2D screen : hint_screen_texture, repeat_enable, filter_nearest;

float random(float p) {
    p = fract(p * 0.011); 
    p *= p + 7.5; p *= p + p; 
    return fract(p); 
}

const float offset = 0.05;
const float cutoffs[11] = {
	0.0, 
    0.115, 
    0.287, 
    0.391, 
    0.442, 
    0.518, 
    0.639, 
    0.721, 
    0.804, 
    0.893, 
    0.957
};

void fragment() {
	float rand = random(float(int(floor(TIME * 10.0)) % 100));
	int range = int(floor(rand * 17.0));
	rand = (rand - 0.5) * 2.0;
	vec2 offset_uv = vec2(0.0, 0.0);
	if (SCREEN_UV.y > cutoffs[range] && SCREEN_UV.y < cutoffs[range + 1]) {
		offset_uv.x = rand * offset;
	}
	
	vec3 color = texture(screen, SCREEN_UV + offset_uv).rgb;
	
	COLOR.rgb = color;
}
