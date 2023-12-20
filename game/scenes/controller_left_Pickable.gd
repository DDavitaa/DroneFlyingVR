extends Node3D



@onready var snapped_right = get_node("../controller_right")
@onready var snapped_left = get_node("../controller_left")

@onready var hand_right = get_node("../../player - origin/Right - controller/RightHand - model")
@onready var hand_left = get_node("../../player - origin/Left - controller/LeftHand - model")

@onready var controller_onRight = get_node("../../player - origin/Right - controller/controller_right")
@onready var controller_onLeft = get_node("../../player - origin/Left - controller/controller_left")

@onready var movingFunction = controller_onLeft.get_node("../MovementDirect")

@onready var leftJoystick = controller_onLeft.get_node("joystick_origin")

var offset_right = 0
var offset_left = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_ctrllr_left__pickable_object_2_picked_up(pickable):
	if(offset_left == 2):
		offset_left = 1
	elif(offset_left == 1):
		snapped_left.visible = false
		hand_left.visible = false
		controller_onLeft.visible = true
		leftJoystick.enabled = true
		movingFunction.enabled = false
		offset_left = 2
	else:
		
		offset_left = 1
	


func _on_ctrllr_left__pickable_object_dropped(pickable):
	pass # Replace with function body.
