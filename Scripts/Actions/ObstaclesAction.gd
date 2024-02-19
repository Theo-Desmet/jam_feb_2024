extends AActions;

@export var texture: Texture;

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignal.connect("GameWin", gameWin);
	randomize();
	$Sprite.texture	= texture;
	infos = {"type": "obstacle", "texture": texture};

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;
	
#func gameWin(type):
	#if type == "obstacle":
		#queue_free();

