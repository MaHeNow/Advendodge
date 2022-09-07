class_name Wave
extends Resource

export(Array, Resource) var attacks: = []
var total_time: float = 0;


func _init():
	for attack in attacks:
		total_time += attack.total_time
