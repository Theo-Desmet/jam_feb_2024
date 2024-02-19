extends Node2D

var variation;
var texture: Texture;
var counter = 0;

const NUM_POSTERS = 6;

var poster = preload("res://Scenes/Minigames/Utils/ClickableElement.tscn");

# Called when the node enters the scene tree for the first time.
func spawnBlock():
	var cli = poster.instantiate();
	cli.CLickOnElement.connect(incCounter);
	cli.position.x = randi_range(-180, 180);
	cli.position.y = randi_range(-180, 180);
	cli.setOpacity(0.5);
	#while cli.isOverlapping():
		#cli.position.x = randi_range(-180, 180);
		#cli.position.y = randi_range(-180, 180);
	add_child(cli);

func incCounter():
	counter += 1;

func _ready():
	$Sprite2D.texture = texture;
	randomize();
	for i in range(NUM_POSTERS):
		spawnBlock();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (counter == NUM_POSTERS):
		await get_tree().create_timer(0.2).timeout;
		GlobalSignal.GameWin.emit("posters");
	
