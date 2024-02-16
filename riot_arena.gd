extends Node2D

#var xMin = $Area.
#var xMax
#var yMin
#var yMax

func _ready():
	var scene = load("res://npc.tscn")
	var npc
	for i in range(1):
		npc = scene.instantiate()
		npc.position.x = randi() % 950
		npc.position.y = randi() % 340
		add_child(npc)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
