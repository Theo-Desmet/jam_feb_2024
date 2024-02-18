extends Node2D

var variation;

var poster = preload("res://Scenes/Minigames/Utils/ClickableElement.tscn");

# Called when the node enters the scene tree for the first time.
func spawnBlock():
	var cli = poster.instantiate();
	cli.position.x = randi_range(-180, 180);
	cli.position.y = randi_range(-180, 180);
	cli.add_to_group("posters");
	#while cli.isOverlapping():
		#cli.position.x = randi_range(-180, 180);
		#cli.position.y = randi_range(-180, 180);
	add_child(cli);

func _ready():
	randomize();
	for i in range(6):
		spawnBlock();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!get_tree().get_nodes_in_group("posters").size()):
		GlobalSignal.GameWin.emit();
	
