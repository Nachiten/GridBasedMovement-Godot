extends Node

@onready var grid_element_parent: Node2D = $".."
@onready var grid: Grid = get_node("/root/Game/Grid")
@onready var game_manager: GameManager = get_node("/root/Game/GameManager")

func _ready() -> void:
	game_manager.grid_initialized.connect(_on_grid_initialize)

func _on_grid_initialize():
	var start_pos = grid.move_grid_element_in_direction(grid_element_parent, Vector2i(0, 0))
	grid_element_parent.set_position(start_pos)
