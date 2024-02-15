extends Node2D

#var xMin = $Area.
#var xMax
#var yMin
#var yMax

func _ready():
	var scene = load("res://npc.tscn")
	var npc
	for i in range(1000):
		npc = scene.instantiate()
		npc.position.x = randi() % int($Area/CollisionShape2D.position.x * 2)
		npc.position.y = randi() % int($Area/CollisionShape2D.position.y * 2)
		add_child(npc)
		print($Area/CollisionShape2D.position.x * 2, $Area/CollisionShape2D.position.y * 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
