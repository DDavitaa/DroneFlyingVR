extends Node3D

@onready var snapped_right = get_node("../controller_right")
@onready var snapped_left = get_node("../controller_left")

@onready var hand_right = get_node("../../player - origin/Right - controller/RightHand - model")
@onready var hand_left = get_node("../../player - origin/Left - controller/LeftHand - model")

@onready var controller_onRight = get_node("../../player - origin/Right - controller/controller_right")
@onready var controller_onLeft = get_node("../../player - origin/Left - controller/controller_left")

@onready var turningFunction = controller_onRight.get_node("../MovementTurn")

@onready var rightJoystick = controller_onRight.get_node("joystick_origin")

var offset_right = 0
var offset_left = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ctrllr_right__pickable_object_picked_up(pickable):
	if(offset_right == 2):
		offset_right = 1	
	elif(offset_right == 1):
		snapped_right.visible = false
		hand_right.visible = false
		controller_onRight.visible = true
		rightJoystick.enabled = true
		turningFunction.enabled = false
		offset_right = 2
	else:
		offset_right = 1
	

func _on_ctrllr_right__pickable_object_dropped(pickable):
	pass # Replace with function body.
