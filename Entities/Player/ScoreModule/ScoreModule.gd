class_name ScoreModule
extends Area2D

signal got_points(points)

export var line_color := Color(1.0, 1.0, 1.0, 1.0)
var near_projectiles := []
onready var connection_sphere: CircleShape2D = $ConnectionArea.shape


func _physics_process(_delta) -> void:
	# needed for the _draw() function
	update()


func _draw():
	for p in near_projectiles:
		var line_position = p.center_position.global_position - self.global_position
		var color_ = line_color
		color_.a = connection_sphere.radius / line_position.length()
		draw_line(
			Vector2(0, 0),
			line_position,
			color_,
			connection_sphere.radius / line_position.length()
		)
		# send signal for the game to know
		emit_signal("got_points", p.points / line_position.length())


func _on_ScoreModule_area_entered(area):
	if area is ProjectileArea:
		var projectile = area.parent_projectile
		if not near_projectiles.has(projectile):
			near_projectiles.append(projectile)


func _on_ScoreModule_area_exited(area):
	if area is ProjectileArea:
		var projectile = area.parent_projectile
		near_projectiles.erase(projectile)
