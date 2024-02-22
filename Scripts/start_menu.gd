extends CanvasLayer

var page = 0;
var oldPage = 0;
var curPage;
var texts = [];

func _ready():
	curPage = $Presentation;
	texts = [$Presentation, $Riot, $Police];
	$leftArrow.self_modulate.a = 0.5;
	$leftArrow.disabled = true;

func _on_play_button_pressed():
	GlobalSignal.startGame.emit()
	$clickSound.play()
	self.hide()

func _process(_delta):
	if !page:
		$leftArrow.self_modulate.a = 0.5;
		$leftArrow.disabled = true;
	elif page == 2:
		$rightArrow.self_modulate.a = 0.5;
		$rightArrow.disabled = true;
	else:
		$rightArrow.self_modulate.a = 1;
		$rightArrow.disabled = false;
		$leftArrow.self_modulate.a = 1;
		$leftArrow.disabled = false;
	if oldPage != page:
		oldPage = page;
		curPage.visible = false;
		curPage = texts[page];
		curPage.visible = true;


func _on_right_arrow_pressed():
	page += 1;
	page = clamp(page, 0, 2);


func _on_left_arrow_pressed():
	page -= 1;
	page = clamp(page, 0, 2);
