class_name TitleScreen
extends Control

signal disappeared

var ready_for_transition: = false
var disappeared: = false

onready var animation_player: AnimationPlayer = $LogoCenter/AnimationPlayer
onready var highscore_label: RichTextLabel = $HighscoreLabel


func _ready():
	# setup disappear animation 
	var anim := animation_player.get_animation("disappear")


func _input(event):
	if event is InputEventScreenTouch and ready_for_transition and not disappeared:
		disappeared = true
		animation_player.play("disappear")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "disappear":
		emit_signal("disappeared")
	if anim_name == "appear":
		ready_for_transition = true


func set_highscore(score):
	var message := ""
	if score > 0:
		message = "\n[center]Highscore: {score}[/center]".format({"score": int(score)})
	highscore_label.parse_bbcode(message)
