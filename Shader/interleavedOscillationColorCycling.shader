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

uniform float cycle_speed = 10;
uniform int buffer_size : hint_range(2,14);
uniform sampler2D color_palette;

void fragment(){
	vec2 texture_size = vec2(textureSize(TEXTURE, 0));
	vec4 current_color;
	if (floor(mod(UV.y*texture_size.y, float(number_offset_pixels))) == 0.0){
		current_color = texture(TEXTURE, vec2(UV.x+sin(TIME*even_speed+UV.y*even_freq + even_offset*3.1415)*even_amplitude, UV.y));
	} else {
		current_color = texture(TEXTURE, vec2(UV.x+sin(TIME*odd_speed+UV.y*odd_freq + odd_offset*3.1415)*odd_amplitude , UV.y));
	}
	
	const int maximum_buffer_size = 14;
	float number_colors = float(textureSize(color_palette, 0).x)-2f;
	vec4 buffer[14];
	for(int i = 0; i < maximum_buffer_size; i++){
		float color_palette_index = mod((float(i) + TIME*cycle_speed), number_colors-2f)/number_colors;
		buffer[i] = texture(color_palette, vec2(color_palette_index,0));
	}
	
	float intensity = current_color.r;
	
	if (intensity == 0.){
		current_color = texture(color_palette, vec2(1, 0));
	} else if (intensity == 1.){
		current_color = texture(color_palette, vec2((number_colors-1f)/number_colors, 0));
	} else {
		current_color = buffer[int(mod(floor(intensity * float(buffer_size)),float(buffer_size)))];
	}
	
	COLOR = current_color;
}