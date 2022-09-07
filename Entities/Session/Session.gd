class_name Session
extends Resource

signal health_changed(amount)
signal points_changed(points)

var character: Character setget set_character
var current_health: float setget set_current_health
var number_points: float = 0 setget set_points


func set_character(character_: Character):
	character = character_
	current_health = character_.max_health


func set_current_health(health: float):
	var changed_amount = current_health - health
	current_health = health
	emit_signal("health_changed", changed_amount)


func set_points(points: float):
	number_points = points
	emit_signal("points_changed", number_points)
