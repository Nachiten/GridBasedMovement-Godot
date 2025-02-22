extends TileMap

var tile_size = tile_set.tile_size.x
var half_tile_size = tile_size / 2

const GRID_SIZE = Vector2(10, 10)
var grid = []

@onready var Obstacle = preload("res://assets/scenes/Obstacle.tscn")

func _ready():
	# 1. Create the grid Array
	# 2. Create obstacles
	pass


func is_cell_vacant():
	# Return true if the cell is vacant, else false
	pass


func update_child_pos(child, new_pos, direction):
	# Move a child to a new position in the grid Array
	# Returns the new target world position of the child
	pass
