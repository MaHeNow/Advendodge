class_name WallBouncingProjectileShot
extends Shot

export var number_bounces: int = 0
export var direction_degree: float = 0
export var speed: float = 1


func _init():
	# TODO:
	projectile_scene = load("res://Entities/Projectiles/WallBouncingProjectile/WallBouncingProjectile.tscn")
