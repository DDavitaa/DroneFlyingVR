extends Node3D

@onready var droneCam = get_node("../../../player - origin/player - camera/droneMonitor")
@onready var timer = get_node("../../Timer")

var forTimer = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_headset__pickable_object_picked_up(pickable):
	if pickable:
		if forTimer:
			$AnimationTree.set("parameters/Transition/transition_request","open")
			timer.start()
			
		else:
			$AnimationTree.set("parameters/Transition/transition_request","close")
			timer.start()
		
	

func _on_headset__pickable_object_dropped(pickable):
	pass


func _on_timer_timeout():
	if forTimer:
		droneCam.visible = true
		forTimer = false
	else:
		droneCam.visible = false
		forTimer = true
