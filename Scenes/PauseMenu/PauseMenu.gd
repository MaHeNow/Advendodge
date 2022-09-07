class_name PauseMenu
extends Node

signal resume
signal restart

onready var animation_player: AnimationPlayer = $AnimationPlayer


func appear():
	animation_player.play("appear")


func disappear():
	animation_player.play("disappear")


func _on_ResumeButton_pressed():
	emit_signal("resume")


func _on_RestartButton_pressed():
	emit_signal("restart")
