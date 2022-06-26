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
	if playerNode.resources[0][1] < 10:
		$HBoxContainer/WoodCounter.text = "0" + str(playerNode.resources[0][1])
	else:
		$HBoxContainer/WoodCounter.text = str(playerNode.resources[0][1])

func on_Stone_Collected():
	if playerNode.resources[1][1] < 10:
		$HBoxContainer/StoneCounter.text = "0" + str(playerNode.resources[1][1])
	else:
		$HBoxContainer/StoneCounter.text = str(playerNode.resources[1][1])

func on_RedFlower_Collected():
	$Panel2.visible = true
	$HBoxContainer2/RedFlowerTexture.visible = true

func on_PinkFlower_Collected():
	$Panel2.visible = true
	$HBoxContainer2/PinkFlowerTexture.visible = true
	
func Potion_Built():
	$HBoxContainer2/RedFlowerTexture.visible = false
	$HBoxContainer2/PinkFlowerTexture.visible = false
	$Panel2/PotionTexture.visible = true
	playerNode.hasPotion = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
