extends Node2D

var signs = [preload("res://Scenes/Minigames/Utils/Signs/Restricted.tscn"),
			preload("res://Scenes/Minigames/Utils/Signs/Blue.tscn"),
			preload("res://Scenes/Minigames/Utils/Signs/Double.tscn"),
			preload("res://Scenes/Minigames/Utils/Signs/Simple.tscn"),
			preload("res://Scenes/Minigames/Utils/Signs/Thin.tscn")];

const NUM_SIGNS = 4;
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	var r = randi() % 2;
	var s = signs[r].instantiate();
	s.position.y = -200;
	s.scale = Vector2i(15, 15);
	add_child(s);
	
	var pos = -100;
	for i in range(NUM_SIGNS):
		r = randi_range(2, len(signs) - 1);
		s = signs[r].instantiate();
		s.position.y = pos;
		s.scale = Vector2i(15, 15);
		r = randi() % 2;
		s.rotation_degrees = 180 * r;
		s.rotationAngle = 360 if r else 180;
		add_child(s);
		pos += 75;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if len(get_tree().get_nodes_in_group("signs")) == NUM_SIGNS + 1:
		GlobalSignal.GameWin.emit("streetSign");
