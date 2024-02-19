extends Node2D

var miniGameInfos;

var scenes = {"poster": preload("res://Scenes/Minigames/ClickablePosters.tscn"),
"obstacle": preload("res://Scenes/Minigames/Obstacle.tscn"),
"plouf": preload("res://Scenes/Minigames/PloufMinigame.tscn")};

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignal.GameWin.connect(_on_timer_timeout);
	var minigame = scenes[miniGameInfos["type"]].instantiate();
	#minigame.variation = miniGameInfos["variation"];
	minigame.texture = miniGameInfos["texture"];
	add_child(minigame);
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout(type = ""):
	GlobalSignal.SetPlayerMove.emit(true);
	queue_free();
