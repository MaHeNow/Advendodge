class_name RotatingParaboleAttack
extends Attack

var base_amount := 5
var base_cooldown := 1.3
var shot_types := [
	# positon, horizontal speed, vertical speed, rotation speed, initial degree
	[Vector2(-0.5, -1), 0, 0, 0, 90],
	[Vector2(   0, -1), 0, 0, 0, 90],
	[Vector2( 0.5, -1), 0, 0, 0, 90],

	[Vector2( 1, 0.2), -100, 300, 10, 0],
	[Vector2( -1, 0.2), 100, 300, -10, 0],

	[Vector2( -1, 0.2), 80, 300, 1, 0],
	[Vector2(  1, 0.2), -80, 300, -1, 0],

	[Vector2( -1, 0.5), 100, 380, 7, 0],
	[Vector2(  1, 0.5), -100, 380, 7, 0],

	[Vector2( -0.4, 1), 0, 280, 7, 90],
	[Vector2(  0, 1), 0, 280, 7, 90],
	[Vector2(  0.4, 1), 0, 280, 7, 90],
]


func _init(difficulty:=0):
	randomize()
	var shot_types_copy := Array(shot_types) 
	shot_types_copy.shuffle()

	for _i in range(base_amount):
		var type: Array = shot_types_copy.pop_front()

		var shot := RotatingParaboleProjectileShot.new()
		shot.position = type[0]
		shot.speed_horizontal = type[1]
		shot.speed_vertical = type[2]
		shot.rotation_degree_speed = type[3]
		shot.inital_rotation_degrees = type[4]

		shot.cooldown_time = base_cooldown
		shot.warning = true

		shots.append(shot)
