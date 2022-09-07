class_name BarrierAttack
extends Attack

var base_appearance_time := 0.7
var base_existence_time := 3.0
var existence_time_scale := 0.5
var appearance_time_scale := 0.3
var base_warning_time := 1.5
var warning_time_scale := 0.3
var min_warning_time := 1

var position_pairs := [
	# Right side
	[Vector2(1, 0), Vector2(0, -1)],
	[Vector2(1, 0), Vector2(-1, -1)],
	[Vector2(1, 0), Vector2(0, 1)],
	[Vector2(1, 0), Vector2(-1, 1)],
	
	# Bottom side
	[Vector2(0, 1), Vector2(-1, -1)],
	[Vector2(0, 1), Vector2(-1,  0)],
	[Vector2(0, 1), Vector2( 1, -1)],

	# Left side
	[Vector2(-1, 0), Vector2( 1, -1)],
	[Vector2(-1, 0), Vector2( 0, -1)],
	[Vector2(-1, 0), Vector2( 1,  1)],

	# Top side
	[Vector2(0, -1), Vector2( -1,  1)],
	[Vector2(0, -1), Vector2( 1,  1)],
]


func _init(difficulty:=0):
	randomize()

	var amount = randi() % 3 + 1
	var position_pairs_copy = Array(position_pairs)

	for _i in range(amount):
		var shot := BarrierProjectileShot.new() 
		shot.existence_time = base_existence_time + difficulty * existence_time_scale
		var appearance_time := base_appearance_time
		var warning_time = base_warning_time

		if difficulty != 0:
			warning_time = base_warning_time - base_warning_time * warning_time_scale * log(difficulty)
			if warning_time < min_warning_time:
				warning_time = min_warning_time
			appearance_time = base_appearance_time - base_appearance_time * appearance_time_scale * log(difficulty)
			if appearance_time < 0.1:
				appearance_time = 0.1

		shot.appearance_time = appearance_time
		shot.warning_time = warning_time

		# determine random start and end position 
		position_pairs.shuffle()
		var position_pair = position_pairs_copy.pop_back()
		position_pair.shuffle()
		shot.position = position_pair[0]
		shot.end_position = position_pair[1]

		shots.append(shot)
		
	cooldown_time = 4
