extends Node2D

var isSelected = false;
var isHovered = false;
var isGoodPlaced = false;

var texture: Texture;

const THICK_STEP = 0.005;
var multiplier = 1;
var thickness = 0.5;

var mat; 

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = texture;
	mat = $Sprite2D.material
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if $Sprite2D.material:
		$Sprite2D.material.set_shader_parameter("line_thickness", thickness);
		thickness += THICK_STEP * multiplier;
		if (thickness >= 1):
			multiplier *= -1;
		if (thickness < 0.5):
			multiplier *= -1;
	
	if !isGoodPlaced and isHovered and Input.is_action_just_pressed("click") and !isSelected \
	and GlobalSignal.selectedItem == null:
		isSelected = true;
		GlobalSignal.selectedItem = self;
		z_index = 2;
		scale *= 1.5;

	elif isHovered and Input.is_action_just_pressed("click") and isSelected:
		isSelected = false;
		GlobalSignal.selectedItem = null;
		z_index = 0;
		
		scale /= 1.5;
	elif !isHovered and Input.is_action_just_pressed("click") and isSelected:
		isSelected = false;
		GlobalSignal.selectedItem = null;
		scale /= 1.5;
		z_index = 0;
	
	if isGoodPlaced:
		$Sprite2D.material = null;
	else:
		$Sprite2D.material = mat;
	
	if isSelected:
		global_position = get_viewport().get_mouse_position()
		


func _on_area_2d_mouse_entered():
	isHovered = true;

func _on_area_2d_mouse_exited():
	isHovered = false;
