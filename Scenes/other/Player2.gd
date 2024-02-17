extends CharacterBody2D

const SPEED = 100.0
var lastDir = "";

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
	velocity.x -= 0.12 * SPEED;
	
	move_and_collide(velocity * delta);
	position = position.clamp(Vector2(8, 8),Vector2(1095, 502));
