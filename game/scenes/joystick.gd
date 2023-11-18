extends Node3D

var value_Z:float = 0
var value_X:float = 0


func _on_right__controller_input_vector_2_changed(name, value):
	value_Z = value[0]
	value_X = value[1]


func _process(delta):
	rotation.x = 0.3 - value_X
	rotation.z = -value_Z
	



