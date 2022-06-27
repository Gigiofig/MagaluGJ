extends Node2D

var isAnimationFinished = false

func _input(event):
	if event.is_action_pressed("ui_accept") and isAnimationFinished:
		$AnimationPlayer.play("PlayGame")

func _on_AnimationPlayer_animation_finished(anim_name):
	isAnimationFinished = true
	if anim_name == "StartGame":
		$AnimationPlayer.play("PressToStart")
	if anim_name == "PlayGame":
		get_tree().change_scene("res://Scenes/GameScene.tscn")
