class_name PillarProjectile
extends Projectile

var speed: float = 1
var height: float = 1

onready var static_sprite := $UnanimatedSprite


func _ready():
	sprite = static_sprite
	if position.x > 0:
		movement = Vector2.LEFT * speed
	else:
		movement = Vector2.RIGHT * speed
	var sprite_height = sprite.region_rect.size.y * height
	if position.y < 0:
		sprite.rotation_degrees = 180
		explosion_particles.position.y *= -height
		center_position.position = Vector2(0, sprite_height / 2)
	else:
		explosion_particles.position.y *= height
		center_position.position = Vector2(0, -sprite_height / 2)
	explosion_particles.position.y *= height
	sprite.region_rect.size.y = sprite_height
	sprite.offset.y = -sprite_height / 2
	if hitbox.shape is RectangleShape2D:
		hitbox.shape.extents.y = sprite_height
	explosion_particles.process_material.emission_box_extents = Vector3(
		hitbox.shape.extents.x,
		hitbox.shape.extents.y / 2,
		1
	)


func setup(shot: Shot) -> Projectile:
	.setup(shot)
	randomize()
	if shot is PillarProjectileShot:
		var position_vector := Vector2(ScreenSize.game_size.x, ScreenSize.room_size_extent)
		var pos := shot.position
		if pos == Vector2.ZERO:
			pos = create_random_position()
		elif pos.x == 0:
			pos.x = 1 if round(randf()) >= 0.5 else -1
		elif pos.y == 0:
			pos.y = 1 if round(randf()) >= 0.5 else -1
		position = Vector2(pos.x * position_vector.x, pos.y * position_vector.y)
		height = shot.height
		if height == 0:
			height = 0.125 * (randi() % 7 + 2)
		speed = shot.speed

	return self


func create_random_position() -> Vector2:
	randomize()
	var side := randi() % 4
	var x_ := 0.0
	var y_ := 0.0
	
	if side == 0: # top left
		x_ = -1.0
		y_ = -1.0
	elif side == 1: # top right
		x_ = 1.0
		y_ = -1.0
	elif side == 2: # bot left
		x_ = -1.0
		y_ = 1.0
	else: # bot right
		x_ = 1.0
		y_ = 1.0

	return Vector2(x_, y_)
