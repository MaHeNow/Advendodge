class_name PillarProjectileShot
extends Shot

export var speed: float = 1
export(float, 0, 1, 0.125) var height: float = 0


func _init():
	# TODO:
	projectile_scene = load("res://Entities/Projectiles/PillarProjectile/PillarProjectile.tscn")
