class_name ProjectileArea
extends Area2D

signal collided_with_player(player)
signal exited_game_area

var parent_projectile


func _on_ProjectileArea_body_entered(body):
	if body is Player:
		emit_signal("collided_with_player", body)


func _ready():
	var parent = get_parent()
	if parent != null:
		parent_projectile = parent
