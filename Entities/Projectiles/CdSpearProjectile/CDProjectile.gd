class_name CDProjectile
extends Projectile

export var speed := 5.0
export var aiming_time := 1.0

var target_acquired := false
var released := false
var direction: Vector2 = Vector2(1, 0)


func _ready() -> void:
	emit_signal("request_player", self)


func behave() -> void:
	if not released:
		self.direction = player.global_position - self.global_position
		self.rotation = self.direction.angle()

	if not target_acquired:
		target_acquired = true
		tween.interpolate_property(
			$AimingShadow,
			"rect_scale",
			Vector2(1, 1),
			Vector2(1, 0),
			self.aiming_time, 
			Tween.TRANS_LINEAR, Tween.EASE_IN
		)
		tween.start()
		yield(get_tree().create_timer(self.aiming_time, false), "timeout")
		self.release()


func setup(shot: Shot) -> Projectile:
	.setup(shot)
	if shot is CDProjectileShot:
		self.speed = shot.speed
		self.aiming_time = shot.aiming_time

	return self


func release():
	released = true
	self.movement = self.direction.normalized() * self.speed
