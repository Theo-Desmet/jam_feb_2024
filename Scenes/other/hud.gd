extends CanvasLayer

var score = 0
var riotLevel = 1
var policeLevel = 0

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

func	updateScore(newPoint):
	var strScore = "Score:"
	var i = 1
	if riotLevel < 1.7:
		score += newPoint * int(riotLevel * 10) * 0.1
	else:
		score += newPoint * 2
	if score < 1000:
		strScore += "000"
	elif score < 10000:
		strScore += "00"
	elif score < 100000:
		strScore += "0"
	strScore += str(score)
	$scorePanel/score.text = strScore
	
func updateRiotLevel(newLevel):
	riotLevel += newLevel
	if riotLevel >= 1.8:
		riotLevel = 1.79
	if riotLevel <= 1.1:
		$LevelsBar/riot_bar/riot_cell1.value = int(((riotLevel - 1) * 1000)) % 100
		$LevelsBar/riot_bar/riot_cell2.value = 0
	if riotLevel > 1.1 and riotLevel <= 1.2:
		$LevelsBar/riot_bar/riot_cell1.value = 100
		$LevelsBar/riot_bar/riot_cell2.value = int(((riotLevel - 1) * 1000)) % 100
		$LevelsBar/riot_bar/riot_cell3.value = 0
		$LevelsBar/riot_bar/riotScore.text = "x1.1"
	if riotLevel > 1.2 and riotLevel <= 1.3:
		$LevelsBar/riot_bar/riot_cell2.value = 100
		$LevelsBar/riot_bar/riot_cell3.value = int(((riotLevel - 1) * 1000)) % 100
		$LevelsBar/riot_bar/riot_cell4.value = 0
		$LevelsBar/riot_bar/riotScore.text = "x1.2"
	if riotLevel > 1.3 and riotLevel <= 1.4:
		$LevelsBar/riot_bar/riot_cell3.value = 100
		$LevelsBar/riot_bar/riot_cell4.value = int(((riotLevel - 1) * 1000)) % 100
		$LevelsBar/riot_bar/riot_cell5.value = 0
		$LevelsBar/riot_bar/riotScore.text = "x1.3"
	if riotLevel > 1.4 and riotLevel <= 1.5:
		$LevelsBar/riot_bar/riot_cell4.value = 100
		$LevelsBar/riot_bar/riot_cell5.value = int(((riotLevel - 1) * 1000)) % 100
		$LevelsBar/riot_bar/riot_cell6.value = 0
		$LevelsBar/riot_bar/riotScore.text = "x1.4"
	if riotLevel > 1.5 and riotLevel <= 1.6:
		$LevelsBar/riot_bar/riot_cell5.value = 100
		$LevelsBar/riot_bar/riot_cell6.value = int(((riotLevel - 1) * 1000)) % 100
		$LevelsBar/riot_bar/riot_cell7.value = 0
		$LevelsBar/riot_bar/riotScore.text = "x1.5"
	if riotLevel > 1.6 and riotLevel <= 1.7:
		$LevelsBar/riot_bar/riot_cell6.value = 100
		$LevelsBar/riot_bar/riot_cell7.value = int(((riotLevel - 1) * 1000)) % 100
		$LevelsBar/riot_bar/riotScore.text = "x1.6"
	if riotLevel > 1.7 and riotLevel <= 1.8:
		$LevelsBar/riot_bar/riot_cell7.value = 100
		$LevelsBar/riot_bar/riotScore.text = "x2.0"

func updatePoliceLevel(newLevel):
	print(policeLevel)
	policeLevel += newLevel
	if policeLevel < 0:
		policeLevel = 0
	if policeLevel > 7:
		policeLevel = 7
	if policeLevel == 0:
		$LevelsBar/police_bar/police_cell1.hide()		
	if policeLevel > 0:
		$LevelsBar/police_bar/police_cell1.show()
		$LevelsBar/police_bar/police_cell2.hide()
	if policeLevel > 1:
		$LevelsBar/police_bar/police_cell2.show()
		$LevelsBar/police_bar/police_cell3.hide()
	if policeLevel > 2:
		$LevelsBar/police_bar/police_cell3.show()
		$LevelsBar/police_bar/police_cell4.hide()
	if policeLevel > 3:
		$LevelsBar/police_bar/police_cell4.show()
		$LevelsBar/police_bar/police_cell5.hide()
	if policeLevel > 4:
		$LevelsBar/police_bar/police_cell5.show()
		$LevelsBar/police_bar/police_cell6.hide()
	if policeLevel > 5:
		$LevelsBar/police_bar/police_cell6.show()
		$LevelsBar/police_bar/police_cell7.hide()
	if policeLevel > 6:
		$LevelsBar/police_bar/police_cell7.show()
		
func _process(delta):
	if Input.is_action_just_released("score++"):
		updateScore(500)
	if Input.is_action_just_released("riot++"):
		updateRiotLevel(0.025)
	if Input.is_action_just_released("police++"):
		updatePoliceLevel(1)
	if Input.is_action_just_released("police--"):
		updatePoliceLevel(-1)
		
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
	if riotLevel > 1:
		updateRiotLevel(-0.01 )
	
