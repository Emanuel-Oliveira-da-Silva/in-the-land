class_name Tile_Map
extends TileMap

const BLOCKS_LAYER : int = 0
const CURSOR_LAYER : int = 1


var prev_mouse_pos

var _delta

func _process(delta):
	_delta = delta
	var mouse_pos = local_to_map(get_local_mouse_position())
	if mouse_pos != prev_mouse_pos:
		update_mouse_position(mouse_pos)

func update_mouse_position(mouse_pos):
	if prev_mouse_pos:
		erase_cell(1,prev_mouse_pos)
	prev_mouse_pos = mouse_pos
	set_cell(CURSOR_LAYER,mouse_pos,0,Vector2i(11,9))

func get_block_on_cursor():
	if get_cell_tile_data(BLOCKS_LAYER,prev_mouse_pos):
		return get_cell_tile_data(BLOCKS_LAYER,prev_mouse_pos)
	if get_scene_at_position(prev_mouse_pos):
		return get_scene_at_position(prev_mouse_pos)
	return null

var last_block

func scrape_block(data, mining : float):
	#Calculate the time
	data["time_acumulator"] += _delta
	if data["time_acumulator"] >= 0.1:
		data["time_acumulator"] = 0.0
		
		#substract the duration of the block
		var block = get_cell_tile_data(BLOCKS_LAYER,prev_mouse_pos)
		if !block: return
		if data["remaining_duration"] == null or block != last_block:
			last_block = block
			data["remaining_duration"] = block.get_custom_data("Hardness")
		data["remaining_duration"] += mining * -1
		
		#erase the block if the duration its below 0 and restart the remaining duration
		if data["remaining_duration"] <= 0:
			data["remaining_duration"] = null
			erase_cell(BLOCKS_LAYER,prev_mouse_pos)
			remove_area_at_position(prev_mouse_pos)
			var new_drop = block.get_custom_data("Drop").duplicate()
			if new_drop:
				var drop = new_drop.instantiate()
				drop.slotRes = drop.slotRes.duplicate()
				var amount = block.get_custom_data("Amount")
				drop.slotRes.amount = amount
				add_sibling(drop)
				drop.global_position = map_to_local(prev_mouse_pos)

func place_block(source_id : int, atlas_coords : Vector2i):
	var mouse_pos = prev_mouse_pos
	
	set_cell(BLOCKS_LAYER,mouse_pos,source_id,atlas_coords)
	
	var tile_data : TileData = get_cell_tile_data(BLOCKS_LAYER,mouse_pos)
	
	if source_id > 0 : return
	if tile_data.get_custom_data("Area_In"):
		var new_area = tile_data.get_custom_data("Area_In").duplicate()
		var area : Interaction_Area = new_area.instantiate()
		area.global_position = map_to_local(mouse_pos)
		area.tile_data = tile_data
		add_child(area)

func get_scene_at_position(position : Vector2i):
	for scene in self.get_children():
		if scene is Entity_Bock:
			if local_to_map(scene.global_position) == position:
				return scene
	return null

func remove_area_at_position(position : Vector2i):
	for area in self.get_children():
		if area is Area2D:
			if local_to_map(area.global_position) == position:
				area.queue_free()
				break
