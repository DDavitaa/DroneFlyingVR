extends Node3D

@onready var particleScene = preload("res://scenes/particles.tscn")
var leftParticles
var rightParticles

# Called when the node enters the scene tree for the first time.
func _ready():
	leftParticles = particleScene.instantiate()
	rightParticles = particleScene.instantiate()
	
	add_child(leftParticles)
	add_child(rightParticles)
	
	leftParticles.position = Vector3()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
