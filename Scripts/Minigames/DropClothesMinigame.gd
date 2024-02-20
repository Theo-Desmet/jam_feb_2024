extends Node2D

signal fallingClothe;
var counter = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	fallingClothe.connect(falling);


func falling():
	counter += 1;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if counter == 9:
		GlobalSignal.GameWin.emit("falling");
