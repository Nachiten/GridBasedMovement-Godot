extends TileMap

const GRID_SIZE = Vector2i(10, 10)

var tile_size = tile_set.tile_size.x
var half_tile_size = tile_size / 2.0
var grid = []

const obstacle = preload("res://scenes/Obstacle.tscn")
@onready var player: CharacterBody2D = $Player

enum ENTITY_TYPES {PLAYER, OBSTACLE, COLLECTIBLE}

func _ready():
	# 1. Create the grid Array
	for x in range(GRID_SIZE.x):
		grid.append([])
		for y in range(GRID_SIZE.y):
			grid[x].append(null)

	# 2. Snap player to the grid
	var start_pos = update_child_pos(player)
	player.set_position(start_pos)

	# 3. Create obstacle positions
	var positions = []
	for n in range(5):
		var grid_pos = Vector2(randi() % GRID_SIZE.x, randi() % GRID_SIZE.y)

		if not grid_pos in positions:
			positions.append(grid_pos)

	# 4. Instanciate obstacles
	for pos in positions:
		print(obstacle)
		var new_obstacle = obstacle.instantiate() as Node2D
		new_obstacle.set_position(map_to_local(pos))
		grid[pos.x][pos.y] = ENTITY_TYPES.OBSTACLE

		add_child(new_obstacle)

# Return if the cell is vacant
func is_cell_vacant(pos, direction):
	var grid_pos = local_to_map(pos) + direction

	var isInsideX = grid_pos.x < GRID_SIZE.x and grid_pos.x >= 0
	var isInsideY = grid_pos.y < GRID_SIZE.y and grid_pos.y >= 0

	# Trying to go outside the grid
	if not isInsideX or not isInsideY:
		return false

	# Return if grid is empty
	return grid[grid_pos.x][grid_pos.y] == null


# Move a child to a new position in the grid
# Returns the new target world position of the child
func update_child_pos(child_node):
	# 1. Clear previous grid pos
	var grid_pos = local_to_map(child_node.get_position())
	print(grid_pos)
	grid[grid_pos.x][grid_pos.y] = null

	# 2. Occupy new grid pos
	var new_grid_pos = grid_pos + child_node.direction
	grid[new_grid_pos.x][new_grid_pos.y] = child_node.type

	# 3. Return target position
	var target_pos = map_to_local(new_grid_pos)
	return target_pos
