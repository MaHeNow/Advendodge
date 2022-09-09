tool
class_name BackgroundDisplay
extends Node2D

export var background : ShaderMaterial
onready var texture: Sprite = $Texture


func _ready():
	set_background(self.background)


func set_background(new_background: Background):
	background = new_background
	if new_background is Background:
		texture.texture = background.texture
		self.material = background
		self.modulate = Color(1, 1, 1, background.alpha)
	else:
		texture.texture = null
		self.material = null
