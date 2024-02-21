extends Node2D

var fruits = {"apple": preload("res://asset/Minigames/Fruits/Apple.png"),
			"eggplant": preload("res://asset/Minigames/Fruits/Eggplant.png"),
			"lettuce": preload("res://asset/Minigames/Fruits/Lettuce.png"),
			"starfruit": preload("res://asset/Minigames/Fruits/Star_Fruit.png"),
			"orange": preload("res://asset/Minigames/Fruits/Tangerine.png")};

var fruitScene = preload("res://Scenes/Minigames/Utils/Fruit.tscn");

var upFruit = "";
var bottomFruit = "";

const NUM_FRUITS = 4;

var upGoodCounter = 0;
var bottomGoodCounter = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	for i in range(NUM_FRUITS):
		var fruit = fruitScene.instantiate();
		fruit.texture = fruits.get(upFruit);
		fruit.scale = Vector2i(3, 3);
		fruit.position.y = randi_range(-200, -120);
		fruit.position.x = randi_range(-100, 100);
		fruit.add_to_group("down");
		add_child(fruit);

	for i in range(NUM_FRUITS):
		var fruit = fruitScene.instantiate();
		fruit.texture = fruits.get(bottomFruit);
		fruit.scale = Vector2i(3, 3);
		fruit.position.y = randi_range(30, 100);
		fruit.position.x = randi_range(-100, 100);
		fruit.add_to_group("up");
		add_child(fruit);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (upGoodCounter == bottomGoodCounter and upGoodCounter == NUM_FRUITS
		and !GlobalSignal.selectedItem):
		GlobalSignal.GameWin.emit("fruit");


func _on_up_area_area_entered(area):
	if (area.get_parent().is_in_group("up")):
		area.get_parent().isGoodPlaced = true;
		upGoodCounter += 1;

func _on_up_area_area_exited(area):
	if (area.get_parent().is_in_group("up")):
		area.get_parent().isGoodPlaced = false;
		upGoodCounter -= 1;

func _on_botom_area_area_entered(area):
	if (area.get_parent().is_in_group("down")):
		area.get_parent().isGoodPlaced = false;
		bottomGoodCounter += 1;

func _on_botom_area_area_exited(area):
	if (area.get_parent().is_in_group("down")):
		area.get_parent().isGoodPlaced = false;
		bottomGoodCounter -= 1;
