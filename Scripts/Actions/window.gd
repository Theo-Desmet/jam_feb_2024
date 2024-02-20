extends AActions;

var afterTexture = preload("res://asset/sprite/tile_0391.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	infos = {"type": "window"};

func changeSprite():
	$Sprite.texture = afterTexture;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;
