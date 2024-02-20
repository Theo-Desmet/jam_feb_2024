extends Node2D
var value = 0;
var isFinised = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (isFinised):
		return;
	if (Input.is_action_just_pressed("space")):
		$Control/Window.position.y += 15;
	if $Control/Window.position.y > 0:
		$Control/Window.position.y -= 0.1;
	else:
		$Control/Window.position.y = 0;
	if $Control/Window.position.y >= 240:
		$Control/Window.position.y = 240;
		await get_tree().create_timer(0.2).timeout;
		GlobalSignal.GameWin.emit("window");
