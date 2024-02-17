extends CanvasLayer

var container = preload("res://Scenes/Gui/MiniGameContainer.tscn");

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignal.OpenMiniGameContainer.connect(miniGameContainer);

func miniGameContainer():
	var c = container.instantiate();
	c.global_position.x = 1920 / 2;
	c.global_position.y = 1080 / 2;
	add_child(c);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
