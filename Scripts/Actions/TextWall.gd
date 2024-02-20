extends AActions;

@export var texture: Texture;

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	$Sprite.texture	= texture;
	infos = {"type": "textWall", "texture": texture};

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;
