shader_type canvas_item;

uniform float change_speed = 10;
uniform int buffer_size : hint_range(2,14);
uniform sampler2D color_palette;


void fragment(){
	const int maximum_buffer_size = 14;
	float number_colors = float(textureSize(color_palette, 0).x)-2f;
	vec4 buffer[14];
	for(int i = 0; i < maximum_buffer_size; i++){
		float color_palette_index = mod((float(i) + TIME*change_speed), number_colors-2f)/number_colors;
		buffer[i] = texture(color_palette, vec2(color_palette_index,0));
	}
	
	float intensity = texture(TEXTURE, UV).r;
	
	if (intensity == 0.){
		COLOR.rgb = texture(color_palette, vec2(1, 0)).rgb;
	} else if (intensity == 1.){
		COLOR.rgb = texture(color_palette, vec2((number_colors-1f)/number_colors, 0)).rgb;
	} else {
		COLOR.rgb = buffer[int(mod(floor(intensity * float(buffer_size)),float(buffer_size)))].rgb;
	}
}
