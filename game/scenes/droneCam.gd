extends Camera3D

# get node for drone
@onready var drone = $"../../"

func _ready():
	pass

func _process(delta):
	# aligns position and rotation with drone, adding extra vectors to adjust the camera
	position = drone.position + Vector3(0,-0.1,0)
	rotation = drone.rotation + Vector3(-0.5, 3.15, 0)
