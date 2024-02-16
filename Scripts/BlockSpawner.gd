extends Node2D

var block1 = preload("res://Scenes/Blocks/Block1.tscn");
var block2 = preload("res://Scenes/Blocks/Block2.tscn");
var block3 = preload("res://Scenes/Blocks/Block3.tscn");
# Called when the node enters the scene tree for the first time.

var blocks = [];
var lastId = 0;
var renderedPos = [];

func _ready():
	randomize();
	blocks.append(block1);
	blocks.append(block2);
	blocks.append(block3);
	GlobalSignal.connect("BlockDestroyed", spawnBlockSignal);
	spawnBlock(Vector2i(0, 0));
	spawnBlock(Vector2i(renderedPos[0].x * 16, 0));
	spawnBlock(Vector2i((renderedPos[0].x * 16) + (renderedPos[1].x * 16), 0));
	spawnBlock(Vector2i((renderedPos[0].x * 16) + (renderedPos[1].x * 16) + (renderedPos[2].x * 16), 0));
	spawnBlock(Vector2i((renderedPos[0].x * 16) + (renderedPos[1].x * 16)\
	 + (renderedPos[2].x * 16) + (renderedPos[3].x * 16), 0));

func spawnBlockSignal():
	renderedPos.pop_at(0);
	var pos = 0;
	for i in range(len(renderedPos)):
		pos += renderedPos[i].x * 16;
	spawnBlock(Vector2i(pos, 0));

func spawnFirstBlocks():
	pass


func spawnBlock(pos):
	print(pos);
	var r = randi_range(0, 2);
	var block = blocks[r].instantiate();
	block.global_position = pos
	add_child(block);
	renderedPos.append(block.getSize());

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(renderedPos)
	pass
