class_name ProjectileHandler
extends Node2D

var player: Player = null
var projectiles_destroyed := 0
var warning_sign_scene := preload("res://Entities/WarningSign/WarningSign.tscn")
var shooting := true
var difficulty := 0
var attacks := generate_new_attacks()

onready var timer_container := $TimerContainer
onready var projectile_container := $ProjectileContainer


func increase_difficulty():
	difficulty += 1
	attacks = generate_new_attacks()


func generate_new_attacks() -> Array:
	return [
		PillarAttack.new(difficulty),
		HomingAttack.new(difficulty),
		CdSpearAttack.new(difficulty),
		BarrierAttack.new(difficulty),
		RotatingParaboleAttack.new(),
		LinearAimedAttack.new(difficulty),
		LinearAimedAttackSingleCorner.new(difficulty),
		LinearAttack.new(difficulty),
		SinusAttack.new(difficulty),
	]


func setup(player_: Player):
	player = player_


func start_shooting():
	attacks = generate_new_attacks()
	attacks.shuffle()
	for attack in attacks:
		if attack is Attack:
			var shots: Array = attack.shots
			for i in shots.size():
				var shot = shots[i]
				var next_shot = shots[i+1] if i+1 < shots.size() else null
				var projectile: Projectile = shot.projectile_scene.instance()
				projectile.setup(shot)
				projectile.connect("destroyed", self, "_on_projectile_destroyed")
				projectile.connect("request_player", self, "_on_projectile_request_player")
				if shot.warning:
					var warning_sing: WarningSign = create_warning_sign(projectile.position / ScreenSize.game_size)
					yield(get_tree().create_timer(warning_sing.appearence_durration, false), "timeout")
				yield(get_tree().create_timer(projectile.buildup_time, false),"timeout")
				projectile_container.add_child(projectile)
				var warning_sign_extra_time: float = 0
				if next_shot and next_shot is Shot:
					if next_shot.warning:
						warning_sign_extra_time = warning_sign_scene.instance().appearence_durration
				yield(get_tree().create_timer(projectile.cooldown_time - warning_sign_extra_time, false),"timeout")
			yield(get_tree().create_timer(attack.cooldown_time, false),"timeout")

	if shooting:
		start_shooting()

					
func create_warning_sign(position_: Vector2):
	var warning_sign: WarningSign = warning_sign_scene.instance()
	warning_sign.setup(position_)
	add_child(warning_sign)
	return warning_sign


func _on_projectile_destroyed():
	projectiles_destroyed += 1


func _on_projectile_request_player(projectile: Projectile):
	projectile.player = player


func get_random_attack() -> Attack:
	randomize()
	var attacks = [
		PillarAttack.new(),
		HomingAttack.new(),
		CdSpearAttack.new(),
		BarrierAttack.new(),
		RotatingParaboleAttack.new(),
		LinearAimedAttack.new(),
		LinearAimedAttackSingleCorner.new(),
		LinearAttack.new(),
		SinusAttack.new(),
		WallBounceAttack.new()
	]
	var random_index = randi() % attacks.size()

	return attacks[random_index]
