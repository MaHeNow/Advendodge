class_name LinearAttack
extends Attack

var base_cooldown := 0.2
var min_amount := 3
var max_amount := 5
var base_speed := 100
var attack_cooldown := 1
# How much the projectiles spread in both directions
var spread := 55.0
var speed_scale := 10
var min_repetitions := 2
var max_repetitions := 4

var corners_directions := [
	# Positions and shooting angles
	[Vector2(-1, -1), 143],
	[Vector2( 1, -1), -143],
	[Vector2(-1,  1), 37],
	[Vector2( 1,  1), -37],
]


func _init(difficulty:=0):
	randomize()
	var repetitions := randi() % (max_repetitions - min_repetitions + 1) + min_repetitions
	for _j in range(repetitions):
		var amount := randi() % (max_amount - min_amount + 1) + min_amount
		var corners_directions_copy := Array(corners_directions)
		corners_directions_copy.shuffle()
		var corner_direction: Array = corners_directions_copy.pop_front()
		var corner: Vector2 = corner_direction[0]
		var direction: int = corner_direction[1]
		var spread_step := int(spread / amount)
	
		for i in range(amount):
			var shot := LinearProjectileShot.new()
			shot.cooldown_time = base_cooldown
			shot.position = corner
			shot.rotation_degree_ = direction + (i - int(amount / 2.0)) * spread_step
			shot.speed = base_speed + speed_scale * difficulty
			shots.append(shot)

	cooldown_time = attack_cooldown
