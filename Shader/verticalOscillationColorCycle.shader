shader_type canvas_item;

uniform float oscillation_speed = 1;
uniform float amplitude = 0.1;
uniform float freq = 10;
uniform float y_offset = 0.1;

uniform float cycle_speed = 10;
uniform int buffer_size : hint_range(2,14);
uniform sampler2D color_palette;

void fragment(){
	vec4 current_color = texture(TEXTURE, vec2(UV.x, mod(UV.y+sin(TIME*oscillation_speed+UV.y*freq)*amplitude,1.0) ));
	
	const int maximum_buffer_size = 14;
	float number_colors = float(textureSize(color_palette, 0).x)-2f;
	vec4 buffer[14];
	for(int i = 0; i < maximum_buffer_size; i++){
		float color_palette_index = mod((float(i) + TIME*cycle_speed), number_colors-2f)/number_colors;
		buffer[i] = texture(color_palette, vec2(color_palette_index,0));
	}
	
	float intensity = current_color.r;
	float alpha = current_color.a;
	
	if (intensity == 0.){
		current_color = texture(color_palette, vec2(1, 0));
	} else if (intensity == 1.){
		current_color = texture(color_palette, vec2((number_colors-1f)/number_colors, 0));
	} else {
		current_color = buffer[int(mod(floor(intensity * float(buffer_size)),float(buffer_size)))];
	}
	if (alpha != 0.0){
		COLOR = current_color;
	} else {
		COLOR = vec4(1,1,1,0);
	}
}