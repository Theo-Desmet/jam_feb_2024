extends Node2D

var variation;
var texture: Texture;
var counter = 0;

const NUM_POSTERS = 4;

const THICK_STEP = 0.01;
var multiplier = 1;
var thickness = 0.2;

var letter = preload("res://Scenes/Minigames/Utils/DraggableElement.tscn");

# Called when the node enters the scene tree for the first time.
func spawnBlock():
	var le = letter.instantiate();
	le.position.x = randi_range(-180, 180);
	le.position.y = randi_range(160, 180);
	le.scale = Vector2i(5, 5);
	
	add_child(le);

func _ready():
	$Sprite2D.texture = texture;
	randomize();
	for i in range(NUM_POSTERS):
		spawnBlock();
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite2D.material.set_shader_parameter("line_thickness", thickness);
	thickness += THICK_STEP * multiplier;
	if (thickness >= 0.5):
		multiplier *= -1;
	if (thickness < 0.2):
		multiplier *= -1;
	if counter == NUM_POSTERS:
		GlobalSignal.GameWin.emit("dragPoster");

func _on_area_2d_area_entered(area):
	area.get_parent().queue_free();
	counter += 1;
	pass # Replace with function body.
