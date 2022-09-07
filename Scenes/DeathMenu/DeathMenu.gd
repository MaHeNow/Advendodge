class_name DeathMenu
extends Node

signal restart

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var score_label: RichTextLabel = $Panel/ScoreLabel
onready var highscore_label: RichTextLabel = $Panel/HighscoreLabel


func appear(score, got_new_highscore: bool, highscore):
	animation_player.play("appear")
	if got_new_highscore:
		score_label.parse_bbcode(
			""
			)
		highscore_label.parse_bbcode(
			"\n[center][tornado radius=2 freq=4][rainbow freq=1.1 sat=3 val=10]NEW[/rainbow][/tornado] Highscore: {score}[/center]".format({"score": int(score)})
			)
	else:
		score_label.parse_bbcode(
			"\n[center]Score: {score}[/center]".format({"score": int(score)})
			)
		highscore_label.parse_bbcode(
			"\n[center]Highscore: {score}[/center]".format({"score": int(highscore)})
			)


func disappear():
	animation_player.play("disappear")


func _on_RestartButton_pressed():
	emit_signal("restart")
