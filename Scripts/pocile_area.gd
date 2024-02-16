extends Node2D

@export var police_scene: PackedScene

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	var npc
	for i in range(19):
		npc = police_scene.instantiate()
		npc.position.x = randi() % 5 + 32
		npc.position.y = i * 16
		add_child(npc)
	for i in range(19):
		npc = police_scene.instantiate() 
		npc.position.x = randi() % 5 + 48
		npc.position.y = i * 16
		add_child(npc)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



