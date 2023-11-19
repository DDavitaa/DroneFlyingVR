extends Node3D

var left_value_Z:float = 0
var left_value_X:float = 0

func _on_left__controller_input_vector_2_changed(name, value):
	left_value_Z = value[0]
	left_value_X = value[1]

func _process(delta):
	rotation.x = 0.3 - left_value_X * 0.8
	rotation.z = -left_value_Z * 0.8
	
