class_name WallBouncingProjectile
extends Projectile

export var total_bounces: int = 0
export var direction_degree: float = 0

var darkest_value: float = 0.35
var inside: = false
var done_bouncing: = false
var bounces: int = 0
var recent_collider = null

onready var BodyHitbox: = $BodyHitbox


func setup(shot: Shot) -> Projectile:
	.setup(shot)
	if shot is WallBouncingProjectileShot:
		movement = Vector2.UP.rotated(deg2rad(shot.direction_degree)) * shot.speed
		total_bounces = shot.number_bounces

	return self


func behave():
	# this outer construct prevents from multiple collisions getting registered
	# with the same object
	if get_slide_count() == 0:
		recent_collider = null
	for i in range(get_slide_count()):
		var collision: KinematicCollision2D = get_slide_collision(i)
		var collider = collision.collider
		if collider:
			print(collider)
			if recent_collider == null:
				if inside and not done_bouncing:
					if bounces < total_bounces:
						if abs(position.x) > abs(position.y):
							movement.x *= -1
						else:
							movement.y *= -1
						if bounces == total_bounces-1:
							explosion_particles.emitting = true
							BodyHitbox.set_deferred("disabled", true)
							done_bouncing = true
							damage = 0
						bounces += 1
						modulate.v = 1 - bounces * (1 - darkest_value) / total_bounces
			recent_collider = collider


func _on_ProjectileArea_area_entered(area):
	if area is BorderArea:
		if not inside and not done_bouncing:
			inside = true
			BodyHitbox.set_deferred("disabled", false)
