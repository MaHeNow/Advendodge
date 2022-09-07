shader_type canvas_item;

	uniform float speed = 1.0;
	uniform float amplitude = 0.05;
	uniform float freq = 7;
	uniform float y_offset = 0.1;
	
void fragment(){
	COLOR = texture(TEXTURE, vec2(UV.x, mod(UV.y+sin(TIME*speed+UV.y*freq)*amplitude,1.0) )); //read from texture
}