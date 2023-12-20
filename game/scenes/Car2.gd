extends Node3D

@onready var path = get_node("/root/root/Car2Path3D/PathFollow3D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	const move_speed := 4.0
	path.progress += move_speed * delta
