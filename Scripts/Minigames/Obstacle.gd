extends Node2D

var variation;
var texture: Texture;
var isHovered = false;
var counter = 0;
var totalHp;
const THICK_STEP = 0.01;
var multiplier = 1;
var thickness = 0.2;

# Called when the node enters the scene tree for the first time.
func _ready():
	totalHp = randi_range(20, 35);
	$Sprite2D.texture = texture;
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite2D.material.set_shader_parameter("line_thickness", thickness);
	thickness += THICK_STEP * multiplier;
	if (thickness >= 0.5):
		multiplier *= -1;
	if (thickness < 0.2):
		multiplier *= -1;
	if isHovered and Input.is_action_just_pressed("click"):
		counter += 1;
		$AnimationPlayer.play("hit");
	if counter == totalHp:
		GlobalSignal.GameWin.emit("obstacle");


func _on_area_2d_mouse_entered():
	isHovered = true;

func _on_area_2d_mouse_exited():
	isHovered = false;
