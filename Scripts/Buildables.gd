extends Node2D

onready var spriteObj = $Sprite
export (Texture) var builtTexture
export (Texture) var altTexture
export var isCampfire = false
var isBuilt = false
export var requirements = [["Wood", 0],["Stone", 0],["RedFlower",0],["PinkFlower",0]]

func Build():
	if !isBuilt:
		spriteObj.texture = builtTexture
		if isCampfire:
			requirements = [["Wood", 0],["Stone", 0],["RedFlower",1],["PinkFlower",1]]
			$Requirements.texture = altTexture
	if isBuilt and isCampfire:
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
