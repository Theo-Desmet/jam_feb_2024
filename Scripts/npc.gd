extends RigidBody2D

var velocity = Vector2.ZERO
var maxPos = Vector2(950, 240) #$Area/CollisionShape2D.position.x * 2
var npcType = 0
var animTime
var direction
var oldVelocity

const texts = ["I have no idea why I'm here", "I love Paris", \
				"We want more fries in the canteen", "I hate cookies", \
				"I've lost my hat", "I am a good table", "Anyone want to be my friend ?", \
				"Beer is my life", "Yo what's up ?", "This life is a simulation", \
				"I think the earth is flat", "Ban pineapple pizzas", \
				"Stop cutting pasta", "My life is potato", "Never Gonna give you up"];

# Called when the node enters the scene tree for the first time.
func _ready():
	animTime = randi_range(1, 10)
	velocity = Vector2.ZERO
	npcType = randi() % 10
	$Sprite.animation = "right" + str(npcType)
	$Sprite.play()

func	moveNpc(delta):
	var velocity = Vector2.ZERO
	var speed = 300
	var move = ["right", "left", "up", "down"]
	direction = randi_range(0, 200)
	oldVelocity = Vector2.ZERO
	
	if animTime < 25:
		animTime += 1
	elif direction in range(0, 5):
		$Sprite.animation = move[0] + str(npcType)
		velocity.x = 1
		animTime = randi_range(1, 10)
		if position.x >= 950:
			velocity.x = -1
		oldVelocity = velocity
	elif direction in range(5, 10):
		$Sprite.animation = move[1] + str(npcType)
		velocity.x = -1
		animTime = randi_range(1, 10)
		if position.x <= 5:
			velocity.x = 1
		oldVelocity = velocity
	elif direction in range(10, 20):
		$Sprite.animation = move[2] + str(npcType)
		velocity.y = -1
		animTime = randi_range(1, 10)
		if position.y <= 5:
			velocity.y = 1
		oldVelocity = velocity
	elif direction in range(20, 30):
		$Sprite.animation = move[3] + str(npcType)
		velocity.y = 1
		animTime = randi_range(1, 10)
		if position.y >= 240:
			velocity.y = -1
		oldVelocity = velocity
	elif direction in range(30, 100):
		velocity = oldVelocity
	else:
		animTime = randi_range(1, 10)
		$Sprite.animation = move[0] + str(npcType)
	
	position += velocity * speed * delta

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
