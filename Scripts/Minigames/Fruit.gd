extends Node2D

var isSelected = false;
var isHovered = false;
var isGoodPlaced = false;

var texture: Texture;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = texture;
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
		
		
	if isSelected:
		global_position = get_viewport().get_mouse_position()
		


func _on_area_2d_mouse_entered():
	isHovered = true;

func _on_area_2d_mouse_exited():
	isHovered = false;
