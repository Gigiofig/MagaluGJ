extends AnimationPlayer

func _ready():
	play("FadeIn")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FadeOut":
		get_tree().change_scene("res://Scenes/VictoryScreen.tscn")
