extends AActions;

var left = preload("res://asset/sprite/tile_0217.png")
var mid = preload("res://asset/sprite/tile_0218.png")
var right = preload("res://asset/sprite/tile_0219.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	infos = {"type": "dropClothes"};

func disable(hide = false):
	$Sprite.set_material(null);
	$Area2D.monitoring = false;
	$Exclam.visible = false;
	$LeftSprite.set_material(null);
	$RightSprite.set_material(null);
	$MidSprite.set_material(null);
	$LeftSprite.texture = left;
	$RightSprite.texture = right;
	$MidSprite.texture = mid;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;
