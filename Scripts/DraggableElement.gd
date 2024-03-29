extends Node2D

var isSelected = false;
var isHovered = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isHovered and Input.is_action_just_pressed("click") and !isSelected and !GlobalSignal.selectedItem:
		isSelected = true;
		GlobalSignal.selectedItem = self;
		scale *= 2;
		z_index = 2;

	elif isHovered and Input.is_action_just_pressed("click") and isSelected:
		isSelected = false;
		GlobalSignal.selectedItem = null;
		scale /= 2;
		z_index = 0;

	elif !isHovered and Input.is_action_just_pressed("click") and isSelected:
		isSelected = false;
		GlobalSignal.selectedItem = null;
		scale /= 2;
		z_index = 0;
		
	if isSelected:
		global_position = get_viewport().get_mouse_position()
		



func _on_area_2d_mouse_entered():
	isHovered = true;

func _on_area_2d_mouse_exited():
	isHovered = false;
