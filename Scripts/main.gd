extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_window().size = Vector2i(1920, 1080)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()
