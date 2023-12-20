extends Node3D

@onready var drone = $"../../../../drone - PickableObject"

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
	#	drone.linear_velocity.y += left_value_X * DRONE_SPEED_Y * delta
	#	drone.rotation.y += left_value_Z * DRONE_ROTSPEED * delta
	#	if(left_value_X == 0):
	#		drone.linear_velocity.y -= drone.linear_velocity.y * min(delta/0.2,1.0)
	#	
		#var current_position = drone.position
		#droneVel = (current_position.y - last_positionY.y) / delta
		
		drone.position.y += left_value_X * DRONE_SPEED_Y * delta
		drone.rotation.y += left_value_Z * DRONE_ROTSPEED * delta
		
		#last_positionY = drone.position
	
		#print("CURRENT:", current_position)
		#print("LAST___:", last_positionY)
		#print("VEL:", droneVel)
		#upSpeed = lerp(upSpeed,MAX_SPEED,left_value_X * delta)
		
		

func _process(delta):
	rotation.x = 0.3 - left_value_X * 0.8
	rotation.z = -left_value_Z * 0.8
	
	
