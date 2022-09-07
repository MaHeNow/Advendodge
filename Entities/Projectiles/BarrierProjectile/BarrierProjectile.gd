class_name BarrierProjectile
extends Projectile

var warning_time: float = 1.5
var start_position: Vector2
var end_position: Vector2
var appearance_time: float = 1.0
var existence_time: float = 1.0
var length: float
var width: float
var destination: Vector2

onready var repeating_sprite: = $RepeatingSprite
onready var aiming_shadow: = $AimingShadow


func _ready():
	# set the repeating_sprite to the sprite variable to make it comply wtih the 
	# projectile interface 
	sprite = repeating_sprite
	width = repeating_sprite.region_rect.size.x
	sprite.region_rect.size = Vector2(width, length)
	
	# hitbox initiation
	if hitbox.shape is RectangleShape2D:
		hitbox.shape.extents = Vector2(width / 2, length / 2)
	
	# prepare starting position and destination for the appearence animation
	position = start_position - (end_position - start_position) / 2
	destination = position + (end_position - start_position)
	
	# explosion particles initiation
	# TODO:
	explosion_particles.process_material.emission_box_extents = Vector3(width / 2, length / 2, 1)
	# scale the amount of particles by the length of the barrier
	explosion_particles.amount *= length / 64
	
	# aiming shadow preparation
	aiming_shadow.rect_size = Vector2(width, length)
	aiming_shadow.rect_pivot_offset = Vector2(width / 2, length / 2)
	aiming_shadow.rect_position = -Vector2(width / 2, length / 2)
	
	# make the sprite invisible during the appearence of the aiming shadow
	sprite.visible = false
	
	# let the aiming shadow appear
	tween.interpolate_property(
		aiming_shadow,
		"rect_position",
		aiming_shadow.rect_position,
		Vector2(
			aiming_shadow.rect_position.x,
			aiming_shadow.rect_position.y - (destination - position).length()
		),
		appearance_time, 
		Tween.TRANS_LINEAR)
	tween.start()


func setup(shot: Shot) -> Projectile:
	.setup(shot)
	if shot is BarrierProjectileShot:
		start_position = ScreenSize.at_screen(shot.position)
		end_position = ScreenSize.at_screen(shot.end_position)
		existence_time = shot.existence_time
		appearance_time = shot.appearance_time
		warning_time = shot.warning_time
		length = (end_position - start_position).length() * 1.3
		rotation = PI / 2 + (end_position - start_position).angle()

	return self


func _on_Tween_tween_completed(object, key):
	# occurs after the aiming shadow appeared
	if key == ":rect_position":
		yield(get_tree().create_timer(warning_time, false), "timeout")
		sprite.visible = true
		tween.interpolate_property(self, "position", position, destination, appearance_time, 
		Tween.TRANS_LINEAR)
		tween.start()
	# occurs after the barrier appeared
	if key == ":position" and sprite.visible:
		aiming_shadow.visible = false
		yield(get_tree().create_timer(existence_time, false), "timeout")
		animation_player.play("disappear")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "disappear":
		queue_free()


func _on_ProjectileArea_collided_with_player(player):
	animation_player.stop()
	aiming_shadow.visible = false
	._on_ProjectileArea_collided_with_player(player)
