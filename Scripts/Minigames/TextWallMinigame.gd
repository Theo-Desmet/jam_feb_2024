extends Node2D

signal wordCompleted;

var texture;
var counter = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = texture;
	wordCompleted.connect(wordComplete);
	pass # Replace with function body.

func wordComplete():
	counter += 1;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if counter == 1:
		GlobalSignal.GameWin.emit("textWall");
