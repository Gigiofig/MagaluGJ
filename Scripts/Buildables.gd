extends Node2D

onready var spriteObj = $Sprite
export (Texture) var builtTexture
export (Texture) var altTexture
export var isCampfire = false
export var isBridge = false
var isBuilt = false
export (PackedScene) var requirementsObj
export var requirements = [["Wood", 0],["Stone", 0],["RedFlower",0],["PinkFlower",0]]

func _ready():
	add_child(requirementsObj)
	requirementsObj.get_node("RockAmount").text = requirements[1][1]
	requirementsObj.get_node("WoodAmount").text = requirements[0][1]
	if !isCampfire:
		$Sprite.texture = altTexture

func Build():
	if !isBuilt:
		spriteObj.texture = builtTexture
		isBuilt = true
		if isCampfire:
			requirements = [["Wood", 0],["Stone", 0],["RedFlower",1],["PinkFlower",1]]
			requirementsObj.get_node("WoodnStone").visible = false
			requirementsObj.get_node("Flowers").visible = true
		if isBridge:
			$StaticBody2D/CollisionShape2D.disabled = true
			pass
	elif isBuilt and isCampfire:
		get_owner().get_node("CanvasLayer/Control").Potion_Built()
		isCampfire = false

func _on_Area2D_body_entered(body):
	if !isBuilt and "Player" in body.name:
		$Requirements.visible = true
		body.inBuildableArea = true
		body.currentBuildable = self
	if isBuilt and "Player" in body.name and isCampfire:
		$Requirements.visible = true
		body.inBuildableArea = true
		body.currentBuildable = self

func _on_Area2D_body_exited(body):
	if "Player" in body.name:
		$Requirements.visible = false
		body.inBuildableArea = false
		body.currentBuildable = null
