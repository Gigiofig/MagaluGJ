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
		if "Stone" in name:
			#
			$CollisionShape2D.shape = load("res://Objects/Colliders/altStoneCollision.tres")
			$Shadow.scale = Vector2(1.3, 0.8)
			$Shadow.position = Vector2(3, 18)
			$Sprite.scale = Vector2(2, 2)
			$Sprite.position = Vector2(0, -20)

func _on_Area2D_body_entered(body):
	if "Player" in body.name and !isDestroyed:
		body.inResourceArea = true
		body.resourceType = type
		body.resourceAreaCounter += 1
		body.currentResource.append(self)
		print(body.currentResource)

func _on_Area2D_body_exited(body):
	if "Player" in body.name:
		body.resourceAreaCounter -= 1
		body.currentResource.erase(self)
		if body.resourceAreaCounter < 1:
			body.inResourceArea = false
			body.resourceType = null
			body.currentResource = []
		print(body.currentResource)

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
#	get_owner().get_node("YSort/Player").currentResource.erase(self)
	get_parent().add_child(drop_instance)
	$Sprite.texture = brokenTexture
	$Sprite.material = null
	if type == "Wood":
		$Sprite.position = Vector2(0,137)
		$Shadow.scale = Vector2(0.3,0.3)
	else:
		$CollisionShape2D.queue_free()
		$AltCollisionShape2D.queue_free()
		$Shadow.queue_free()
	$Area2D.queue_free()
