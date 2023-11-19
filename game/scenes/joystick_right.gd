extends Node3D

var right_value_Z:float = 0
var right_value_X:float = 0
	
func _on_right__controller_input_vector_2_changed(name, value):
	right_value_Z = value[0]
	right_value_X = value[1]

func _process(delta):
	rotation.x = 0.3 - right_value_X * 0.8
	rotation.z = -right_value_Z * 0.8
	
