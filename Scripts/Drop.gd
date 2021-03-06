extends Node2D

export var type = ""
export var index = 0
export (Texture) var dropTex
onready var tween = $Tween


func _ready():
	if "Flower" in type:
		$Sprite.texture = dropTex
	else:
		var pos = Vector2(rand_range(-50, 50), 0)
		position += pos
		tween.interpolate_property(self,"position", position, position + Vector2(0,50), 1,Tween.TRANS_BOUNCE,Tween.EASE_OUT)
		tween.start()
		yield(get_tree().create_timer(1.2), "timeout")
	$Area2D/CollisionShape2D.disabled = false
	


func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.Collect(index, type, self)
