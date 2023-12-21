extends Node3D

# get node of left controller on the table
@onready var snapped_left = get_node("../controller_left")

# get node of hand model
@onready var hand_left = get_node("../../player - origin/Left - controller/LeftHand - model")

# get node of controller on left hand
@onready var controller_onLeft = get_node("../../player - origin/Left - controller/controller_left")

# get nodes of left stick and player movement
@onready var movingFunction = controller_onLeft.get_node("../MovementDirect")
@onready var leftJoystick = controller_onLeft.get_node("joystick_origin")

# this variable is to cancel out a bug that picks up the controller when game started
var offset_left = 0

func _ready():
	pass

func _process(delta):
	pass

func _on_ctrllr_left__pickable_object_2_picked_up(pickable):
	if(offset_left == 2): # sets offset back to 1 for next time picked up
		offset_left = 1
	elif(offset_left == 1): # if picked up
		snapped_left.visible = false
		hand_left.visible = false
		controller_onLeft.visible = true
		leftJoystick.enabled = true
		movingFunction.enabled = false
		offset_left = 2
	else: # fixes said bug
		offset_left = 1

func _on_ctrllr_left__pickable_object_dropped(pickable):
	pass
