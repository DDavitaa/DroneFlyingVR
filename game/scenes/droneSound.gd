extends AudioStreamPlayer3D

func _ready():
	pass


func _process(delta):
	pass

# loops drone sound
func _on_finished():
	play()
