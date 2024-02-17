extends Node2D

func _ready():
	pass;

func drawText(text):
	visible = true;
	for l in text:
		$VBoxContainer/Label.text += l;
		await get_tree().create_timer(0.1).timeout;
	await get_tree().create_timer(3).timeout;
	for l in text:
		$VBoxContainer/Label.text = $VBoxContainer/Label.text.left($VBoxContainer/Label.text.length() - 1);
		await get_tree().create_timer(0.1).timeout;
	visible = false;
