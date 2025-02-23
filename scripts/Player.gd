extends CharacterBody2D

const MAX_SPEED = 400

var direction = Vector2i()
var speed = 0

var type
var grid

var is_moving = false
var target_pos = Vector2i()
var target_direction = Vector2i()

func _ready():
	grid = get_parent() as TileMap

	type = grid.ENTITY_TYPES.PLAYER
	set_physics_process(true)

func _physics_process(delta):
	direction = Vector2i()
	speed = 0

	# 1. Detect input, set direction
	if Input.is_action_pressed("move_up"):
		direction = Vector2i.UP
	elif Input.is_action_pressed("move_down"):
		direction = Vector2i.DOWN
	elif Input.is_action_pressed("move_left"):
		direction = Vector2i.LEFT
	elif Input.is_action_pressed("move_right"):
		direction = Vector2i.RIGHT

	if not is_moving and direction != Vector2i():
		target_direction = direction

		if grid.is_cell_vacant(get_position(), target_direction):
			target_pos = grid.update_child_pos(self)
			is_moving = true

	elif is_moving:
		speed = MAX_SPEED
		velocity = speed * target_direction * delta

		var pos = get_position()
		var distance_to_target = Vector2(abs(target_pos.x - pos.x), abs(target_pos.y - pos.y))

		if abs(velocity.x) > distance_to_target.x:
			velocity.x = distance_to_target.x * target_direction.x
			is_moving = false
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = distance_to_target.y * target_direction.y
			is_moving = false

		move_and_collide(velocity)
