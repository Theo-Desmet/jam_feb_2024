extends CharacterBody2D

var speed = 100.0
var lastDir = "";
var canMove = true;
var canInteract = false;
var currentActionInstance = null;

const texts = ["bebou c'est fix"]

func _ready():
	GlobalSignal.ActionNearby.connect(actionNearby);
	GlobalSignal.ActionAway.connect(actionAway);
	GlobalSignal.SetPlayerMove.connect(setPlayerMove);

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
		velocity.x = direction * speed;
		if (direction == -1):
			lastDir = "left";
		else:
			lastDir = "right";

	else:
		velocity.x = move_toward(velocity.x, 0, speed);
		
	var direction2 = Input.get_axis("up", "down");
	if direction2:
		velocity.y = direction2 * speed;
		if (direction2 == 1):
			lastDir = "down";
		else:
			lastDir = "up";
	else:
		velocity.y = move_toward(velocity.y, 0, speed);
	
	var animation = lastDir;
	if (!direction and !direction2):
		animation += "_stop";
	if animation != "_stop":
		$sprite.animation = animation;
		$sprite.play();
	#velocity.x -= 0.12 * speed;
	if (canMove):
		move_and_collide(velocity * delta);
		position = position.clamp(Vector2(8, 8),Vector2(1095, 502));

	if (Input.is_action_pressed("interact") and canInteract):
		GlobalSignal.OpenMiniGameContainer.emit(currentActionInstance);
		actionAway();
		canMove = false;
		currentActionInstance.disable();
		currentActionInstance = null;
	
func _on_hud_player_speech():
	var t = randi_range(0, len(texts) - 1);
	$Speech.drawText(texts[t]);


func _on_hud_player_incognito_start():
	speed = 5


func _on_hud_player_incognito_end():
	speed = 100
