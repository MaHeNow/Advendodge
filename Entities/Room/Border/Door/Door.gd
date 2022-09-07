class_name Door
extends StaticBody2D

signal closed

onready var animation_player: AnimationPlayer = $AnimationPlayer


func open():
	animation_player.play("open")


func close():
	animation_player.play("close")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "close":
		emit_signal("closed")
