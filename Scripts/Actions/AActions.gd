extends Node2D

class_name AActions;

var infos = {};
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func disable(hide = false):
	#pass
	$Sprite.set_material(null);
	$Area2D.monitoring = false;
	$Exclam.visible = false;
	

func ploufAction():
	pass;

func getInfos():
	return infos;
	
func _on_area_2d_body_entered(body):
	GlobalSignal.ActionNearby.emit(self);

func _on_area_2d_body_exited(body):
	GlobalSignal.ActionAway.emit();
