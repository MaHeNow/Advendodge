class_name HealthBar
extends Node2D

export var change_time: float = 0.7

var session: Session setget set_session

onready var tween: Tween = $Tween
onready var bar: ProgressBar = $Bar


func set_session(session_: Session):
	session = session_
	session.connect("health_changed", self, "_on_session_health_changed")
	bar.max_value = session.character.max_health
	bar.value = session.current_health


func _on_session_health_changed(change_amount: float):
	var from := session.current_health + change_amount
	var to := session.current_health
	tween.interpolate_property(
		bar,
		"value",
		from,
		to,
		change_time, 
		Tween.TRANS_EXPO,
		Tween.EASE_OUT
	)
	tween.start()
