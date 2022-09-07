shader_type canvas_item;

uniform float speed = 10.0;
uniform float amplitude = 0.1;
uniform float freq = 10;

void fragment(){
	COLOR = texture(TEXTURE, vec2(mod(UV.x+sin(TIME*speed+UV.y*freq)*amplitude, 1.0), UV.y)); //read from texture
}