class_name RotatingParaboleProjectile
extends Projectile

var gravity: float = 10
var speed_horizontal: float = 100
var speed_vertical: float = 100
var rotation_degree_speed: float = 1


func setup(shot: Shot) -> Projectile:
	.setup(shot)
	# TODO:
	if shot is RotatingParaboleProjectileShot:
		gravity = shot.gravity
		speed_horizontal = shot.speed_horizontal
		speed_vertical = shot.speed_vertical
		rotation_degree_speed = shot.rotation_degree_speed
		rotation_degrees = shot.inital_rotation_degrees
		movement = Vector2(speed_horizontal, -speed_vertical)

	return self


func behave():
	movement -= Vector2.UP * gravity
	rotation_degrees += rotation_degree_speed
