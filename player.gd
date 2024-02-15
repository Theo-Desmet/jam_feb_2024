extends Node2D

var speed = 100
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1

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

