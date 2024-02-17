extends Node2D

func _ready():
	pass;

func drawText(text):
	var r = randi_range(0, 6);
	await get_tree().create_timer(r).timeout;
	visible = true;
	for l in text:
		$VBoxContainer/Label.text += l;
		await get_tree().create_timer(0.04).timeout;
	await get_tree().create_timer(2).timeout;
	for l in text:
		$VBoxContainer/Label.text = $VBoxContainer/Label.text.left($VBoxContainer/Label.text.length() - 1);
		await get_tree().create_timer(0.02).timeout;
	visible = false;
