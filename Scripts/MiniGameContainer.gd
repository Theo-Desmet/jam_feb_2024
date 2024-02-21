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
			"window": preload("res://Scenes/Minigames/WindowMinigame.tscn"),
			"fruit": preload("res://Scenes/Minigames/FruitShelvesMinigame.tscn"),
			"package": preload("res://Scenes/Minigames/PackageMinigame.tscn"),
			"streetSign": preload("res://Scenes/Minigames/StreetSignsMinigame.tscn")};

var scores = {"posters": 100, "dragPoster": 100, "falling": 100, "fruit": 100,
			"obstacle": 100, "package": 100, "plouf": 100, "textWall": 100,
			"traffic": 100, "window": 100, "streetSign": 100};
			
var riotLevel = {"posters": 0.05, "dragPoster": 0.05, "falling": 0.05, "fruit": 0.05,
			"obstacle": 0.05, "package": 0.05, "plouf": 0.05, "textWall": 0.05,
			"traffic": 0.05, "window": 0.05, "streetSign": 0.05};
			
var timer = {"dragPoster": 5, "dropClothes": 5, "fruit": 5, "obstacle": 5, 
			"package": 5, "streetSign": 5, "textWall": 5, "plouf": 5,
			"trafficLight": 5, "poster": 5, "window": 5};



# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween().set_parallel(true);
	tween.tween_property($ProgressBar, "value", 0, timer[miniGameInfos["type"]]);	
	GlobalSignal.GameWin.connect(win);
	$Timer.wait_time = timer[miniGameInfos["type"]];
	$Timer.start();
	var minigame = scenes[miniGameInfos["type"]].instantiate();
	#minigame.variation = miniGameInfos["variation"];
	if miniGameInfos.has("texture"):
		minigame.texture = miniGameInfos["texture"];
	if miniGameInfos.has("up"):
		minigame.upFruit = miniGameInfos["up"];
		minigame.bottomFruit = miniGameInfos["bottom"];
	add_child(minigame);
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func win(type):
	GlobalSignal.UpdateScore.emit(scores[type]);
	GlobalSignal.UpdateRiotLevel.emit(riotLevel[type]);
	winBool = true;
	_on_timer_timeout(type);

func _on_timer_timeout(type = ""):
	GlobalSignal.SetPlayerMove.emit(true);
	GlobalSignal.ActionFinished.emit(winBool);
	GlobalSignal.selectedItem = null;
	queue_free();
