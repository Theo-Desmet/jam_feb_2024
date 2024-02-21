extends Node2D

var isHovered = false;
var state = 0;
const NUM_ITEMS = 5;
var counter = 0;

var itemScene = preload("res://Scenes/Minigames/Utils/PackageItems.tscn");
var textures = [preload("res://asset/Minigames/Package/Calque 2.png"),
				preload("res://asset/Minigames/Package/Calque 3.png"),
				preload("res://asset/Minigames/Package/Calque 4.png"),
				preload("res://asset/Minigames/Package/Calque 5.png"),
				preload("res://asset/Minigames/Package/Calque 6.png"),
				preload("res://asset/Minigames/Package/Calque 7.png"),
				preload("res://asset/Minigames/Package/Calque 8.png"),
				preload("res://asset/Minigames/Package/Calque 9.png"),
				preload("res://asset/Minigames/Package/Calque 10.png"),
				preload("res://asset/Minigames/Package/Calque 11.png"),
				preload("res://asset/Minigames/Package/Calque 12.png")];

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(NUM_ITEMS):
		var r = randi_range(0, len(textures) - 1);
		var item = itemScene.instantiate();
		item.position.x = randi_range(-60, 60);
		item.position.y = randi_range(-100, 120);
		item.texture = textures[r];
		item.scale = Vector2i(10, 10);
		item.visible = false;
		item.add_to_group("items");
		add_child(item);

func activateItems():
	var items = get_tree().get_nodes_in_group("items");
	for item in items:
		item.isPickable = true;
		item.visible = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isHovered and !state and Input.is_action_just_pressed("click"):
		$AnimatedSprite2D.play("open");
	if state == 1:
		$AnimatedSprite2D.self_modulate.a = 0.75;
		activateItems()
		state += 1;
	if counter == NUM_ITEMS and !GlobalSignal.selectedItem:
		GlobalSignal.GameWin.emit("package");


func _on_area_2d_mouse_entered():
	isHovered = true;


func _on_area_2d_mouse_exited():
	isHovered = false;


func _on_animated_sprite_2d_animation_finished():
	await get_tree().create_timer(0.2).timeout;
	state = 1;


func _on_area_2d_area_exited(area):
	if (!area.get_parent().isOutOfBox):
		area.get_parent().isOutOfBox = true;
		counter += 1;
	pass # Replace with function body.
