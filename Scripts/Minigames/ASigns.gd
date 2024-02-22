extends Node2D

var isHovered = false;
var isRotated = false;

@export var rotationAngle = 180;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isRotated:
		$AnimationPlayer.stop();
	if isHovered and !isRotated and Input.is_action_just_pressed("click"):
		var tween = create_tween().set_parallel(true);
		tween.tween_property(self, "rotation_degrees", rotationAngle, 0.5);
		add_to_group("signs");
		isRotated = true;
		

func _on_area_2d_mouse_entered():
	isHovered = true;

func _on_area_2d_mouse_exited():
	isHovered = false;
