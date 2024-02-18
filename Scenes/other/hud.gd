extends CanvasLayer

var score
var riotLevel
var policeLevel
var timeSec
var timeMin
var time

var container = preload("res://Scenes/Gui/MiniGameContainer.tscn");

# Called when the node enters the scene tree for the first time.
func _ready():
	timeMin = 5
	timeSec = 0	
	GlobalSignal.OpenMiniGameContainer.connect(miniGameContainer);

func miniGameContainer(instance):
	var c = container.instantiate();
	c.miniGameInfos = instance.getInfos();
	c.global_position.x = get_viewport().size.x / 2;
	c.global_position.y = get_viewport().size.y / 2;
	add_child(c);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	timeSec -= 1
	if timeSec < 0:
		timeSec = 59
		timeMin -= 1
		
	if timeMin < 10:
		time = "0" + str(timeMin) + ":"
	else:
		time = str(timeMin) + ":"
	if timeSec < 10:
		time += "0" + str(timeSec)
	else:
		time += str(timeSec)
	$timerLabel.text = time
