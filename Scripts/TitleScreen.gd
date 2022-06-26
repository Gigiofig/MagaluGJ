extends Node2D

var isAnimationFinished = false


func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_accept") and isAnimationFinished:
		get_tree().change_scene("res://Scenes/GameScene.tscn")

func _on_AnimationPlayer_animation_finished(anim_name):
	isAnimationFinished = true
