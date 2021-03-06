extends KinematicBody2D

onready var animPlayer = $AnimationPlayer
onready var slider = get_owner().get_node("CanvasLayer/Control/Panel3/Progress")
export var MAX_SPEED = 200
export var ACCELERATION = 2000
var canPlay = true
var currentAnim = ""
var inBuildableArea = false
var inResourceArea = false
var inHouseArea = false
var resourceAreaCounter = 0
var currentBuildable = null
var currentResource = []
var resourceType = null
var motion = Vector2(0,0)
var canMove = true
var maxResources = 20
var hasPotion = false
var resources = [["Wood", 0],["Stone", 0],["RedFlower",0],["PinkFlower",0]]
var time = 100

signal WoodCollected
signal StoneCollected
signal RedFlowerCollected
signal PinkFlowerCollected

#Movement Start
func _physics_process(delta):
	if $Hit.is_playing():
		if currentResource != []:
			currentResource.back().Shake(str(resourceType))
	time -= delta
	slider.value = time 
	if time > 100:
		time = 100
	if time <= 0:
		get_owner().get_node("AnimationPlayer").play("FadeOut")
	var axis = get_input_axis()
	if Input.is_action_just_pressed("ui_select") and inResourceArea:
		canMove = false
		motion = Vector2.ZERO
		AnimationPlay("collect" + str(resourceType))
		yield(animPlayer, "animation_finished")
		canMove = true
	elif Input.is_action_just_pressed("ui_select") and inBuildableArea and (!currentBuildable.isBuilt or currentBuildable.isCampfire):
		var counter = 0
		for i in range(resources.size()):
			if resources[i][1] >= currentBuildable.requirements[i][1]:
				counter += 1
		if counter == 4:
			canMove = false
			motion = Vector2.ZERO
			resources[0][1] -= currentBuildable.requirements[0][1]
			resources[1][1] -= currentBuildable.requirements[1][1]
			resources[2][1] -= currentBuildable.requirements[2][1]
			resources[3][1] -= currentBuildable.requirements[3][1]
			emit_signal("StoneCollected")
			emit_signal("WoodCollected")
			if currentBuildable.isBridge:
				currentBuildable.Build()
				AnimationPlay("collectStone")
				yield(animPlayer, "animation_finished")
				AnimationPlay("build")
				yield(animPlayer, "animation_finished")
			elif !currentBuildable.isBuilt or currentBuildable.isCampfire:
				AnimationPlay("build")
				yield(animPlayer, "animation_finished")
				currentBuildable.Build()
			canMove = true
			
	elif Input.is_action_just_pressed("ui_select") and inHouseArea:
		if hasPotion:
			#Acaba o jogo
			canMove = false
			motion = Vector2.ZERO
			get_owner().get_node("AnimationPlayer").hasWon = true
			get_owner().get_node("AnimationPlayer").play("FadeOut")
			
	elif axis == Vector2.ZERO:
		AnimationPlay("idle")
	elif axis.x > 0 and canPlay:
		AnimationPlay("walkH")
		$Sprite.flip_h = true
	elif axis.x < 0 and canPlay:
		AnimationPlay("walkH")
		$Sprite.flip_h = false
	elif axis.y > 0:
		AnimationPlay("walkH")
	elif axis.y < 0:
		AnimationPlay("walkH")
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta) 
	else:
		apply_movement(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)
func apply_movement(acceleration):
	if canMove:
		motion += acceleration
		motion = motion.clamped(MAX_SPEED)
func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()
func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO
#Movement End

#Animation Controller
func AnimationPlay(animation):
	if ("collect" in animation or animation == "build") and canPlay:
		canPlay = false
#		if currentResource != []:
#			currentResource.back().Shake(str(resourceType))
		animPlayer.play(animation)
		currentAnim = animation
		yield(animPlayer, "animation_finished")
		canPlay = true
	elif canPlay:
		currentAnim = animation
		animPlayer.play(animation)

#Resource Collection
func _on_AnimationPlayer_animation_finished(anim_name):
	if "collect" in anim_name and currentResource != []:
		currentResource.back().IncreaseCounter()
		if "Wood" in anim_name:
			time += 5
		

func Collect(index, type, object):
	$Collect.play()
	if resources[index][1] < maxResources: 
		resources[index][1] += 1
		emit_signal(type + "Collected")
		object.queue_free()
