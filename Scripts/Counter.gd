extends Control

onready var playerNode = get_owner().get_node("YSort/Player")
export (Texture) var tex

# Called when the node enters the scene tree for the first time.
func _ready():
	playerNode.connect("StoneCollected", self, "on_Stone_Collected")
	playerNode.connect("WoodCollected", self, "on_Wood_Collected")
	playerNode.connect("RedFlowerCollected", self, "on_RedFlower_Collected")
	playerNode.connect("PinkFlowerCollected", self, "on_PinkFlower_Collected")


func on_Wood_Collected():
	$HBoxContainer/WoodCounter.text = str(playerNode.resources[0][1])

func on_Stone_Collected():
	$HBoxContainer/StoneCounter.text = str(playerNode.resources[1][1])

func on_RedFlower_Collected():
	$Panel2.visible = true
	$HBoxContainer/RedFlowerTexture.visible = true

func on_PinkFlower_Collected():
	$Panel2.visible = true
	$HBoxContainer/PinkFlowerTexture.visible = true
	
func Potion_Built():
	$HBoxContainer/RedFlowerTexture.visible = false
	$HBoxContainer/PinkFlowerTexture.visible = false
	$HBoxContainer/PotionTexture.visible = true
	playerNode.hasPotion = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
