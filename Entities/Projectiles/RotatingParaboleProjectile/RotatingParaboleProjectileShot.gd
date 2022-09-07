class_name RotatingParaboleProjectileShot
extends Shot

export var gravity: float = 8
export var speed_horizontal: float = 100
export var speed_vertical: float = 100
export var rotation_degree_speed: float = 1
export var inital_rotation_degrees: float = 0


func _init():
	# TODO:
	projectile_scene = load("res://Entities/Projectiles/RotatingParaboleProjectile/RotatingParaboleProjectile.tscn")
