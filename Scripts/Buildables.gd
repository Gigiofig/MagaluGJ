extends Node2D

onready var spriteObj = $Sprite
onready var requirementsObj = $Requirement
var isBuilt = false
var tween
var targetPanel
export (Texture) var builtTexture
export (Texture) var altTexture
export var isCampfire = false
export var isBridge = false
export var requirements = [["Wood", 0],["Stone", 0],["RedFlower",0],["PinkFlower",0]]
export var spriteArray = []
export var vertical = false


func _ready():
	targetPanel = $Requirement/WoodnStone
	tween = $Requirement/Tween
	$Requirement/WoodnStone/HBoxContainer/TextureRec2/RockAmount.text = str(requirements[1][1])
	$Requirement/WoodnStone/HBoxContainer/TextureRec/WoodAmount.text = str(requirements[0][1])
	if !isCampfire:
		$Sprite.texture = altTexture

func Build():
	if !isBuilt:
		spriteObj.texture = builtTexture
		isBuilt = true
		if isCampfire:
			requirements = [["Wood", 0],["Stone", 0],["RedFlower",1],["PinkFlower",1]]
			targetPanel = $Requirement/Flowers
			$Requirement/WoodnStone.visible = false
			$Requirement/Flowers.visible = true
		if isBridge:
			$StaticBody2D/CollisionShape2D.disabled = true
			for i in get_children():
				if "Built" in i.name:
					i.visible = true
				else:
					i.visible = false
			spriteObj.visible = true
			if vertical:
				position.y -= 230
				$StaticBody2D2/CollisionShape2D.disabled = false
				$StaticBody2D3/CollisionShape2D.disabled = false
				spriteObj.visible = false
				
			
	elif isBuilt and isCampfire:
		get_owner().get_node("CanvasLayer/Control").Potion_Built()
		isCampfire = false

func TweenIn():
	tween.interpolate_property(targetPanel,"rect_scale",Vector2(0.7,0.7),Vector2(1,1),0.5,Tween.TRANS_QUART,Tween.EASE_IN_OUT)
	tween.start()

func TweenOut():
	tween.interpolate_property(targetPanel,"rect_scale",Vector2(1,1),Vector2(0.3,0.3),0.5,Tween.TRANS_QUART,Tween.EASE_IN_OUT)
	tween.start()

func _on_Area2D_body_entered(body):
	if !isBuilt and "Player" in body.name:
		$Requirement.visible = true
		TweenIn()
		body.inBuildableArea = true
		body.currentBuildable = self
	if isBuilt and "Player" in body.name and isCampfire:
		$Requirement.visible = true
		TweenIn()
		body.inBuildableArea = true
		body.currentBuildable = self

func _on_Area2D_body_exited(body):
	if "Player" in body.name:
		TweenOut()
		$Requirement.visible = false
		body.inBuildableArea = false
		body.currentBuildable = null
