extends CanvasLayer

func _on_exit_pressed():
	get_tree().quit()

func _on_restart_pressed():
	GlobalSignal.restartGame.emit()

func _on_hud_end_game(score):
	$score.text = str(score)
