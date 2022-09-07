extends Node

var game_size := Vector2(
		ProjectSettings.get_setting("display/window/size/width")/2, 
		ProjectSettings.get_setting("display/window/size/height")/2
	)
var window_size := Vector2(
		ProjectSettings.get_setting("display/window/size/width")/2, 
		ProjectSettings.get_setting("display/window/size/height")/2
	)
var touch_area_size := 80.0
var room_size_extent := 55.0
var offset: Vector2 = Vector2.ZERO


func set_offset(offset_: Vector2) -> void:
	if offset == Vector2.ZERO:
		offset = offset_
		game_size += offset_


func get_height() -> float:
	return game_size.y


func get_width() -> float:
	return game_size.x


func at_screen(position: Vector2) -> Vector2:
	""" x and y both should be a float between -1 and 1, where (-1, -1) returns
		the top left corner, (1, -1) the top right corner and so on.
	"""
	return position*game_size
