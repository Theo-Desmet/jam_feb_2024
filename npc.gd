extends Node2D

var velocity = Vector2.ZERO
var maxPos = Vector2(700, 340) #$Area/CollisionShape2D.position.x * 2
var npcType = 0
var animTime = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.ZERO
	npcType = randi() % 5
	$body/Sprite.animation = "right" + str(npcType)
	$body/Sprite.play()


func	moveNpc(delta):
	var velocity = Vector2.ZERO
	var speed = 300
	var move = ["right", "left", "up", "down"]
	var direction = randi() % 30

	if animTime < 10:
		animTime += 1
	elif direction == 0:
		$body/Sprite.animation = move[0] + str(npcType)
		velocity.x = 1
		animTime = 0
	elif direction == 1:
		$body/Sprite.animation = move[1] + str(npcType)
		velocity.x = -1
		animTime = 0
	elif direction == 2:
		$body/Sprite.animation = move[2] + str(npcType)
		velocity.y = -1
		animTime = 0
	elif direction == 3:
		$body/Sprite.animation = move[3] + str(npcType)
		velocity.y = 1
		animTime = 0
	else:
		animTime = 0
		$body/Sprite.animation = move[0] + str(npcType)
	
	position += velocity * speed * delta
	position = position.clamp(Vector2.ZERO, maxPos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	moveNpc(delta)
