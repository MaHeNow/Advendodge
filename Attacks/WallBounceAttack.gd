class_name WallBounceAttack
extends Attack

var base_cooldown := 0.2
var min_amount := 2
var max_amount := 3
var min_bounces := 1
var max_bounces := 3
var base_speed := 100
var attack_cooldown := 0.5

var positions_directions := [
	# Positions and shooting angles
	
	# Top Left
	[Vector2(-1, -1), 133],
	[Vector2(-1, -1), 143],
	[Vector2(-1, -1), 155],
	[Vector2(-1, -0.8), 120],
	[Vector2( -1, -0.5), 120],

	# Top Right
	[Vector2( 1, -1), -133],
	[Vector2( 1, -1), -143],
	[Vector2( 1, -1), -155],
	[Vector2( 1, -0.8), -120],
	[Vector2( 1, -0.5), -120],
	
	# Bot Left
	[Vector2(-1,  1), 	27],
	[Vector2(-1,  1), 	37],
	[Vector2(-1,  1), 	47],
	[Vector2(-1,  0.5), 60],
	[Vector2(-0.8,  1), 30],
	
	# Bot Right
	[Vector2( 1,  1), -27],
	[Vector2( 1,  1), -37],
	[Vector2( 1,  1), -47],
	[Vector2( 1,  0.8), -60],
	[Vector2( 0.5,  1), -37],
]


func _init(difficulty:=0):
	randomize()
	var amount := randi() % (max_amount - min_amount + 1) + min_amount
	var positions_directions_copy := Array(positions_directions)
	positions_directions_copy.shuffle()

	for i in range(amount):
		var shot := WallBouncingProjectileShot.new()

		var position_direction: Array = positions_directions_copy.pop_front()
		var position: Vector2 = position_direction[0]
		var direction: int = position_direction[1]
		shot.cooldown_time = base_cooldown
		shot.position = position
		shot.direction_degree = direction
		shot.speed = base_speed
		shot.number_bounces = int(rand_range(min_bounces, max_bounces))
		shots.append(shot)

	cooldown_time = attack_cooldown
