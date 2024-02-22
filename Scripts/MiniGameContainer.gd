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

var scores = {"posters": 12000, "dragPoster": 11000, "falling": 13000, "fruit": 25000,
			"obstacle": 9000, "package": 21000, "plouf": 100, "textWall": 15000,
			"traffic": 8000, "window": 12000, "streetSign": 9000};
			
var riotLevel = {"posters": 0.05, "dragPoster": 0.05, "falling": 0.05, "fruit": 0.09,
			"obstacle": 0.04, "package": 0.08, "plouf": 0.05, "textWall": 0.06,
			"traffic": 0.04, "window": 0.05, "streetSign": 0.04};
			
var timer = {"dragPoster": 4, "dropClothes": 4, "fruit": 8, "obstacle": 3, 
			"package": 7, "streetSign": 3, "textWall": 5, "plouf": 5,
			"trafficLight": 3, "poster": 4, "window": 4};



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
