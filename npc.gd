extends Node2D

var velocity = Vector2.ZERO
var maxPos = Vector2(950, 340) #$Area/CollisionShape2D.position.x * 2
var npcType = 0
var animTime = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.ZERO
	npcType = randi() % 5
	$Sprite.animation = "right" + str(npcType)
	$Sprite.play()


func	moveNpc(delta):
	var velocity = Vector2.ZERO
	var speed = 300
	var move = ["right", "left", "up", "down"]
	var direction = randi() % 30

	if animTime < 100:
		animTime += 1
	elif direction == 0 or position.x < 5:
		$Sprite.animation = move[0] + str(npcType)
		velocity.x = 1
		animTime = randi() % 90 + 10
	elif direction == 1 or position.x > maxPos.x:
		$Sprite.animation = move[1] + str(npcType)
		velocity.x = -1
		animTime = randi() % 80 + 20
	elif direction == 2 or position.y > maxPos.y:
		$Sprite.animation = move[2] + str(npcType)
		velocity.y = -1
		animTime = randi() % 80 + 20
	elif direction == 3 or position.y < 0:
		$Sprite.animation = move[3] + str(npcType)
		velocity.y = 1
		animTime = randi() % 80 + 20
	else:
		animTime = randi() % 80 + 20
		$Sprite.animation = move[0] + str(npcType)
	
	position += velocity * speed * delta
	#position = position.clamp(Vector2.ZERO, maxPos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	moveNpc(delta)
