extends Node3D

# when controller is picked up, allow control of drone
@export var enabled = false

# get node of drone
@onready var drone = $"../../../../drone - PickableObject"

# get node of drone sound
@onready var sound = $"../../../../drone - PickableObject/AudioStreamPlayer3D"

# export variable of drone elevation speed and rotation speed
@export var DRONE_SPEED_Y = 3.0
@export var DRONE_ROTSPEED = 2.0

# for taking left stick values
var left_value_Z = 0.0
var left_value_X = 0.0

func _on_left__controller_input_vector_2_changed(name, value):
	# store left stick values into global variables
	left_value_Z = value[0]
	left_value_X = value[1]

func _physics_process(delta):
	if drone: # fixes bug where it returns null
		if enabled: # if controllers are picked up
			# move drone up or down
			drone.position.y += left_value_X * DRONE_SPEED_Y * delta
			
			# rotate drone yaw
			drone.rotation.y += -left_value_Z * DRONE_ROTSPEED * delta
		
			# if left stick is not moved
			if left_value_X == 0:
				# lerp sound pitch from when it was being moved
				sound.pitch_scale = lerp(sound.pitch_scale,1.0,0.1)
			else:
				# control the pitch
				sound.pitch_scale += left_value_X * delta
				
				# set max and min of pitch
				sound.pitch_scale = clamp(sound.pitch_scale, 0.8,1.2)
			
	
func _process(delta):
	# show the virtual left stick being rotated
	rotation.x = 0.3 - left_value_X * 0.8
	rotation.z = -left_value_Z * 0.8
	

func _on_left__controller_button_pressed(name):
	if name == "trigger_click":
		# reset drone position
		drone.position = Vector3(0,1.148,-2.046) 
		drone.rotation = Vector3(0,0,0)
