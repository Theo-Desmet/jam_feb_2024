extends Node2D

signal CLickOnElement;

var texture1 = preload("res://asset/sprite/tile_0213.png");
var texture2 = preload("res://asset/sprite/tile_0159.png");
var texture3 = preload("res://asset/sprite/tile_0132.png");
var texture4 = preload("res://asset/sprite/tile_0078.png");

var textures = [texture1, texture2, texture3, texture4];
var isPasted = false;
var isHovered = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	pass # Replace with function body.

func setOpacity(val):
	$Sprite2D.self_modulate.a = val;

func isOverlapping():
	return $Area2D.get_overlapping_bodies();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isHovered and Input.is_action_just_pressed("click") and !isPasted:
		var r = randi_range(0, 3);
		setOpacity(1);
		$Sprite2D.texture = textures[r];
		CLickOnElement.emit();
		isPasted = true;
	#while len($Area2D.get_overlapping_areas()) != 0:
		#self.position.x = randi_range(-180, 180);
		#self.position.y = randi_range(-180, 180);
		#await get_tree().create_timer(0.3).timeout;

func _on_area_2d_area_entered(area):
	pass;

func _on_area_2d_mouse_entered():
	isHovered = true;

func _on_area_2d_mouse_exited():
	isHovered = false;
