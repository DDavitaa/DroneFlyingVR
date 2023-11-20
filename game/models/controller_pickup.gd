extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ctrllr_right__pickable_object_picked_up(pickable):
	print("right")


func _on_ctrllr_left__pickable_object_2_picked_up(pickable):
	print("left")
