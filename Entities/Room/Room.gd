class_name GameRoom
extends Position2D

signal appeared

var height: float = 116
onready var border: Border = $Border
onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("appeared")
