extends Node2D

export var type = ""
export var index = 0


func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.Collect(index, type, self)
