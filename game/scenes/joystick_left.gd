extends Node3D

@onready var drone = $"../../../../drone - PickableObject"
@onready var sound = $"../../../../drone - PickableObject/AudioStreamPlayer3D"

var MAX_SPEED = 5.0
var ACCELERATION = 0.5

var droneVel = 0.0
var upSpeed = 0.0
@export var DRONE_SPEED_Y = 4.0
@export var DRONE_ROTSPEED = 2.0

var left_value_Z = 0.0
var left_value_X = 0.0

var last_positionY = Vector3.ZERO

func _on_left__controller_input_vector_2_changed(name, value):
	left_value_Z = value[0]
	left_value_X = value[1]

func _physics_process(delta):
	if(drone):
		
		drone.position.y += left_value_X * DRONE_SPEED_Y * delta
		drone.rotation.y += -left_value_Z * DRONE_ROTSPEED * delta
		
		if left_value_X == 0:
			sound.pitch_scale = lerp(sound.pitch_scale,1.0,0.1)
		else:
			sound.pitch_scale += min(1.5,left_value_X * delta)
	
func _process(delta):
	rotation.x = 0.3 - left_value_X * 0.8
	rotation.z = -left_value_Z * 0.8
	

func _on_left__controller_button_pressed(name):
	if name == "trigger_click":
		drone.position = Vector3(0,1.148,-2.046) 
		drone.rotation = Vector3(0,0,0)
