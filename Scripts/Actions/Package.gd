extends AActions;

var afterTexture = preload("res://asset/sprite/tile_0275.png");

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	infos = {"type": "package"};

func disable(hide = false):
	$Sprite.texture = afterTexture;
	$Sprite.set_material(null);
	$Area2D.monitoring = false;
	$Exclam.visible = false;
	$Area2D.collision_layer = 0;

