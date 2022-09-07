class_name LinearAimedProjectile
extends Projectile

export var speed := 2.0
var direction: Vector2 = Vector2(1, 0)


func _ready() -> void:
	emit_signal("request_player", self)
	self.direction = player.global_position - self.global_position
	self.rotation = self.direction.angle()
	self.movement = self.direction.normalized() * self.speed


func setup(shot: Shot) -> Projectile:
	.setup(shot)
	if shot is LinearAimedProjectileShot:
		self.speed = shot.speed

	return self
