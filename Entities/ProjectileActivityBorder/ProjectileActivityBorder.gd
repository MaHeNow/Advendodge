extends Area2D


func _on_ProjectileActivityBorder_area_exited(area):
	if area is ProjectileArea:
		area.emit_signal("exited_game_area")
