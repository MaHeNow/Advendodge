class_name AttackEditor
extends Node2D

export(Resource) var attack


func _ready(): 
	if attack is Attack:
		var path_: String = attack.resource_path
		attack.shots = []
		
		for i in range(100):
			var shot = LinearAimedProjectileShot.new()
			shot.speed = 0
			attack.shots.append(shot)
		ResourceSaver.save(path_, attack)
