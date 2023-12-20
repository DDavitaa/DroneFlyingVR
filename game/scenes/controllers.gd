extends Node3D

@onready var snapped_right = get_node("../../../ctrllr_right - PickableObject/controller_right")
@onready var snapped_left = get_node("../../../ctrllr_left - PickableObject/controller_left")

@onready var hand_right = get_node("../RightHand - model")
@onready var hand_left = get_node("../LeftHand - model")

@onready var controller_onRight = get_node("../../Right - controller/controller_right")
@onready var controller_onLeft = get_node("../../Left - controller/controller_left")

func _ready():
	pass # Replace with function body.
	

func _process(delta):
	pass
	


func _on_left__controller_button_pressed(name):
	if(name == "grip_click"):
		snapped_left.visible = true
		hand_left.visible = true
		controller_onLeft.visible = false

func _on_right__controller_button_pressed(name):
	if(name == "grip_click"):
		snapped_right.visible = true
		hand_right.visible = true
		controller_onRight.visible = false

