class_name Gameplay
extends Control

signal paused
signal ended(score)

export var character: Resource
export var touch_area_data: Resource 

var session: Session setget set_session
var counting_score := true
var registered_death := false
var last_difficulty_increase_score := 0
var difficulty_increase_step := 20

onready var game_center: Position2D = $GameCenter
onready var game_camera: Camera2D = $GameCamera
onready var projectile_handler: ProjectileHandler = $GameCenter/ProjectileHandler
onready var touch_area: Node2D = $GameCamera/ForegroundLayer/Anchor/TouchAreaUI
onready var room: GameRoom = $GameCenter/Room
onready var background_display: = $GameCamera/BackgroundLayer/Anchor/BackgroundDisplay
onready var health_bar: HealthBar = $GameCamera/ForegroundLayer/Anchor/HealthBar
onready var pause_button: Button = $GameCamera/ForegroundLayer/Anchor/PauseButton
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var score_label: RichTextLabel = $GameCamera/ForegroundLayer/Anchor/ScoerLabel
onready var tween: Tween = $Tween
onready var player: Player
onready var player_scene: = preload("res://Entities/Player/Player.tscn")
onready var room_scene: = preload("res://Entities/Room/Room.tscn")


func _ready():
	ScreenSize.set_offset(game_center.position)
	touch_area.set_touch_area(touch_area_data)
	room.connect("appeared", self, "spawn_player")


func appear():
	animation_player.play("appear")
	room.animation_player.play("appear")


func set_session(session_):
	session = session_
	session.connect("health_changed", self, "_on_session_health_changed")
	session.connect("points_changed", self, "_on_points_changed")
	health_bar.session = session
	character = session.character


func spawn_player():
	if character is Character:
		player = player_scene.instance()
		player.connect("got_hit_by", self, "_on_player_got_hit_by")
		player.connect("got_points", self, "_on_player_got_points")
		game_center.add_child(player)
		player.character = character
	projectile_handler.setup(player)
	projectile_handler.start_shooting()


func _on_player_got_hit_by(projectile):
	if projectile is Projectile:
		session.current_health -= projectile.damage
	game_camera.regular_shake()


func _on_session_health_changed(changed_health: float):
	if session.current_health <= 0 and not registered_death:
		pause_button.disabled = true
		counting_score = false
		registered_death = true
		tween.interpolate_property(
			Engine,
			"time_scale",
			1.0, 
			0.01,
			0.25,
			Tween.TRANS_QUAD,
			Tween.EASE_OUT
		)
		tween.start()


func _on_PauseButton_pressed():
	emit_signal("paused")


func _on_player_got_points(points):
	if counting_score:
		session.number_points += points
		if session.current_health < player.max_health and not player.hit_stun:
			session.current_health += points
			if session.current_health > player.max_health:
				session.current_health = player.max_health
	var current_points := int(session.number_points)
	if current_points % difficulty_increase_step == 0 and last_difficulty_increase_score != current_points:
		last_difficulty_increase_score = current_points
		projectile_handler.increase_difficulty()


func _on_points_changed(points):
	var message = "	[center]{score}[/center]"
	score_label.parse_bbcode(
		message.format({"score": str(int(points))})
	)


func _on_Tween_tween_completed(object, key):
	if object == Engine and key == ":time_scale":
		Engine.time_scale = 1.0
		emit_signal("ended", session.number_points)
