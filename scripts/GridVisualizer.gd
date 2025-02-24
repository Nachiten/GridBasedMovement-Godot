extends Node2D

@onready var grid: Grid = get_parent()

const LINE_COLOR = Color(255, 255, 255, 0.3)
const LINE_WIDTH = 2
var GRID_SIZE


func _ready():
	GRID_SIZE = grid.GRID_SIZE

func _draw():
	var limitX = grid.tile_set.tile_size.y * GRID_SIZE.y
	var limitY = grid.tile_set.tile_size.x * GRID_SIZE.x

	# Draw the grid
	for x in range(GRID_SIZE.x + 1):
		var col_pos = x * grid.tile_set.tile_size.x
		draw_line(Vector2(col_pos, 0), Vector2(col_pos, limitX), LINE_COLOR, LINE_WIDTH)
	for y in range(GRID_SIZE.y + 1):
		var row_pos = y * grid.tile_set.tile_size.y
		draw_line(Vector2(0, row_pos), Vector2(limitY, row_pos), LINE_COLOR, LINE_WIDTH)
