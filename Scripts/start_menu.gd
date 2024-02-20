extends CanvasLayer

func _on_play_button_pressed():
	GlobalSignal.startGame.emit()
	self.hide()
