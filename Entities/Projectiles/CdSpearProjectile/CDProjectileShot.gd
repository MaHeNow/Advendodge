class_name CDProjectileShot
extends Shot

export var speed := 5.0
export var aiming_time := 1.0


func _init():
	# TODO:
	projectile_scene = load("res://Entities/Projectiles/CdSpearProjectile/CDProjectile.tscn")
