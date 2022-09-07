extends Sprite


func set_game_window_center():
	self.texture.size = OS.window_size
	self.material.set_shader_param("window_extent", ScreenSize.game_size)
	self.material.set_shader_param("center", texture.size / 2 - Vector2(0, ScreenSize.touch_area_size / 2))
