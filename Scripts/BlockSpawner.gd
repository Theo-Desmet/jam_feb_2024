extends Node2D

var block1 = preload("res://Scenes/Blocks/Block1.1.tscn");
var block2 = preload("res://Scenes/Blocks/Block1.2.tscn");
var block3 = preload("res://Scenes/Blocks/Block1.3.tscn");
var block4 = preload("res://Scenes/Blocks/Block2.1.tscn");
var block5 = preload("res://Scenes/Blocks/Block2.2.tscn");
var block6 = preload("res://Scenes/Blocks/Block2.3.tscn");
var block7 = preload("res://Scenes/Blocks/Block3.1.tscn");
var block8 = preload("res://Scenes/Blocks/Block3.2.tscn");
var block9 = preload("res://Scenes/Blocks/Block3.3.tscn");
var block10 = preload("res://Scenes/Blocks/Block4.1.tscn");
var block11 = preload("res://Scenes/Blocks/Block5.1.tscn");
var block12 = preload("res://Scenes/Blocks/Block6.1.tscn");
var block13 = preload("res://Scenes/Blocks/Block6.2.tscn");
var block14 = preload("res://Scenes/Blocks/Block7.1.tscn");
var block15 = preload("res://Scenes/Blocks/Block7.2.tscn");
var block16 = preload("res://Scenes/Blocks/Block8.1.tscn");
var block17 = preload("res://Scenes/Blocks/Block8.2.tscn");
var block18 = preload("res://Scenes/Blocks/Block8.3.tscn");

# Called when the node enters the scene tree for the first time.

var blocks = [];
var renderedPos = [];

func _ready():
	blocks = [block1, block2, block3, block4, block5, block6, block7, block8, block9, block10, block11, block12, block13, block14, block15, block16, block17, block18];
	randomize();
	
	GlobalSignal.connect("BlockDestroyed", spawnBlockSignal);
	GlobalSignal.restartGame.connect(regenBlocks);
	
	var pos = Vector2i.ZERO;
	for i in range(5):
		spawnBlock(pos);
		pos.x += renderedPos[-1].x * 16;

func regenBlocks():
	for b in get_tree().get_nodes_in_group("blocks"):
		b.destroy();
	renderedPos.clear();
	var pos = Vector2i.ZERO;
	for i in range(5):
		spawnBlock(pos);
		pos.x += renderedPos[-1].x * 16;

func spawnBlockSignal():
	renderedPos.pop_at(0);
	var pos = 0;
	for i in range(len(renderedPos)):
		pos += renderedPos[i].x * 16;
	pos = pos - (pos % 16);
	spawnBlock(Vector2i(pos, 0));

func spawnBlock(pos):
	var r = randi_range(0, len(blocks) - 1);
	var block = blocks[r].instantiate();
	block.global_position = pos
	block.add_to_group("blocks");
	add_child(block);
	renderedPos.append(block.getSize());

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(renderedPos)
	pass
