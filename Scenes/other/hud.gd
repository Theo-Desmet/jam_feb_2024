extends CanvasLayer

signal playerSpeech
signal playerIncognitoStart
signal playerIncognitoEnd
signal endGame
signal nextMusic
signal previousMusic
signal stopMusic

var score
var riotLevel = 1
var policeLevel = 0

var isInRiotArea

var megaphoneUse
var megaphoneValue
var megaphoneSpeed = 20
var megaphoneUseSpeed = 5

var incognitoUse
var incognitoValue
var incognitoSpeed = 20
var incognitoUseSpeed = 6

var timeSec
var timeMin
var time

var sound: Array
var isMusicPlaying = true
var container = preload("res://Scenes/Gui/MiniGameContainer.tscn");
var musicIcon = preload("res://asset/gui/musicNote.png")
var noMusicIcon = preload("res://asset/gui/noMusicNote.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	sound.append(preload("res://audio/usePowerUp.mp3"))
	sound.append(preload("res://audio/cantUsePowerUp.mp3"))
	isInRiotArea = 0
	megaphoneUse = 0
	incognitoUse = 0
	megaphoneValue = 100
	incognitoValue = 100
	score = 0
	timeMin = 5
	timeSec = 0
	GlobalSignal.OpenMiniGameContainer.connect(miniGameContainer);
	GlobalSignal.restartGame.connect(restartHUD)
	GlobalSignal.startGame.connect(startGame)
	GlobalSignal.UpdateScore.connect(updateScore);
	GlobalSignal.UpdateRiotLevel.connect(updateRiotLevel);
	GlobalSignal.UpdatePoliceLevel.connect(updatePoliceLevel);
	GlobalSignal.ResetRiotLevel.connect(restartRiotLevel);

func miniGameContainer(instance):
	var c = container.instantiate();
	c.miniGameInfos = instance.getInfos();
	c.global_position.x = get_viewport().size.x / 2;
	c.global_position.y = get_viewport().size.y / 2;
	add_child(c);

func startGame():
	$Timer.start()
	self.show()

func restartHUD():
	score = 0
	isInRiotArea = 0
	megaphoneUse = 0
	incognitoUse = 0
	megaphoneValue = 100
	incognitoValue = 100
	timeMin = 5
	timeSec = 0
	restartScore()
	restartRiotLevel()
	restartPoliceLevel()
	UpdateMegaphone()
	UpdateIncognito()
	$Timer.start()
	$endGameMenu.hide()

func restartScore():
	$scorePanel/score.text = "Score:000000"

func restartRiotLevel():
	riotLevel = 1
	$LevelsBar/riot_bar/riotScore.text = "x1.0"
	$LevelsBar/riot_bar/riot_cell1.value = 0
	$LevelsBar/riot_bar/riot_cell2.value = 0
	$LevelsBar/riot_bar/riot_cell3.value = 0
	$LevelsBar/riot_bar/riot_cell4.value = 0
	$LevelsBar/riot_bar/riot_cell5.value = 0
	$LevelsBar/riot_bar/riot_cell6.value = 0
	$LevelsBar/riot_bar/riot_cell7.value = 0

func restartPoliceLevel():
	policeLevel = 0
	$LevelsBar/police_bar/police_cell1.hide()
	$LevelsBar/police_bar/police_cell2.hide()
	$LevelsBar/police_bar/police_cell3.hide()
	$LevelsBar/police_bar/police_cell4.hide()
	$LevelsBar/police_bar/police_cell5.hide()
	$LevelsBar/police_bar/police_cell6.hide()
	$LevelsBar/police_bar/police_cell7.hide()

func	updateScore(newPoint):
	var strScore = "Score:"
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
	var riotCellValue = int(((riotLevel - 1) * 1000))
	if riotLevel >= 1.8:
		riotLevel = 1.79
	if riotLevel <= 1.1:
		$LevelsBar/riot_bar/riot_cell1.value = riotCellValue 
		$LevelsBar/riot_bar/riot_cell2.value = 0
	if riotLevel > 1.1 and riotLevel <= 1.2:
		$LevelsBar/riot_bar/riot_cell1.value = 100
		$LevelsBar/riot_bar/riot_cell2.value = riotCellValue - 100
		$LevelsBar/riot_bar/riot_cell3.value = 0
		$LevelsBar/riot_bar/riotScore.text = "x1.1"
	if riotLevel > 1.2 and riotLevel <= 1.3:
		$LevelsBar/riot_bar/riot_cell2.value = 100
		$LevelsBar/riot_bar/riot_cell3.value = riotCellValue - 200
		$LevelsBar/riot_bar/riot_cell4.value = 0
		$LevelsBar/riot_bar/riotScore.text = "x1.2"
	if riotLevel > 1.3 and riotLevel <= 1.4:
		$LevelsBar/riot_bar/riot_cell3.value = 100
		$LevelsBar/riot_bar/riot_cell4.value = riotCellValue - 300
		$LevelsBar/riot_bar/riot_cell5.value = 0
		$LevelsBar/riot_bar/riotScore.text = "x1.3"
	if riotLevel > 1.4 and riotLevel <= 1.5:
		$LevelsBar/riot_bar/riot_cell4.value = 100
		$LevelsBar/riot_bar/riot_cell5.value = riotCellValue - 400
		$LevelsBar/riot_bar/riot_cell6.value = 0
		$LevelsBar/riot_bar/riotScore.text = "x1.4"
	if riotLevel > 1.5 and riotLevel <= 1.6:
		$LevelsBar/riot_bar/riot_cell5.value = 100
		$LevelsBar/riot_bar/riot_cell6.value = riotCellValue - 500
		$LevelsBar/riot_bar/riot_cell7.value = 0
		$LevelsBar/riot_bar/riotScore.text = "x1.5"
	if riotLevel > 1.6 and riotLevel <= 1.7:
		$LevelsBar/riot_bar/riot_cell6.value = 100
		$LevelsBar/riot_bar/riot_cell7.value = riotCellValue - 600
		$LevelsBar/riot_bar/riotScore.text = "x1.6"
	if riotLevel > 1.7 and riotLevel <= 1.8:
		$LevelsBar/riot_bar/riot_cell7.value = 100
		$LevelsBar/riot_bar/riotScore.text = "x2.0"

func updatePoliceLevel(newLevel):
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
		
func _process(_delta):
	if Input.is_action_just_released("score++"):
		updateScore(500)
	if Input.is_action_just_released("riot++"):
		updateRiotLevel(0.025)
	if Input.is_action_just_released("police++"):
		updatePoliceLevel(1)
	if Input.is_action_just_released("police--"):
		updatePoliceLevel(-1)
	if Input.is_action_just_pressed("megaphone"):
		useMegaphone()
	if Input.is_action_just_pressed("incognito"):
		useIncognito()
	
func _on_timer_timeout():
	timeSec -= 1
	if timeMin == 0 and timeSec == 0:
		ft_endGame()
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
	UpdateMegaphone()
	UpdateIncognito()
		
func UpdateMegaphone():
	if megaphoneValue > 0 and megaphoneUse == 0:
		@warning_ignore("integer_division")
		megaphoneValue -= 100 / megaphoneSpeed
		$powersUp/megaphone/overBar.value = megaphoneValue
	elif megaphoneValue > 0 and megaphoneUse == 1:
		@warning_ignore("integer_division")
		megaphoneValue -= 100 / megaphoneUseSpeed
		$powersUp/megaphone/useOverBar.value = megaphoneValue
		if isInRiotArea == 1:
			megaphoneEffect()
	elif megaphoneValue <= 0 and megaphoneUse == 1:
		megaphoneValue = 100
		megaphoneUse = 0
		$powersUp/megaphone/overBar.value = 100
		
	if isInRiotArea == 0 or incognitoUse == 1:
		$powersUp/megaphone/overOutArea.show()
	else:
		$powersUp/megaphone/overOutArea.hide()
	
		
func useMegaphone():
	if incognitoUse == 0 and megaphoneUse == 0 and megaphoneValue <= 0 and isInRiotArea == 1:
		megaphoneUse = 1
		megaphoneValue = 100
		$powersUp/megaphone/useOverBar.value = 100
		playerSpeech.emit()
		$usePowerUp.set_stream(sound[0])
		$usePowerUp.play()
		megaphoneEffect()
	else:
		$usePowerUp.set_stream(sound[1])
		$usePowerUp.play()

func megaphoneEffect():
	updateRiotLevel(0.05)
	
func UpdateIncognito():
	if incognitoValue > 0 and incognitoUse == 0:
		@warning_ignore("integer_division")
		incognitoValue -= 100 / incognitoSpeed
		$powersUp/incognito/overBar.value = incognitoValue
	elif incognitoUse == 1 and (isInRiotArea == 0 or incognitoValue <= 0):
		incognitoValue = 100
		incognitoUse = 0
		$powersUp/incognito/useOverBar.value = 0
		$powersUp/incognito/overBar.value = 100
		playerIncognitoEnd.emit()
	elif incognitoValue > 0 and incognitoUse == 1:
		@warning_ignore("integer_division")
		incognitoValue -= 100 / incognitoUseSpeed
		$powersUp/incognito/useOverBar.value = incognitoValue
		incognitoEffect()
	
		
	if isInRiotArea == 0 or megaphoneUse == 1:
		$powersUp/incognito/overOutArea.show()
	else:
		$powersUp/incognito/overOutArea.hide()
	
func useIncognito():
	if megaphoneUse == 0 and incognitoUse == 0 and incognitoValue <= 0 and isInRiotArea == 1:
		incognitoUse = 1
		incognitoValue = 100
		$powersUp/incognito/useOverBar.value = 100
		playerIncognitoStart.emit()
		$usePowerUp.set_stream(sound[0])
		$usePowerUp.play()
		incognitoEffect()
	else:
		$usePowerUp.set_stream(sound[1])
		$usePowerUp.play()
		
func incognitoEffect():
	updatePoliceLevel(-0.5)

func ft_endGame():
	$Timer.stop()
	$endGameMenu.show()
	endGame.emit(score)

func _on_riot_arena_player_enter_riot_area():
	isInRiotArea = 1
	UpdateMegaphone()
	UpdateIncognito()

func _on_riot_arena_player_exit_riot_area():
	isInRiotArea = 0
	UpdateMegaphone()
	UpdateIncognito()

func _on_end_game_menu_restart_game():
	pass # Replace with function body.

func _on_right_arrow_pressed():
	nextMusic.emit()
	$rightArrow.release_focus()

func _on_music_note_pressed():
	stopMusic.emit()
	if isMusicPlaying == true:
		$musicNote.set_button_icon(noMusicIcon)
		isMusicPlaying = false
	else:
		$musicNote.set_button_icon(musicIcon)
		isMusicPlaying = true
	$musicNote.release_focus()

func _on_left_arrow_pressed():
	previousMusic.emit()
	$leftArrow.release_focus()
