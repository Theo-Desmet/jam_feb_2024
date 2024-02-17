extends Node2D

var block1 = preload("res://Scenes/Blocks/Block1.tscn");
var block2 = preload("res://Scenes/Blocks/Block2.tscn");
var block3 = preload("res://Scenes/Blocks/Block3.tscn");
var block4 = preload("res://Scenes/Blocks/Block4.tscn");
var block5 = preload("res://Scenes/Blocks/Block5.tscn");
var block6 = preload("res://Scenes/Blocks/Block6.tscn");
var block7 = preload("res://Scenes/Blocks/Block7.tscn");
var block8 = preload("res://Scenes/Blocks/Block8.tscn");
# Called when the node enters the scene tree for the first time.

var blocks = [];
var lastId = 0;
var renderedPos = [];

func _ready():
	blocks = [block1, block2, block3, block4, block5, block6, block7, block8];
	randomize();
	
	GlobalSignal.connect("BlockDestroyed", spawnBlockSignal);
	var pos = Vector2i.ZERO;
	for i in range(5):
		spawnBlock(pos);
		pos.x += renderedPos[-1].x * 16;

func spawnBlockSignal():
	renderedPos.pop_at(0);
	var pos = 0;
	for i in range(len(renderedPos)):
		pos += renderedPos[i].x * 16;
	pos = pos - (pos % 16)
	spawnBlock(Vector2i(pos, 0));

func spawnBlock(pos):
	var r = randi_range(0, len(blocks) - 1);
	var block = blocks[r].instantiate();
	print(pos, ' ', r);
	block.global_position = pos
	add_child(block);
	renderedPos.append(block.getSize());

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(renderedPos)
	pass
