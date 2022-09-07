class_name BarrierProjectileShot
extends Shot

export var end_position: Vector2
export var appearance_time: float = 0.5
export var existence_time: float = 1.0
export var warning_time: float = 1.5

func _init():
	# TODO:
	projectile_scene = load("res://Entities/Projectiles/BarrierProjectile/BarrierProjectile.tscn")
