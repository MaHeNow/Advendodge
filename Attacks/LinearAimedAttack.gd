class_name LinearAimedAttack
extends Attack

var base_cooldown := 0.5
var cooldown_scale := 0.4
var min_cooldown := 0.1
var min_amount := 10
var max_amount := 15

var base_speed := 100
var speed_scale := 10


func _init(difficulty:=0):
	var amount := randi() % (max_amount - min_amount + 1) + min_amount
	var cooldown := base_cooldown
	if difficulty > 0:
		cooldown = base_cooldown - base_cooldown * cooldown_scale * log(difficulty)
		if cooldown < min_cooldown:
			cooldown = min_cooldown

	for _i in range(amount):
		var shot := LinearAimedProjectileShot.new()
		shot.cooldown_time = base_cooldown
		shot.speed = base_speed + speed_scale * difficulty
		shots.append(shot)
