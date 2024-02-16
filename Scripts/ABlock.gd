extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#print("Instance");
	pass
	#pass # Replace with function body.

var id;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x -= 0.2;
	if (($TileMap.get_used_rect().size.x * 16) + global_position.x) < 0:
		GlobalSignal.BlockDestroyed.emit();
		queue_free()
		
	
func getSize():
	return $TileMap.get_used_rect().size;
