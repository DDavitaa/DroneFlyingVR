extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_headset__pickable_object_picked_up(pickable):
	if(pickable):
		print("yes")
		$AnimationTree.set("parameters/Transition/transition_request","open")
	

func _on_headset__pickable_object_dropped(pickable):
	if(pickable):
		$AnimationTree.set("parameters/Transition/transition_request","close")
