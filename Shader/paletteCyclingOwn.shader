shader_type canvas_item;

uniform sampler2D color_palette;
uniform int buffer_size : hint_range(2, 64);
uniform float speed = -1;

void fragment(){
	vec4 textureColor = texture(TEXTURE, UV);
	float intensity = textureColor.r;
	float number_colors = float(textureSize(color_palette, 0).x);
	float index = clamp(mod(intensity + TIME*speed, 1), 2./float(number_colors), 1);
	
	if (intensity == 0.){
		COLOR.rgb = texture(color_palette, vec2(0./number_colors, 0)).rgb;
	} else if (intensity == 1.){
		COLOR.rgb = texture(color_palette, vec2(1./number_colors, 0)).rgb;
	} else {
		COLOR.rgb = texture(color_palette, vec2(index, 0)).rgb;
	}

	COLOR.a = textureColor.a;
}