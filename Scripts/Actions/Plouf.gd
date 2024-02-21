extends AActions;

@export var texture: Texture;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture	= texture;
	infos = {"type": "plouf", "texture": texture};
	pass # Replace with function body.
