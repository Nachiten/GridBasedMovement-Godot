extends CharacterBody2D

class_name Player

@onready var movable_grid_element: MovableGridElement = $MovableGridElement
@onready var grid: Grid = %Grid

var move_direction = Vector2i()
var type
var is_processing_movement = false

func _ready():
	type = grid.ENTITY_TYPES.PLAYER
	set_physics_process(true)

func _physics_process(delta):
	move_direction = Vector2i()

	# Detect input, set move_direction
	if Input.is_action_pressed("move_up"):
		move_direction = Vector2i.UP
	elif Input.is_action_pressed("move_down"):
		move_direction = Vector2i.DOWN
	elif Input.is_action_pressed("move_left"):
		move_direction = Vector2i.LEFT
	elif Input.is_action_pressed("move_right"):
		move_direction = Vector2i.RIGHT

	# If not moving, and pressed some key, start moving
	if not movable_grid_element.is_moving and move_direction != Vector2i():
		if is_processing_movement:
			return

		is_processing_movement = true
		movable_grid_element.start_moving_in_direction(move_direction)
		is_processing_movement = false
