extends Node2D

var texture;
var keyToPress = 1;
var value = -10;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = texture;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if keyToPress == -1:
		$Action1.self_modulate.a = 0.5;
		$Action2.self_modulate.a = 1;
	else:
		$Action2.self_modulate.a = 0.5;
		$Action1.self_modulate.a = 1;
	
	var direction = Input.get_axis("action1", "action2");
	if (direction):
		if (keyToPress == direction):
			keyToPress *= -1;
			value += 10;

	value -= 0.1;
	$ProgressBar.value = value;
	if (value >= 100):
		GlobalSignal.GameWin.emit("traffic");
