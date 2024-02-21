extends AActions;

@export var fruitUp: String;
@export var fruitBottom: String;
@export var texture: Texture;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = texture;
	infos = {"type": "fruit", "up": fruitUp, "bottom": fruitBottom};
