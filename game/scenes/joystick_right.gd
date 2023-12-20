extends Node3D

@onready var drone = $"../../../../drone - PickableObject"

@export var DRONE_SPEED = 5.0

var right_value_Z:float = 0
var right_value_X:float = 0
	
func _on_right__controller_input_vector_2_changed(name, value):
	right_value_X = value[0]
	right_value_Z = value[1]
	
func _physics_process(delta):
	if(drone):
		#var a = drone.transform.basis
		#var droneRot = Vector3(a.x.z,a.y.x,-a.z.z)
		
		#drone.linear_velocity.x += droneRot.x * right_value_X * DRONE_SPEED * delta
		#drone.linear_velocity.z += droneRot.z * right_value_Z * DRONE_SPEED * delta
		
		
		#var v_len = drone.linear_velocity.length()
		#var v_nor = drone.linear_velocity.normalized()
		
		#var vel:Vector3
		#vel.x = a.x.dot(v_nor) * v_len
		#vel.y = a.y.dot(v_nor) * v_len
		#vel.z = a.z.dot(v_nor) * v_len
		
		#drone.position.x += -Vector3.FORWARD.x * right_value_X * DRONE_SPEED * delta
		#drone.position.z += -Vector3.FORWARD.z * right_value_Z * DRONE_SPEED * delta
		
		drone.translate(-Vector3.FORWARD *right_value_Z * DRONE_SPEED * delta)
		drone.translate(-Vector3.RIGHT *right_value_X * DRONE_SPEED * delta)
		
		if right_value_X == 0:
			pass
			#drone.linear_velocity = drone.global_transform.basis.orthonormalized() * right_value_X * DRONE_SPEED * delta
			#drone.linear_velocity.x -= drone.linear_velocity.x * min(delta/0.2,1.0)
		#if right_value_Z == 0:
			#drone.linear_velocity.z -= drone.linear_velocity.z * min(delta/0.2,1.0)

func _process(delta):
	rotation.x = 0.3 - right_value_X * 0.8
	rotation.z = -right_value_Z * 0.8
	
