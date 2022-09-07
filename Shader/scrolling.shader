shader_type canvas_item;

uniform vec2 speed_direction = vec2(0.01, 0.01);


void fragment(){
    COLOR = texture(TEXTURE, vec2(mod(UV.x-TIME*speed_direction.x, 1.0), mod(UV.y-TIME*speed_direction.y, 1.0)));
}