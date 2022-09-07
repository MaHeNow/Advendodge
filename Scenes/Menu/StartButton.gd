extends Button

export var character: Resource


func _on_Button_pressed():
	var session: Session = Session.new()
	session.character = character
	SceneTransitioner.transition_to_gameplay(session)
