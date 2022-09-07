class_name SinusProjectileShot
extends Shot

export var amplitude: float = 5.0
export var wavelength: float = 1.0
export var speed: float = 100.0
export var rotation_degrees: float = 0


func _init():
	# TODO:
	projectile_scene = load("res://Entities/Projectiles/SinusProjectile/SinusProjectile.tscn")
