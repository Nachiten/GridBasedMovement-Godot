extends TileMap

const GRID_SIZE = Vector2i(10, 10)

var tile_size = tile_set.tile_size.x
var half_tile_size = tile_size / 2.0
var grid = []

const obstacle = preload("res://scenes/Obstacle.tscn")

enum ENTITY_TYPES {PLAYER, OBSTACLE, COLLECTIBLE}

func _ready():
	# 1. Create the grid Array
	for x in range(GRID_SIZE.x):
		grid.append([])
		for y in range(GRID_SIZE.y):
			grid[x].append(null)

	# 2. Create obstacle positions
	var positions = []
	for n in range(5):
		var grid_pos = Vector2(randi() % GRID_SIZE.x, randi() % GRID_SIZE.y)

		if not grid_pos in positions:
			positions.append(grid_pos)

	# 3. Instanciate obstacles
	for pos in positions:
		print(obstacle)
		var new_obstacle = obstacle.instantiate()
		new_obstacle.position = map_to_local(pos)
		grid[pos.x][pos.y] = ENTITY_TYPES.OBSTACLE

		add_child(new_obstacle)



func is_cell_vacant():
	# Return true if the cell is vacant, else false
	pass


func update_child_pos(child, new_pos, direction):
	# Move a child to a new position in the grid Array
	# Returns the new target world position of the child
	pass
