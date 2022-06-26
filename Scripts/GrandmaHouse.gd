extends StaticBody2D


func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.inHouseArea = true
		$Requirements.visible = true


func _on_Area2D_body_exited(body):
	if "Player" in body.name:
		body.inHouseArea = false
		$Requirements.visible = false
