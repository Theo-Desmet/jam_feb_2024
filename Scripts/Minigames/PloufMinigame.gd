extends Node2D

var texture;
var value = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = texture;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("space")):
		value += 6;
	value -= 0.1;
	$ProgressBar.value = value;
	if (value >= 100):
		GlobalSignal.GameWin.emit("plouf");
