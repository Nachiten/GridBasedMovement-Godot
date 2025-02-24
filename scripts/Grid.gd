extends TileMap

class_name Grid

const obstacle = preload("res://scenes/Obstacle.tscn")

@onready var player: Player = %Player
@onready var game_manager: GameManager = get_node("/root/Game/GameManager")

const GRID_SIZE = Vector2i(10, 10)

var tile_size = tile_set.tile_size.x
var half_tile_size = tile_size / 2
var grid = []

enum ENTITY_TYPES {PLAYER, OBSTACLE, COLLECTIBLE}


func _ready():
	# 1. Create the grid Array
	for x in range(GRID_SIZE.x):
		grid.append([])
		for y in range(GRID_SIZE.y):
			grid[x].append(null)

	game_manager.grid_initialized.emit()

	# 2. Snap player to the grid
	# var start_pos = move_grid_element_in_direction(player, Vector2i(0, 0))
	# player.set_position(start_pos)

	# 3. Create obstacle positions
	#var obstacle_grid_positions = []
	#for n in range(5):
		#var grid_pos = Vector2i(randi() % GRID_SIZE.x, randi() % GRID_SIZE.y)
#
		#if not grid_pos in obstacle_grid_positions:
			#obstacle_grid_positions.append(grid_pos)

	# 4. Instanciate obstacles
	#for pos in obstacle_grid_positions:
		#var new_obstacle = obstacle.instantiate() as Node2D
		#new_obstacle.set_position(grid_pos_to_world_pos(pos))
		#grid[pos.x][pos.y] = new_obstacle
#
		#add_child(new_obstacle)
#
		#print("New Obstacle in: (", pos.x, ", " ,pos.y, "), obstacle: ", new_obstacle.name)

func is_cell_in_direction_vacant(world_pos, direction):
	return is_cell_vacant(world_pos + direction * tile_size)

func is_cell_in_direction_movable(world_pos, direction):
	return is_cell_movable(world_pos + direction * tile_size)

func is_grid_pos_valid(grid_pos):
	var isInsideX = grid_pos.x < GRID_SIZE.x and grid_pos.x >= 0
	var isInsideY = grid_pos.y < GRID_SIZE.y and grid_pos.y >= 0

	return isInsideX and isInsideY

# Return if the cell is vacant
func is_cell_vacant(world_pos) -> bool:
	var grid_pos = world_pos_to_grid_pos(world_pos)

	if not is_grid_pos_valid(grid_pos):
		return false

	# Return if grid is empty
	var isGridEmpty = grid[grid_pos.x][grid_pos.y] == null
	return isGridEmpty

func is_cell_movable(world_pos) -> bool:
	var grid_pos = world_pos_to_grid_pos(world_pos)

	if not is_grid_pos_valid(grid_pos):
		return false

	var node = get_node_at_grid_pos(grid_pos)
	var get_node = node.get_node_or_null("MovableGridElement")
	return get_node != null

func get_node_in_direction(world_pos, direction):
	var grid_pos = world_pos_to_grid_pos(world_pos)
	var target_grid_pos = Vector2(grid_pos) + Vector2(direction)
	return grid[target_grid_pos.x][target_grid_pos.y]

func get_node_at_grid_pos(grid_pos):
	return grid[grid_pos.x][grid_pos.y]

# Move a grid_element in the specified direction
# Returns the new target world position of the grid_element
func move_grid_element_in_direction(grid_element, direction):
	# 1. Clear previous grid pos
	var grid_pos = world_pos_to_grid_pos(grid_element.get_position())
	grid[grid_pos.x][grid_pos.y] = null

	# 2. Occupy new grid pos
	var new_grid_pos = grid_pos + direction
	grid[new_grid_pos.x][new_grid_pos.y] = grid_element
	print(grid_element.name, " moved from: ", grid_pos, " to: ", new_grid_pos)

	# 3. Return target position
	var target_pos = grid_pos_to_world_pos(new_grid_pos)
	return target_pos

var grid_offset = Vector2(100, 100)

func world_pos_to_grid_pos(world_pos):
	return local_to_map(world_pos)

func grid_pos_to_world_pos(grid_pos):
	return map_to_local(grid_pos)
