extends AActions;

var afterTexture = preload("res://asset/Minigames/TrafficOff.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	infos = {"type": "trafficLight", "texture": $Sprite.texture};

func changeSprite():
	$Sprite.texture = afterTexture;
