extends Node

var game_scene: PackedScene = load("res://Scenes/Gameplay/Gameplay.tscn")
var score_scene: PackedScene = load("res://Scenes/Menu/DebugMenu.tscn")
var menu_scene: PackedScene = load("res://Scenes/Menu/DebugMenu.tscn")
var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)


func transition_to_gameplay(current_session: Session):
	current_scene.queue_free()
	
	current_scene = game_scene.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
	
	if current_scene is Gameplay:
		current_scene.session = current_session


func transition_main_menu():
	call_deferred("transition_main_menu_deffered")


func transition_main_menu_deffered():
	current_scene.free()
	current_scene = menu_scene.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	get_tree().change_scene_to(menu_scene)
