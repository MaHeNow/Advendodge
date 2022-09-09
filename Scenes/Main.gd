extends Control

export var character: Resource

var save_folder: = "user://save_states"
var save_file_name: = "save_state.tres"

onready var gameplay: Gameplay = $Gameplay
onready var titlescreen: TitleScreen = $TitleScreen
onready var pause_menu: PauseMenu = $MenuLayer/PauseMenu
onready var death_menu: DeathMenu = $MenuLayer/DeathMenu
onready var gameplay_scene: PackedScene = preload("res://Scenes/Gameplay/Gameplay.tscn")


func _ready():
	var highscore = load_highscore()
	titlescreen.set_highscore(highscore)


func restart_gameplay():
	# Unpause the game
	get_tree().paused = false
	gameplay.queue_free()
	
	# Create a new session
	var session: Session = Session.new()
	session.character = character
	
	# Create a new gameplay object, add it to the scene and replace the old one
	var new_gameplay = gameplay_scene.instance()
	gameplay = new_gameplay
	gameplay.connect("ended", self, "_on_Gameplay_ended")
	gameplay.connect("paused", self, "_on_Gameplay_paused")
	add_child(gameplay)
	gameplay.session = session
	gameplay.appear()


func _on_TitleScreen_disappeared():
	var session: Session = Session.new()
	session.character = character
	gameplay.session = session
	gameplay.appear()
	titlescreen.queue_free()


func _on_Gameplay_paused():
	get_tree().paused = true
	pause_menu.appear()


func _on_PauseMenu_resume():
	get_tree().paused = false
	pause_menu.disappear()


func _on_PauseMenu_restart():
	pause_menu.disappear()
	restart_gameplay()


func _on_Gameplay_ended(score):
	get_tree().paused = true
	var current_highscore = load_highscore()
	var got_new_highscore: bool = score > current_highscore
	death_menu.appear(score, got_new_highscore, current_highscore)
	if got_new_highscore:
		save_highscore(score)


func _on_DeathMenu_restart():
	death_menu.disappear()
	restart_gameplay()


func save_highscore(points: int):
	var save_state := SaveState.new()
	save_state.highscore = points
	
	var directory := Directory.new()
	if not directory.dir_exists(save_folder):
		directory.make_dir_recursive(save_folder)
		
	var save_path = save_folder.plus_file(save_file_name)
	var error := ResourceSaver.save(save_path, save_state)
	
	
func load_highscore(): 
	var save_file_path: String = save_folder.plus_file(save_file_name)
	var file: File = File.new()
	if not file.file_exists(save_file_path):
		print("Save file as doesn´t exists")
		return 0 
	
	var save_state: SaveState = load(save_file_path)

	return save_state.highscore 
	
