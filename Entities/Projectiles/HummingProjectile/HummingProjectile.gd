class_name HomingProjectile
extends Projectile

export var acceleration: float = 100
export var max_speed: float = 200
export var minimal_size: float = 0.5
export var max_acceleration: float = 40
export var shrink_step: float = 0.999
export var speed: float = 0.0
export var gravity_constant: float = 25

var direction: Vector2 = Vector2(1, 0)


func setup(shot: Shot) -> Projectile:
	.setup(shot)

	return self


func determine_movement() -> void:
	"""
	First we determine the direction for the projectile (vector from current position to the
	player). Then, based on the distance, we determine the acceleration towards the player and
	add it to the current acceleration. Next, we adjust the current movement vector by
	a portion of the direction vector with length of the current acceleration vector. To avoid
	extreme speed, we put a cap on it.
	"""
	if player:
		self.direction = self.player.global_position - self.global_position
		var divisor: = self.direction.length() * self.direction.length() * self.direction.length()
		if divisor != 0:
			self.acceleration += (1 / divisor)
		if acceleration > max_acceleration:
			acceleration = max_acceleration
		self.movement += direction.normalized() * self.acceleration * gravity_constant
		if self.movement.length() > max_speed:
			self.movement = self.movement.normalized() * self.max_speed


func shrink() -> void:
	""" The projectile should shrink a little every frame and disappear if its too small."""
	if player:
		self.scale *= self.shrink_step
		if self.scale.length() <= self.minimal_size:
			queue_free()


func behave():
	shrink()
	determine_movement()
