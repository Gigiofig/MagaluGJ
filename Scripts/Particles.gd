extends Node2D
onready var anim = $AnimatedSprite

func _ready():
	anim.frame = 0
	anim.play("default") 

func _on_AnimatedSprite_animation_finished():
	self.queue_free()
