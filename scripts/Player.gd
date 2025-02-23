extends CharacterBody2D

const MAX_SPEED = 400

var direction = Vector2i()
var speed = 0

var type
var grid

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

	# 2. Set speed
	if direction != Vector2i():
		speed = MAX_SPEED

	if grid.is_cell_vacant(get_position(), direction):
		var target_pos = grid.update_child_pos(self)
		set_position(target_pos)

	# 3. Set velocity
	# velocity = speed * direction.normalized() * delta

	# 4. Move
	# move_and_collide(velocity)
