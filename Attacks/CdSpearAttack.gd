class_name CdSpearAttack
extends Attack

var base_speed := 300.0
var min_amount := 2
var max_amount := 3
var base_cooldown := 0.8
var min_cooldown := 0.15

var speed_scale_factor := 10
var cooldown_scale_factor := 0.3

func _init(difficulty:=0):
	randomize()
	
	var amount := randi() % (max_amount - min_amount + 1) + min_amount
	var speed := base_speed + speed_scale_factor * difficulty
	var cooldown := base_cooldown

	if difficulty != 0:
		cooldown = base_cooldown - base_cooldown * cooldown_scale_factor * log(difficulty)
		if cooldown < 0.2:
			cooldown = 0.2

	for _i in range(amount):
		var shot := CDProjectileShot.new()
		shot.speed = speed
		shot.cooldown_time = cooldown
		shots.append(shot)
