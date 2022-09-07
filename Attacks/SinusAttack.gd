class_name SinusAttack
extends Attack

var base_speed := 100
var speed_scale := 10
var base_cooldown := 0.1
var attack_cooldown := 2
var min_repetitions := 1
var max_repetitions := 2
var min_amount := 5
var max_amount := 7

var positions_angles_amp_wlength: = [
	# Left and right
	[Vector2(1, -0.3), -90, 70, 120],
	[Vector2(1, 0), -90, 70, 120],
	[Vector2(1, 0.3), -90, 70, 120],
	
	[Vector2(-1, 0.3), 90, 70, 120],
	[Vector2(-1, 0), 90, 70, 120],
	[Vector2(-1, -0.3), 90, 70, 120],
	
	# Up and down
	[Vector2(0, -1), 180, 70, 100],
	[Vector2(0, 1), 0, 70, 100],

	[Vector2(0.4, -1), 180, 70, 100],
	[Vector2(0.4, 1), 0, 70, 100],

	[Vector2(-0.4, -1), 180, 70, 100],
	[Vector2(-0.4, 1), 0, 70, 100],

	# Diagonal
	[Vector2(1, 1), -37, 70, 120],
	[Vector2(-1, 1), 37, 70, 120],

	[Vector2(1, -1), -143, 70, 120],
	[Vector2(-1, -1), 143, 70, 120],
]


func _init(difficulty:=0):
	var positions_angles_amp_wlength_copy := Array(positions_angles_amp_wlength)
	positions_angles_amp_wlength_copy.shuffle()
	var repetitions := randi() % (max_repetitions - min_repetitions + 1) + min_repetitions
	
	for _j in range(repetitions):
		var position_angle_amp_wlength: Array = positions_angles_amp_wlength_copy.pop_front()
		var position: Vector2 = position_angle_amp_wlength[0]
		var angle: int = position_angle_amp_wlength[1]
		var amp: int = position_angle_amp_wlength[2]
		var wlength: int = position_angle_amp_wlength[3]
		var amount := randi() % (max_amount - min_amount + 1) + min_amount

		for _i in range(amount):
			var shot := SinusProjectileShot.new()
			shot.position = position
			shot.rotation_degrees = angle
			shot.amplitude = amp
			shot.wavelength = wlength
			shot.cooldown_time = base_cooldown
			shot.speed = base_speed + speed_scale * difficulty

			shots.append(shot)

	cooldown_time = attack_cooldown
