extends Node2D

var velocity = Vector2.ZERO
var maxPos = Vector2(700, 340) #$Area/CollisionShape2D.position.x * 2
var npcType
var animTime = 0

const texts = ["keep calm", "stay back", "Go back", "Don't push"

	, "This riot is not autorize", "You are a shame", "Don't go futher", "We have weapons"
	, "We are the autority", "KILL KILL KILL", "Oups I lost my weapon", "*atchoum*", "Son's ?"]

# Called when the node enters the scene tree for the first time.
func _ready():
	#velocity = Vector2.ZERO
	#npcType = randi() % 5
	npcType = randi_range(1, 3)
	$body/sprite.animation = "left" + str(npcType)
	$body/sprite.play()

func _integrate_forces(state):
	var vel = state.get_linear_velocity ()
	state.set_linear_velocity (Vector2 (0, 0))

func	moveNpc(delta):
	var velocity = Vector2.ZERO
	var speed = 300
	var move = ["right", "left", "up", "down"]
	var direction = randi() % 30

	if animTime < 100:
		animTime += 1
	elif direction == 0:
		$body/Sprite.animation = move[0] + str(npcType)
		velocity.x = 1
		animTime = randi() % 90 + 10
	elif direction == 1:
		$body/Sprite.animation = move[1] + str(npcType)
		velocity.x = -1
		animTime = randi() % 80 + 20
	elif direction == 2:
		$body/Sprite.animation = move[2] + str(npcType)
		velocity.y = -1
		animTime = randi() % 80 + 20
	elif direction == 3:
		$body/Sprite.animation = move[3] + str(npcType)
		velocity.y = 1
		animTime = randi() % 80 + 20
	else:
		animTime = randi() % 80 + 20
		$body/Sprite.animation = move[0] + str(npcType)
	
	position += velocity * speed * delta
	position = position.clamp(Vector2.ZERO, maxPos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var speech = randi_range(0, 100);
	if speech == 42 and !$Speech.visible:
		var r = randi_range(0, 6);
		await get_tree().create_timer(r).timeout;
		var t = randi_range(0, len(texts) - 1);
		$Speech.drawText(texts[t]);
