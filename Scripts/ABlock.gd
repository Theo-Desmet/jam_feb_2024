extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("TEST");
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x -= 0.2;
	pass
