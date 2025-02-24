extends Node

class_name MovableGridElement

@onready var grid: Grid = get_node("/root/Game/Grid")
@onready var grid_element: Node2D = $".."

var is_moving = false
var is_processing_movement = false
var target_pos = Vector2i()
var target_direction = Vector2i()

const MAX_SPEED = 400
var speed = 0

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	if is_moving:
		move(delta)

func start_moving_in_direction(direction):
	if is_processing_movement:
		return

	is_processing_movement = true
	try_push_in_direction(direction)
	is_processing_movement = false

func try_push_in_direction(direction):
	target_direction = Vector2(direction)
	var grid_element_position = grid_element.get_position()

	# If next cell is empty, just move
	if grid.is_cell_in_direction_vacant(grid_element_position, target_direction):
		target_pos = grid.move_grid_element_in_direction(grid_element, direction)
		is_moving = true

		return true

	# If next cell is movable
	if grid.is_cell_in_direction_movable(grid_element_position, target_direction):
		# Get next cell, check if IT can move, recursively
		var next_grid_element_node = grid.get_node_in_direction(grid_element_position, target_direction)
		var movableGridElement = next_grid_element_node.get_node_or_null("MovableGridElement")
		var can_push = movableGridElement.try_push_in_direction(direction)

		return can_push

	return false

func move(delta):
	speed = MAX_SPEED
	var velocity = speed * target_direction * delta

	var pos = grid_element.get_position()
	var distance_to_target = Vector2(abs(target_pos.x - pos.x), abs(target_pos.y - pos.y))

	if abs(velocity.x) > distance_to_target.x:
		velocity.x = distance_to_target.x * target_direction.x
		stop_moving()
	if abs(velocity.y) > distance_to_target.y:
		velocity.y = distance_to_target.y * target_direction.y
		stop_moving()

	grid_element.move_and_collide(velocity)

func stop_moving():
	is_moving = false
