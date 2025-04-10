class_name Tile_Map
extends TileMap

var prev_mouse_pos

signal cursor_on_block( exists:bool )

var _delta

func _process(delta):
	_delta = delta
	var mouse_pos = local_to_map(get_local_mouse_position())
	if mouse_pos != prev_mouse_pos:
		update_mouse_position(mouse_pos)
	has_block_on_cursor()

func update_mouse_position(mouse_pos):
	if prev_mouse_pos:
		erase_cell(1,prev_mouse_pos)
	prev_mouse_pos = mouse_pos
	set_cell(1,mouse_pos,0,Vector2i(11,9))

var emited : bool

func has_block_on_cursor():
	if get_cell_tile_data(0,prev_mouse_pos):
		cursor_on_block.emit(true)
		emited = false
		return
	if not emited:
		cursor_on_block.emit(false)
		emited = true


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
		
		#erase the block if the duration its below 0
		if data["remaining_duration"] <= 0:
			data["remaining_duration"] = null
			erase_cell(0,prev_mouse_pos)
