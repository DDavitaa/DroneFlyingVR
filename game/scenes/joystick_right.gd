extends Node3D

@export var enabled = false

@onready var drone = $"../../../../drone - PickableObject"

@export var DRONE_SPEED = 4.0

var right_value_Z:float = 0
var right_value_X:float = 0

@export var bullet_speed = 25.0
@onready var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var bullet_spawn = drone.get_node("bulletSpawn")
@onready var rootNode = get_node("../../../../")
	
func _on_right__controller_input_vector_2_changed(name, value):
	right_value_X = value[0]
	right_value_Z = value[1]
	
func _physics_process(delta):
	if(drone):
		if enabled:
			drone.translate(-Vector3.FORWARD *right_value_Z * DRONE_SPEED * delta)
			drone.translate(-Vector3.RIGHT *right_value_X * DRONE_SPEED * delta)
		
			drone.rotation.x = right_value_Z * 0.2
			drone.rotation.z = right_value_X * 0.2
		

func _process(delta):
	rotation.x = 0.3 - right_value_Z * 0.8
	rotation.z = -right_value_X * 0.8
	

func _on_right__controller_button_pressed(name):
	if name == "trigger_click":
		spawn_bullet()

func spawn_bullet():
	var projectile = bullet_scene.instantiate()
	rootNode.add_child(projectile)
	projectile.transform = bullet_spawn.global_transform
	projectile.linear_velocity = bullet_spawn.global_transform.basis.z * bullet_speed
