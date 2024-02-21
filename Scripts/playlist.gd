extends Node

var music: Array
var i
var userStop = false
# Called when the node enters the scene tree for the first time.
func _ready():
	music.append(preload("res://audio/playlist/energetic-indie-rock-jump-112179.mp3"))
	music.append(preload("res://audio/playlist/epic-metal-dubstep-cinematic-144716.mp3"))
	music.append(preload("res://audio/playlist/inspiring-motivational-rock-inspire-mesenses-111448.mp3"))
	music.append(preload("res://audio/playlist/melodic-metal-186403.mp3"))
	music.append(preload("res://audio/playlist/powerful-action-indie-rock-184604.mp3"))
	music.append(preload("res://audio/playlist/quick-strike-190739.mp3"))
	music.append(preload("res://audio/playlist/rockstar-trailer-109945.mp3"))
	music.append(preload("res://audio/playlist/speed-thrill-beat-190669.mp3"))
	music.append(preload("res://audio/playlist/we-made-it-promo-indie-rock-190174.mp3"))
	
	i = randi_range(0, 7)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $music.playing == false and userStop == false:
		if i < 0:
			i = 7
		elif i > 7:
			i = 0
		$music.set_stream(music[i])
		$music.play()
		i += 1


func _on_hud_next_music():
	i += 1
	if i > 7:
		i = 0
	$music.set_stream(music[i])
	$music.play()


func _on_hud_previous_music():
	i -= 1
	if i < 0:
		i = 7
	$music.set_stream(music[i])
	$music.play()


func _on_hud_stop_music():
	print("aled")
	if $music.playing == true:
		$music.stream_paused = true
		userStop = true
	else:
		$music.stream_paused = false
		userStop = false
