shader_type canvas_item;

uniform int number_offset_pixels = 2;

uniform float even_speed = 1f;
uniform float even_amplitude = 0.1;
uniform float even_freq = 10;
uniform float even_offset = 0f;

uniform float odd_speed = 1f;
uniform float odd_amplitude = 0.15;
uniform float odd_freq = 10;
uniform float odd_offset = 0f;

void fragment(){
	vec2 texture_size = vec2(textureSize(TEXTURE, 0));
	if (floor(mod(UV.y*texture_size.y, float(number_offset_pixels))) == 0.0){
		COLOR = texture(TEXTURE, vec2(UV.x+sin(TIME*even_speed+UV.y*even_freq)*even_amplitude + even_offset, UV.y));
	} else {
		COLOR = texture(TEXTURE, vec2(UV.x+sin(TIME*odd_speed+UV.y*odd_freq)*odd_amplitude + odd_offset, UV.y));
	}
}