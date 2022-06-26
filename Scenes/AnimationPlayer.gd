extends AnimationPlayer

var hasWon = false

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FadeOut" and hasWon:
		get_tree().change_scene("res://Scenes/VictoryScreen.tscn")
	elif anim_name == "FadeOut" and !hasWon:
		get_tree().change_scene("res://Scenes/GameOver.tscn")
