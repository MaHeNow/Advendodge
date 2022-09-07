class_name Player
extends KinematicBody2D

signal got_hit_by(projectile)
signal got_points(points)

var character: Character setget set_character
var max_health := 100.0
var min_speed := 10.0
var acceleration := 30.0
var friction := 0.82
var hit_stun_time := 1.0
var motion := Vector2()
var blocked := false
var hit_stun := false

onready var tween: Tween = $Tween
onready var sprite: Sprite = $Sprite
onready var hit_sphere: CollisionShape2D = $HitSphere
onready var score_module = $ScoreModule


func _input(event: InputEvent) -> void:
	if not blocked:
		if event is InputEventScreenDrag:
			update_motion(event.relative)


func _physics_process(_delta: float) -> void:
	apply_friction()
	move_and_slide(motion)


func on_projectile_collision(projectile):
	emit_signal("got_hit_by", projectile)
	hit_stun = true
	yield(get_tree().create_timer(hit_stun_time, false), "timeout")
	hit_stun = false


func set_character(character_: Character):
	character = character_
	sprite.texture = character_.texture
	sprite.offset = character_.texture_offset
	hit_sphere.shape = character_.shape
	max_health = character_.max_health
	min_speed = character_.min_speed
	acceleration = character_.acceleration
	friction = character_.friction


func apply_friction() -> void:
	self.motion *= friction
	if self.motion.length() < min_speed:
		self.motion = Vector2(0,0)


func update_motion(direction : Vector2) -> void:
	self.motion += direction * self.acceleration


func move_to(new_global_position: Vector2, time: float) -> void:
	self.motion = Vector2(0, 0)
	block()
	tween.interpolate_property(
		self,
		"global_position",
		global_position, 
		new_global_position,
		time,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN_OUT
	)
	tween.start()


func block():
	blocked = true


func unblock():
	blocked = false


func _on_Tween_tween_completed(object, key):
	if key == ":global_position":
		unblock()


func _on_ScoreModule_got_points(points):
	emit_signal("got_points", points)
