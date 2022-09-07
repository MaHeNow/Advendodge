shader_type canvas_item;

uniform sampler2D color_palette;
uniform int buffer_size : hint_range(0, 256);
uniform float speed = 20;

const float max_intensity = 239./255.;
const float min_intensity = 16./255.;

float transform_range(float OldValue){
	float OldRange = (max_intensity - min_intensity); 
	float NewRange = (1f - 0f); 
	float NewValue = (((OldValue - min_intensity) * NewRange) / OldRange) + 0f;
	return NewValue;
}


void fragment(){
	float buffer_size_ = float(buffer_size) - 1f;
	vec4 textureColor = texture(TEXTURE, UV);
	float original_intensity = textureColor.r;
	float intensity = textureColor.r;
	float number_colors = float(textureSize(color_palette, 0).x)-2f;
	float index = clamp(mod(intensity, 1), 2./float(buffer_size_), 1);
	float index2 = clamp(mod(index, 1), 2./float(number_colors), 1);
	
	
	float x = float(buffer_size_)/number_colors;
	float transformed_intensity = intensity * x;
	//float offset = mod(TIME*speed +transformed_intensity, 1f - 2f/float(number_colors)) + 2f/float(number_colors);
	float final_index = mod(transformed_intensity + mod(floor(TIME*speed), number_colors-2f) /number_colors , (number_colors-2f)/number_colors);
	//float some_other_index = mod(TIME+intensity, 1f - 2f/float(number_colors)) + 2f/float(number_colors);
	
	//float x = float(buffer_size)/number_colors;
	//float transformed_intensity = intensity * x;
	float offset = mod(TIME*speed, 1);
	//float final_index = offset + transformed_intensity;
	
	if (original_intensity == 0.){
		COLOR.rgb = texture(color_palette, vec2(1, 0)).rgb;
	} else if (original_intensity == 1.){
		COLOR.rgb = texture(color_palette, vec2((number_colors-1f)/number_colors, 0)).rgb;
	} else {
		COLOR.rgb = texture(color_palette, vec2(final_index, 0)).rgb;
	}
	//COLOR.rgb = vec3(number_colors/14f, 0, 0);
	//COLOR.rgb = vec3(transformed_intensity, 0, 0);
	COLOR.a = textureColor.a;
}