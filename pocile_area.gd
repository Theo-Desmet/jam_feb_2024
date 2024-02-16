extends Node2D

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	var scene = preload("res://npc_police.tscn")
	var npc
	for i in range(25):
		npc = scene.instantiate()
		npc.position.x = randi() % 5 + 32
		npc.position.y = i * 16
		add_child(npc)
	for i in range(25):
		npc = scene.instantiate() 
		npc.position.x = randi() % 5 + 48
		npc.position.y = i * 16
		add_child(npc)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



