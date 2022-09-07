class_name LinearAimedProjectileShot
extends Shot

export var speed := 100.0


func _init():
	# TODO:
	projectile_scene = load("res://Entities/Projectiles/LinearAimedProjectile/LinearAimedProjectile.tscn")
