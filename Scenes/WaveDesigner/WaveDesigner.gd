tool
extends Node2D

signal done_shooting

export var wave: Resource

var initial_shoot := false
var warning_sign_scene := preload("res://Entities/WarningSign/WarningSign.tscn")

onready var player: Player = $Player
onready var projectile_container: Node2D = $ProjectileContainer


func _ready():
	ScreenSize.set_offset(Vector2(0, -40))
	shoot()


func shoot():
	if wave is Wave:
		var attacks: Array = wave.attacks
		for attack in attacks:
			if attack is Attack:
				var shots: Array = attack.shots
				for shot in shots:
					var projectile: Projectile = shot.projectile_scene.instance()
					projectile.setup(shot)
					projectile.connect("destroyed", self, "_on_projectile_destroyed")
					projectile.connect("request_player", self, "_on_projectile_request_player")
					var warning_sign_extra_time: float = 0
					if shot.warning:
						var warning_sing: WarningSign = create_warning_sign(shot.position)
						warning_sign_extra_time = warning_sing.appearence_durration
						yield(get_tree().create_timer(warning_sing.appearence_durration, false),"timeout")
					yield(get_tree().create_timer(projectile.buildup_time, false),"timeout")
					projectile_container.add_child(projectile)
					yield(get_tree().create_timer(projectile.cooldown_time  - warning_sign_extra_time, false),"timeout")
				yield(get_tree().create_timer(attack.cooldown_time, false),"timeout")
	for i in projectile_container.get_children():
		i.queue_free()
	emit_signal("done_shooting")


func create_warning_sign(position_: Vector2):
	var warning_sign: WarningSign = warning_sign_scene.instance()
	warning_sign.setup(position_)
	add_child(warning_sign)

	return warning_sign


func _on_projectile_request_player(projectile: Projectile):
	projectile.set_player(player)
