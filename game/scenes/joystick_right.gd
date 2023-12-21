extends Node3D

# when controller is picked up, allow control of drone
@export var enabled = false

# get node of drone
@onready var drone = $"../../../../drone - PickableObject"

# export variable of drone speed
@export var DRONE_SPEED = 4.0

# for taking right stick values
var right_value_Z:float = 0
var right_value_X:float = 0

# export variable of speed of bullet
@export var bullet_speed = 25.0

# preload the bullet scene
@onready var bullet_scene = preload("res://scenes/bullet.tscn")

# get node of bullet spawn
@onready var bullet_spawn = drone.get_node("bulletSpawn")

# get node of root node
@onready var rootNode = get_node("../../../../")
	
func _on_right__controller_input_vector_2_changed(name, value):
	# store right stick values into global variables
	right_value_X = value[0]
	right_value_Z = value[1]
	
func _physics_process(delta):
	if drone: # fixes bug where it returns null
		if enabled: # if controllers are picked up
			# moving the drone
			drone.translate(-Vector3.FORWARD *right_value_Z * DRONE_SPEED * delta)
			drone.translate(-Vector3.RIGHT *right_value_X * DRONE_SPEED * delta)
			
			# adds a bit of rotation to the drone depending on direction it's going
			drone.rotation.x = right_value_Z * 0.2
			drone.rotation.z = right_value_X * 0.2
		

func _process(delta):
	# show the virtual right stick being rotated
	rotation.x = 0.3 - right_value_Z * 0.8
	rotation.z = -right_value_X * 0.8
	

func _on_right__controller_button_pressed(name):
	if name == "trigger_click":
		# spawn a bullet
		spawn_bullet()

func spawn_bullet():
	# instantiate a bullet
	var projectile = bullet_scene.instantiate()
	
	# add to root node
	rootNode.add_child(projectile)
	
	# set bullet position to bullet spawn position
	projectile.transform = bullet_spawn.global_transform
	
	# apply velocity to bullet
	projectile.linear_velocity = bullet_spawn.global_transform.basis.z * bullet_speed
