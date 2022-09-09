class_name LinearProjectileShot
extends Shot

export var rotation_degree_: float = 0
export var speed: float = 1


func _init():
	# TODO:
	projectile_scene = load("res://Entities/Projectiles/LinearProjectile/LinearProjectile.tscn")
