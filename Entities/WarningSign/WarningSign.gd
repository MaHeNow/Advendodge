extends Position2D
class_name WarningSign

export var distance_horitontal: float = 20
export var distance_vetical: float = 45
export var appearence_durration: float = 1

var setup_position: Vector2
var destination: Vector2

onready var sprite_top: = $BoxTop
onready var sprite_right: = $BoxRight
onready var sprite_bot: = $BoxBot
onready var sprite_left: = $BoxLeft
onready var tween: = $Tween
onready var animation_player: = $AnimationPlayer


func _ready():
	sprite_bot.visible = false
	position = setup_position * ScreenSize.game_size
	if abs(setup_position.x) > abs(setup_position.y):
		if setup_position.x > 0:
			sprite_right.visible = true
			destination = position - Vector2(distance_horitontal, 0)
			position += Vector2(distance_horitontal, 0)
		else:
			sprite_left.visible = true
			destination = position + Vector2(distance_horitontal, 0)
			position -= Vector2(distance_horitontal, 0)
	else:
		if setup_position.y > 0:
			sprite_bot.visible = true
			destination = position - Vector2(0, distance_vetical)
			position += Vector2(0, distance_vetical)
		else:
			sprite_top.visible = true
			destination = position + Vector2(0, distance_vetical)
			position -= Vector2(0, distance_vetical)
	
	tween.interpolate_property(self, "position", position, destination, appearence_durration, 
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()


func setup(position_: Vector2):
	setup_position = position_


func _on_Tween_tween_completed(object, key):
	if key == ":position":
		animation_player.play("disappear")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "disappear":
		queue_free()
