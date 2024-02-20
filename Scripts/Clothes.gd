extends Node2D

@export var texture: Texture;
@export var Aftertexture: Texture;

var isHovered = false;
var isFalling = false;

const THICK_STEP = 0.005;
var multiplier = 1;
var thickness = 0.2;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = texture;
	$AfterSprite.texture = Aftertexture;
	$AfterSprite.visible = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Sprite2D.material:
		$Sprite2D.material.set_shader_parameter("line_thickness", thickness);
		thickness += THICK_STEP * multiplier;
		if (thickness >= 0.5):
			multiplier *= -1;
		if (thickness < 0.2):
			multiplier *= -1;
	if isHovered and !isFalling and Input.is_action_just_pressed("click"):
		isFalling = true;
		$AfterSprite.visible = true;
		$Sprite2D.material = null;
		get_parent().get_parent().fallingClothe.emit();
		
	if isFalling:
		$Sprite2D.position.y += 0.3;
	


func _on_area_2d_mouse_entered():
	isHovered = true;

func _on_area_2d_mouse_exited():
	isHovered = false;
