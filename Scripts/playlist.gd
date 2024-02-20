extends Node

var music: Array

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $music.playing == false:
		var i = randi_range(0, 8)
		$music.set_stream(music[i])
		$music.play()
