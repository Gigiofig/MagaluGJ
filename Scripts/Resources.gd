extends Node2D

export var type = ""
export (Texture) var texture
export (PackedScene) var drop
var counter = 0
export var maxCounter = 1
# Called when the node enters the scene tree for the first time.

func _ready():
	$Sprite.texture = texture

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.inResourceArea = true
		body.resourceType = type
		body.resourceAreaCounter += 1
		body.currentResource.append(self)

func _on_Area2D_body_exited(body):
	if "Player" in body.name:
		body.resourceAreaCounter -= 1
		body.currentResource.erase(self)
		if body.resourceAreaCounter < 1:
			body.inResourceArea = false
			body.resourceType = null
			body.currentResource = []

func IncreaseCounter():
	counter += 1
	if counter >= maxCounter:
		Destroy(type)

func Destroy(resourceType):
	var drop_instance = drop.instance()
	drop_instance.type = resourceType
	if type == "Wood":
		drop_instance.index = 0
	elif type == "Stone":
		drop_instance.index = 1
	drop_instance.position = position
	get_owner().get_node("Player").currentResource.erase(self)
	print(get_owner().get_node("Player").currentResource.erase(self))
	get_parent().add_child(drop_instance)
	queue_free()
