class_name Tile_Map
extends TileMap

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
	set_cell(1,mouse_pos,0,Vector2i(11,9))

var emited : bool

func has_block_on_cursor():
	if get_cell_tile_data(0,prev_mouse_pos):
		return true
	return false

var last_block

func scrape_block(data):
	#Calculate the time
	data["time_acumulator"] += _delta
	if data["time_acumulator"] >= 0.1:
		data["time_acumulator"] = 0.0
		
		#substract the duration of the block
		var block = get_cell_tile_data(0,prev_mouse_pos)
		if data["remaining_duration"] == null or block != last_block:
			last_block = block
			data["remaining_duration"] = block.get_custom_data("Hardness")
		data["remaining_duration"] += -1
		
		#erase the block if the duration its below 0 and restart the remaining duration
		if data["remaining_duration"] <= 0:
			data["remaining_duration"] = null
			erase_cell(0,prev_mouse_pos)
			var new_drop = block.get_custom_data("Drop").duplicate()
			if new_drop:
				var drop = new_drop.instantiate()
				drop.slotRes = drop.slotRes.duplicate()
				var amount = block.get_custom_data("Amount")
				drop.slotRes.amount = amount
				add_sibling(drop)
				drop.global_position = map_to_local(prev_mouse_pos)

func place_block(source_id : int, atlas_coords : Vector2i):
	if get_cell_tile_data(0,prev_mouse_pos): return
	
	set_cell(0,prev_mouse_pos,source_id,atlas_coords)
