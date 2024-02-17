extends Node2D

var speed = 100
var screen_size = Vector2(1095, 502)
var last_input
var old_pos

func _ready():
	last_input = "right_stop"

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
		last_input = "right"
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		last_input = "left"
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		velocity.x -= 0.12
		last_input = "up"
	if Input.is_action_pressed("down"):
		velocity.y += 1
		velocity.x -= 0.12
		last_input = "down"
	if !Input.is_action_pressed("down") and !Input.is_action_pressed("up") and !Input.is_action_pressed("left") and !Input.is_action_pressed("right"):
		$body/sprite.animation = last_input + "_stop"
		velocity.x -= 0.12
		position += velocity * delta * speed
		position = position.clamp(Vector2.ZERO,screen_size)
	else:
		if position.x >= 1000 and position.y >= 220:
			if position.x < 1002 and velocity.x > 0:
				velocity.x = 0
			if position.y < 252 and velocity.y > 0:
				velocity.y = 0
		
		$body/sprite.animation = last_input
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			$body/sprite.play()	
		else:
			$body/sprite.play()

		position += velocity * delta
		position = position.clamp(Vector2.ZERO,screen_size)
		

