extends AActions;

@export var texture: Texture;

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	$Sprite.texture	= texture;
	infos = {"type": "textWall", "texture": texture};


func changeSprite():
	$Tag.visible = true;
