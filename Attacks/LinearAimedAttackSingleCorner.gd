class_name LinearAimedAttackSingleCorner
extends Attack

var base_cooldown := 0.4
var cooldown_scale := 0.3
var min_cooldown := 0.15
var min_amount := 8
var max_amount := 12
var base_speed := 100
var speed_scale := 10
var attack_cooldown := 0

var corners = [
	Vector2(-1, -1),
	Vector2( 1, -1),
	Vector2(-1,  1),
	Vector2( 1,  1),
]

func _init(difficulty:=0):
	randomize()
	var amount := randi() % (max_amount - min_amount + 1) + min_amount
	corners.shuffle()
	var corners_copy := Array(corners)
	var corner: Vector2 = corners_copy.pop_front()
	var cooldown := base_cooldown
	if difficulty != 0:
		cooldown = base_cooldown - base_cooldown * cooldown_scale * log(difficulty)
		if cooldown < min_cooldown:
			cooldown = min_cooldown

	for _i in range(amount):
		var shot := LinearAimedProjectileShot.new()
		shot.cooldown_time = base_cooldown
		shot.position = corner
		shot.speed = base_speed + difficulty * speed_scale
		shots.append(shot)

	cooldown_time = attack_cooldown
