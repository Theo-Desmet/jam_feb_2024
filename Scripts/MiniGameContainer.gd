extends Node2D

var miniGameInfos;

var scenes = {"poster": preload("res://Scenes/Minigames/ClickablePosters.tscn")};

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignal.GameWin.connect(_on_timer_timeout);
	var minigame = scenes[miniGameInfos["type"]].instantiate();
	minigame.variation = miniGameInfos["variation"];
	add_child(minigame);
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	GlobalSignal.SetPlayerMove.emit(true);
	queue_free();
