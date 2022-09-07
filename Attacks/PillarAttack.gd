class_name PillarAttack
extends Attack

var base_speed := 70
var speed_step := 10
var base_cooldown := 1
var amount := 10
var space_between := 70
var speed_scale_factor := 0.1
var cooldown_scale_factor := 0.35
var attack_cooldown := 0


func _init(difficulty:=0):
	randomize()
	var speed := base_speed + speed_step*difficulty
	var cooldown_: float = float(space_between)/speed
	var side := -1 if randi() % 2 == 0 else 1

	for _i in range(amount):
		var shot := PillarProjectileShot.new()
		shot.speed = speed
		shot.cooldown_time = cooldown_
		shot.position = Vector2(side, 0)
		shot.height = 0 # will generate a random height
		shots.append(shot)
		
	cooldown_time = attack_cooldown
