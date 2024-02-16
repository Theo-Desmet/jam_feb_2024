extends Node2D

@export var npc_scene: PackedScene

#var xMin = $Area.
#var xMax
#var yMin
#var yMax

func _ready():
	for i in range(15):
		var npc = npc_scene.instantiate()
		npc.position.x = i
		npc.position.y = i
		add_child(npc)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
