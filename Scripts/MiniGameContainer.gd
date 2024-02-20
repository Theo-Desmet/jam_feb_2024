extends Node2D

var miniGameInfos;
var winBool = false;

var scenes = {"poster": preload("res://Scenes/Minigames/ClickablePosters.tscn"),
"obstacle": preload("res://Scenes/Minigames/Obstacle.tscn"),
"plouf": preload("res://Scenes/Minigames/PloufMinigame.tscn"),
"dragPoster": preload("res://Scenes/Minigames/DraggablePosters.tscn"),
"trafficLight": preload("res://Scenes/Minigames/TrafficLightMinigame.tscn"),
"textWall": preload("res://Scenes/Minigames/TextWallMinigame.tscn"),
"dropClothes": preload("res://Scenes/Minigames/DropClothesMinigame.tscn"),
"window": preload("res://Scenes/Minigames/WindowMinigame.tscn")};


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignal.GameWin.connect(win);
	var minigame = scenes[miniGameInfos["type"]].instantiate();
	#minigame.variation = miniGameInfos["variation"];
	if miniGameInfos.has("texture"):
		minigame.texture = miniGameInfos["texture"];
	add_child(minigame);
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func win(type):
	winBool = true;
	_on_timer_timeout(type);

func _on_timer_timeout(type = ""):
	GlobalSignal.SetPlayerMove.emit(true);
	GlobalSignal.ActionFinished.emit(winBool);
	queue_free();
