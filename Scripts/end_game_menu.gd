extends CanvasLayer

func _on_exit_pressed():
	$menuClick. play()
	get_tree().quit()

func _on_restart_pressed():
	$menuClick. play()
	GlobalSignal.restartGame.emit()

func _on_hud_end_game(score):
	$score.text = str(score)
