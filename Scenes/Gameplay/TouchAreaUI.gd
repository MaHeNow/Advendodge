extends Node2D

var touch_area: TouchArea setget set_touch_area
onready var touch_area_top := $TouchAreaTop


func set_touch_area(touch_area: TouchArea):
	randomize()
	var uncovered_screen_length: float = OS.window_size.y - self.global_position.y
	var number_of_sprites_to_add := ceil(uncovered_screen_length / ScreenSize.touch_area_size)
	touch_area_top.texture = touch_area.touch_area_texture
	touch_area_top.offset = touch_area.touch_area_offset
	for i in range(number_of_sprites_to_add):
		var new_sprite: Sprite = Sprite.new()
		new_sprite.texture = touch_area.touch_area_patter_texture
		new_sprite.position = Vector2(
			0,
			(i + 1) * ScreenSize.touch_area_size
		)
		new_sprite.offset = touch_area.touch_area_offset
		if touch_area.randomized_flipping:
			var option := randi() % 3
			match option:
				0: 
					new_sprite.flip_h = true
				1:
					new_sprite.flip_h = true
					new_sprite.flip_v = true
		add_child(new_sprite)
