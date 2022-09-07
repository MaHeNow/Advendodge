class_name HomingAttack
extends Attack

var min_amount := 1
var max_amount := 2
var base_cooldown := 0.8

var cooldown_scale_factor := 0.3
var min_cooldown := 0.2
var attack_cooldown_scale := 5

func _init(difficulty:=0):
	randomize()

	var amount = randi() % (max_amount - min_amount + 1) + min_amount
	var cooldown := base_cooldown
	if difficulty != 0:
		cooldown = base_cooldown - base_cooldown * cooldown_scale_factor * log(difficulty)
		if cooldown < min_cooldown:
			cooldown = min_cooldown

	for _i in range(amount):
		var shot := HummingProjectileShot.new()
		shot.warning = true
		shot.cooldown_time = cooldown
		shots.append(shot)
		
	cooldown_time = cooldown * attack_cooldown_scale
