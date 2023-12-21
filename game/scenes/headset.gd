extends Node3D

# get node for drone camera
@onready var droneCam = get_node("../../../player - origin/player - camera/droneMonitor")

# get node for timer
@onready var timer = get_node("../../Timer")

# variable to use for the timer
var forTimer = true

func _ready():
	pass

func _process(delta):
	pass

func _on_headset__pickable_object_picked_up(pickable):
	if pickable: # if headset is picked up
		if forTimer: # if opened
			# play animation to open headset
			$AnimationTree.set("parameters/Transition/transition_request","open")
			
			# start the timer to delay the drone camera toggle
			timer.start()
			
		else: # if closed
			# play animation to open headset
			$AnimationTree.set("parameters/Transition/transition_request","close")
			
			# start the timer to delay the drone camera toggle
			timer.start()
		

func _on_headset__pickable_object_dropped(pickable):
	pass

func _on_timer_timeout():
	if forTimer: # if opened, turn on the drone camera
		droneCam.visible = true
		forTimer = false
	else: # if closed, turn off the drone camera
		droneCam.visible = false
		forTimer = true
