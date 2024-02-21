extends CharacterBody2D

var speed = 100.0
var lastDir = "";
var canMove = true;
#var canMove = false
var canInteract = false;
var currentActionInstance = null;
var initPos = Vector2(900, 350)
var isMovingX = false
var isMovingY = false

var footSound: Array
var winsHandling = {"obstacle": deleteInstance, "window": changeSprite,
	"trafficLight": changeSprite};
const texts = ["bebou c'est fix"]

var looseSound = preload("res://audio/looseGame.mp3")
var winSound = preload("res://audio/winGame.mp3")

func _ready():
	position = initPos

	footSound.append(preload("res://audio/foot/running1.mp3"))
	footSound.append(preload("res://audio/foot/running2.mp3"))
	footSound.append(preload("res://audio/foot/running3.mp3"))
	footSound.append(preload("res://audio/foot/running4.mp3"))
	footSound.append(preload("res://audio/foot/running5.mp3"))
	footSound.append(preload("res://audio/foot/running6.mp3"))
	footSound.append(preload("res://audio/foot/running7.mp3"))
	footSound.append(preload("res://audio/foot/running8.mp3"))
	footSound.append(preload("res://audio/foot/running9.mp3"))
	footSound.append(preload("res://audio/foot/running10.mp3"))
	footSound.append(preload("res://audio/foot/running11.mp3"))
	footSound.append(preload("res://audio/foot/running12.mp3"))
	footSound.append(preload("res://audio/foot/running13.mp3"))
	footSound.append(preload("res://audio/foot/running14.mp3"))
	footSound.append(preload("res://audio/foot/running15.mp3"))
	footSound.append(preload("res://audio/foot/running16.mp3"))
	footSound.append(preload("res://audio/foot/running17.mp3"))
	footSound.append(preload("res://audio/foot/running18.mp3"))
	footSound.append(preload("res://audio/foot/running19.mp3"))
	footSound.append(preload("res://audio/foot/running20.mp3"))
	
	GlobalSignal.ActionNearby.connect(actionNearby);
	GlobalSignal.ActionAway.connect(actionAway);
	GlobalSignal.SetPlayerMove.connect(setPlayerMove);
	GlobalSignal.restartGame.connect(restartPlayer)
	GlobalSignal.startGame.connect(startGame)
	GlobalSignal.ActionFinished.connect(actionFinished);

func deleteInstance():
	currentActionInstance.queue_free();
	
func changeSprite():
	currentActionInstance.changeSprite();

func actionFinished(winBool):
	print(currentActionInstance.infos);
	if !winBool:
		currentActionInstance = null;
		$win_loose.set_stream(looseSound)
		$win_loose.play()
		return;
	else:
		$win_loose.set_stream(winSound)
		$win_loose.play()
	if (!winsHandling.has(currentActionInstance.infos["type"])):
		return;
	winsHandling[currentActionInstance.infos["type"]].call();
	currentActionInstance = null;
	
func startGame():
	canMove = true
	
func restartPlayer():
	position = initPos

func setPlayerMove(status: bool):
	canMove = status;

func actionNearby(actionInstance):
	$ActionKey.visible = true;
	canInteract = true;
	currentActionInstance = actionInstance;
	
func actionAway():
	$ActionKey.visible = false;
	canInteract = false;

func _process(delta):
	var direction = Input.get_axis("left", "right");
	if direction:
		isMovingX = true
		velocity.x = direction * speed;
		if (direction == -1):
			lastDir = "left";
		else:
			lastDir = "right";

	else:
		isMovingX = false
		velocity.x = move_toward(velocity.x, 0, speed);
		
	var direction2 = Input.get_axis("up", "down");
	if direction2:
		isMovingY = true
		velocity.y = direction2 * speed;
		if (direction2 == 1):
			lastDir = "down";
		else:
			lastDir = "up";
	else:
		isMovingY = false
		velocity.y = move_toward(velocity.y, 0, speed);
	
	var animation = lastDir;
	if (!direction and !direction2):
		animation += "_stop";
	if animation != "_stop":
		$sprite.animation = animation;
		$sprite.play();
	#if (canMove):
	velocity.x -= 0.12 * speed;
	move_and_collide(velocity * delta);
	position = position.clamp(Vector2(8, 8),Vector2(1095, 502));

	if (Input.is_action_pressed("interact") and canInteract):
		GlobalSignal.OpenMiniGameContainer.emit(currentActionInstance);
		actionAway();
		canMove = false;
		currentActionInstance.disable();
		
	if (isMovingX == true or isMovingY == true) and canMove == true and $footstep.playing == false:
		var i = randi_range(0, 19)
		$footstep.set_stream(footSound[i])
		$footstep.play()
	
func _on_hud_player_speech():
	var t = randi_range(0, len(texts) - 1);
	$Speech.drawText(texts[t]);


func _on_hud_player_incognito_start():
	speed = 20


func _on_hud_player_incognito_end():
	speed = 100
