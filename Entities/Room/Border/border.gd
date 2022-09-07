class_name Border
extends StaticBody2D

signal entered(body)
signal exited
signal closed


func _on_BorderArea_body_entered(body):
	if body is Player:
		emit_signal("entered", body)


func _on_BorderArea_body_exited(body):
	if body is Player:
		emit_signal("exited")
