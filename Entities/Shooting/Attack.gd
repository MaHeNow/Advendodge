class_name Attack
extends Resource

export var cooldown_time: float = 0
var shots := []
var total_time: float = 0


func _init(difficulty=0):
	for shot in shots:
		if shot is Shot:
			total_time += shot.buildup_time
			total_time += shot.cooldown_time
