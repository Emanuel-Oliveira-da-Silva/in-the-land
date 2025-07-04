extends Node2D


@onready var label = $Label

const  base_text = "[RMB] to "

var tiles_in_range = []
var can_interact : bool = true

func register_tile(tile_data : TileData):
	tiles_in_range.append(tile_data.get_custom_data("Crafting_LVL"))

func unregister_tile(tile_data : TileData):
	tiles_in_range.erase(tile_data.get_custom_data("Crafting_LVL"))

func get_crafting_lvl():
	tiles_in_range.sort()
	if tiles_in_range:
		return tiles_in_range[0]
	return 0
