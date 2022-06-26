extends Node2D

export var type = ""
export (Texture) var altTexture
export (Texture) var brokenTexture
export (PackedScene) var drop
var counter = 0
var isDestroyed = false
export var maxCounter = 1
# Called when the node enters the scene tree for the first time.

func _ready():
	if altTexture != null:
		$Sprite.texture = altTexture

func _on_Area2D_body_entered(body):
	if "Player" in body.name and !isDestroyed:
		body.inResourceArea = true
		body.resourceType = type
		body.resourceAreaCounter += 1
		body.currentResource.append(self)

func _on_Area2D_body_exited(body):
	if "Player" in body.name and !isDestroyed:
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
	isDestroyed = true
	if type == "Wood":
		drop_instance.index = 0
	elif type == "Stone":
		drop_instance.index = 1
	drop_instance.position = position - Vector2(0,20)
	get_owner().get_node("YSort/Player").currentResource.erase(self)
	print(get_owner().get_node("YSort/Player").currentResource.erase(self))
	get_parent().add_child(drop_instance)
	$Sprite.texture = brokenTexture
	$Sprite.material = null
	if type == "Wood":
		$Sprite.position = Vector2(0,137)
		$Shadow.scale = Vector2(0.3,0.3)
	else:
		$CollisionShape2D.queue_free()
		$Shadow.queue_free()
