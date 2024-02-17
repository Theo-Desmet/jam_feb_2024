extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func disable():
	$Sprite.set_material(null);
	$Area2D.monitoring = false;
	$Exclam.visible = false;

func _on_area_2d_body_entered(body):
	GlobalSignal.ActionNearby.emit(self);

func _on_area_2d_body_exited(body):
	GlobalSignal.ActionAway.emit();
