class_name LinearProjectile
extends Projectile


func setup(shot: Shot) -> Projectile:
	.setup(shot)
	if shot is LinearProjectileShot:
		self.rotation_degrees = shot.rotation_degree_
		self.movement = shot.speed * Vector2.UP.rotated(
			deg2rad(shot.rotation_degree_)
		)
		
	return self
