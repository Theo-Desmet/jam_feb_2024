extends Node2D

var speed = 100
var screen_size
var last_input
var old_pos

func _ready():
	last_input = "right_stop"
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
		last_input = "right_stop"
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		last_input = "left_stop"
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		last_input = "up_stop"
	if Input.is_action_pressed("down"):
		velocity.y += 1
		last_input = "down_stop"
	if !Input.is_action_pressed("down") and !Input.is_action_pressed("up") and !Input.is_action_pressed("left") and !Input.is_action_pressed("right"):
		$body/sprite.animation = last_input
		velocity.x -= 0.1
		position += velocity * delta * speed
		position = position.clamp(Vector2.ZERO,screen_size)
	else:
		if position.x >= 1000 and position.y >= 320:
			if position.x < 1002 and velocity.x > 0:
				velocity.x = 0
			if position.y < 322 and velocity.y > 0:
				velocity.y = 0
				
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			$body/sprite.play()	
		else:
			$body/sprite.play()

		position += velocity * delta
		position = position.clamp(Vector2.ZERO,screen_size)
		
		if velocity.x > 0:
			$body/sprite.animation = "right"
		elif velocity.x < 0:
			$body/sprite.animation = "left"
		elif velocity.y > 0:
			$body/sprite.animation = "down"
		elif velocity.y < 0:
			$body/sprite.animation = "up"	
