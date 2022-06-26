extends Button

export var reference_path = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	match reference_path:
		"Play":
			get_owner().get_node("AnimationPlayer").play("StartGame")
		"Replay":
			get_tree().change_scene("res://Scenes/TitleScreen.tscn")
		"Credits":
			get_tree().change_scene("res://Scenes/TitleScreen.tscn")
		"Quit":
			get_tree().quit()
