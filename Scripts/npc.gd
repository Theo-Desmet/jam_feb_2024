extends Node2D

var velocity = Vector2.ZERO
var maxPos = Vector2(950, 250) #$Area/CollisionShape2D.position.x * 2
var npcType = 0
var animTime = 0

const texts = ["I have no idea why I'm here", "I love Paris", \
				"We want more fries in the canteen", "I hate cookies", \
				"I've lost my hat", "I am a good table", "Anyone want to be my friend ?", \
				"Beer is my life", "Yo what's up ?", "This life is a simulation", \
				"I think the earth is flat", "Ban pineapple pizzas", \
				"Stop cutting pasta", "My life is potato", "Never Gonna give you up"];

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
	elif position.x > maxPos.x:
		$Sprite.animation = move[1] + str(npcType)
		velocity.x = -1
		animTime = 85 + randi() % 10 
	elif position.y < 0:
		$Sprite.animation = move[3] + str(npcType)
		velocity.y = 1
		animTime = 85 + randi() % 10 
	elif direction == 0 or position.x < 5:
		$Sprite.animation = move[0] + str(npcType)
		velocity.x = 1
		animTime = randi() % 60 + 40
	elif direction == 1:
		$Sprite.animation = move[1] + str(npcType)
		velocity.x = -1
		animTime = randi() % 60 + 40
	elif direction == 2 or position.y > maxPos.y:
		$Sprite.animation = move[2] + str(npcType)
		velocity.y = -1
		animTime = randi() % 60 + 40
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


func _on_timer_timeout():
	var speech = randi_range(0, 43);
	if speech == 42 and !$Speech.visible:
		var r = randi_range(0, 6);
		await get_tree().create_timer(r).timeout;
		var t = randi_range(0, len(texts) - 1);
		$Speech.drawText(texts[t]);
