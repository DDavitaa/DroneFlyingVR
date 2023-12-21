extends Node3D

# get node of left controller on the table
@onready var snapped_right = get_node("../controller_right")

# get node of hand model
@onready var hand_right = get_node("../../player - origin/Right - controller/RightHand - model")

# get node of controller on left hand
@onready var controller_onRight = get_node("../../player - origin/Right - controller/controller_right")

# get nodes of right stick and player rotation
@onready var turningFunction = controller_onRight.get_node("../MovementTurn")
@onready var rightJoystick = controller_onRight.get_node("joystick_origin")

# this variable is to cancel out a bug that picks up the controller when game started
var offset_right = 0

func _ready():
	pass

func _process(delta):
	pass

func _on_ctrllr_right__pickable_object_picked_up(pickable):
	if(offset_right == 2): # sets offset back to 1 for next time picked up
		offset_right = 1	
	elif(offset_right == 1): # if picked up
		snapped_right.visible = false
		hand_right.visible = false
		controller_onRight.visible = true
		rightJoystick.enabled = true
		turningFunction.enabled = false
		offset_right = 2
	else: # fixes said bug
		offset_right = 1
	

func _on_ctrllr_right__pickable_object_dropped(pickable):
	pass
