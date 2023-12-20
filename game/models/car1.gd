extends CharacterBody3D

#Movement Variables
var speed = 8
var accel = 10

@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var South = get_node("/root/root/South")

func _physics_process(delta):
	
	var direction = Vector3()
	#Checks positions
	nav.target_position = South.global_position
	
	#Calculates the path once you give your nav agent a target
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, accel * delta)
	
	if nav.target_position == South.global_position:
		print("test")
	
	move_and_slide()
