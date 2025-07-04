extends Node2D


@onready var label = $Label

const  base_text = "[RMB] to "

var tiles_in_range = []
var can_interact : bool = true

func update_tiles_in_range(interaction_area : Area2D,tilemap : TileMap):
	tiles_in_range.clear()
	
	var shape = interaction_area.get_node("CollisionShape2D").shape
	
	if not shape is CircleShape2D: return
	
	var area_center = interaction_area.global_position
	
	var radius = shape.radius * interaction_area.global_scale.x
	
	var top_left = tilemap.local_to_map(tilemap.to_local(area_center - Vector2(radius, radius)))
	var bottom_right = tilemap.local_to_map(tilemap.to_local(area_center + Vector2(radius, radius)))
	
	for x in range(top_left.x, bottom_right.x + 1):
		for y in range(top_left.y, bottom_right.y + 1):
			var cell : Vector2 = Vector2(x, y)
			var cell_center = tilemap.map_to_local(cell) + Vector2(tilemap.cell_quadrant_size, tilemap.cell_quadrant_size) / 2
			if cell_center.distance_to(area_center) <= radius:
				var tile_data = tilemap.get_cell_tile_data(tilemap.BLOCKS_LAYER, cell)
				if tile_data and tile_data.get_custom_data("Crafting_LVL") > 0:
					tiles_in_range.append(tile_data.get_custom_data("Crafting_LVL"))
	tiles_in_range.sort()

func get_crafting_lvl():
	if tiles_in_range:
		return tiles_in_range[0]
	return 0
