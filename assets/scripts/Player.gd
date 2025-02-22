extends CharacterBody2D

const MAX_SPEED = 400

var direction = Vector2()
var speed = 0

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	direction = Vector2()
	speed = 0

	if Input.is_action_pressed("move_up"):
		direction = Vector2.UP
	elif Input.is_action_pressed("move_down"):
		direction = Vector2.DOWN
	elif Input.is_action_pressed("move_left"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("move_right"):
		direction = Vector2.RIGHT

	if direction != Vector2():
		speed = MAX_SPEED

	velocity = speed * direction.normalized() * delta

	move_and_collide(velocity)
