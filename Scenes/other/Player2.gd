extends CharacterBody2D

const SPEED = 100.0
var lastDir = "";
var canMove = true;
var canInteract = false;
var currentActionInstance = null;

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
		velocity.x = direction * SPEED;
		if (direction == -1):
			lastDir = "left";
		else:
			lastDir = "right";

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED);
		
	var direction2 = Input.get_axis("up", "down");
	if direction2:
		velocity.y = direction2 * SPEED;
		if (direction2 == 1):
			lastDir = "down";
		else:
			lastDir = "up";
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED);
	
	var animation = lastDir;
	if (!direction and !direction2):
		animation += "_stop";
	if animation != "_stop":
		$sprite.animation = animation;
		$sprite.play();
	#velocity.x -= 0.12 * SPEED;
	if (canMove):
		move_and_collide(velocity * delta);
		position = position.clamp(Vector2(8, 8),Vector2(1095, 502));

	if (Input.is_action_pressed("interact") and canInteract):
		GlobalSignal.OpenMiniGameContainer.emit(currentActionInstance);
		actionAway();
		canMove = false;
		currentActionInstance.disable();
		currentActionInstance = null;
	
