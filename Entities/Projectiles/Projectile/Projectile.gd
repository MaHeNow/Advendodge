class_name Projectile
extends KinematicBody2D
"""
This class is the foundation of all projectiles. To create a new projectile,
create a new inherited scene from the 'Projectile.tscn' together with a
NEW script. This script should extend the class 'Projectile' (this script).
Override the necessary functions below, create new variables and methods,
and design your projectile in the '2D View'.
"""

signal destroyed
signal request_player(projectile)

export var damage: int
export var points: float = 0.0

var collision_flag := false
var movement: Vector2
var buildup_time: float = 0
var cooldown_time: float = 0
var player: KinematicBody2D
var collided := false

onready var tween := $Tween
onready var explosion_particles := $ExplostionParticles
onready var center_position := $CenterPosition
onready var projectile_area: ProjectileArea = $ProjectileArea
onready var sprite = $Sprite
onready var hitbox: CollisionShape2D = $ProjectileArea/Hitbox
onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	"""
	Override this method to implement projectile initation when
	creating a new instance using '.instance()' (See Projectile_Handler).
	WARNING: This function cannot take in any arguments. 
	To initate a projectile with arguments use the 'setup()' function and
	call if after '.instance()'.
	"""
	pass


func setup(shot: Shot) -> Projectile:
	"""
	Override this method to implement projectile initiation with arguments.
	Initiate a shot somewhat like this: 
	"""
	buildup_time = shot.buildup_time
	cooldown_time = shot.cooldown_time
	if shot.position == Vector2.ZERO:
		position = ScreenSize.at_screen(create_random_position())
	else:
		position = ScreenSize.at_screen(shot.position)

	return self


func _physics_process(_delta) -> void:
	move_and_slide(movement)
	behave()


func _on_ProjectileArea_collided_with_player(_player):
	_player.on_projectile_collision(self)
	explosion_particles.emitting = true
	hitbox.set_deferred("disabled", true)
	sprite.visible = false
	collided = true
	yield(
		get_tree().create_timer(
			explosion_particles.get_lifetime() * 1.2,
			false
		),
		"timeout"
	)
	queue_free()


func _on_ProjectileArea_exited_game_area():
	if not collided:
		queue_free()
	emit_signal("destroyed")


func behave() -> void:
	"""
	Override this method to implement projectile behavior.
	"""
	pass


func request_player():
	emit_signal("request_player", self)


func create_random_position() -> Vector2:
	""" Returns a random position on the edge of the screen.
	"""
	var side := randi() % 4
	var x_ := 0.0
	var y_ := 0.0
	
	if side == 0: # top side
		#pos = Vector2(int(round(rand_range(-width, width))), -height)
		x_ = rand_range(-1, 1)
		y_ = -1.0
	elif side == 1: # right side
		#pos = Vector2(width, int(round(rand_range(-height, height))))
		x_ = 1.0
		y_ = rand_range(-1, 1)
	elif side == 2: # bottim side
		x_ = rand_range(-1, 1)
		y_ = 1.0
		#pos = Vector2(int(round(rand_range(-width, width))), height)
	else: # left side
		x_ = -1.0
		y_ = rand_range(-1, 1)
		#pos = Vector2(-width, int(round(rand_range(-height, height))))
		
	return Vector2(x_, y_)
