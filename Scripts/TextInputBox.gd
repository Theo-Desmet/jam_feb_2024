extends Node2D

# Called when the node enters the scene tree for the first time.

const words = ["pineapple", "surface", "coffee", "pursuit", "crimes", "legalize",\
 "hospital", "police", "legality", "equality", "freedom", "barrier", "routine", \
"justice", "opinion", "speaker", "intention"];

func _ready():
	randomize();
	var r = randi_range(0, len(words) - 1);
	$Label.text = words[r];

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_line_edit_text_changed(new_text):
	if (new_text == $Label.text):
		$LineEdit.editable = false;
		get_parent().wordCompleted.emit();
