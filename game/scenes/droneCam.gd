extends Camera3D

@onready var drone = $"../../"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = drone.position + Vector3(0,-0.1,0)
	rotation = drone.rotation + Vector3(-0.5, 3.15, 0)
