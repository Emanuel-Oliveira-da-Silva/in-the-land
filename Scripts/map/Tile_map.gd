class_name Tile_Map
extends TileMap

var prev_mouse_pos

signal cursor_on_block( exists:bool )


func _process(delta):
	var mouse_pos = local_to_map(get_local_mouse_position())
	if mouse_pos != prev_mouse_pos:
		update_mouse_position(mouse_pos)
	has_block_on_cursor()

func update_mouse_position(mouse_pos):
	if prev_mouse_pos:
		erase_cell(1,prev_mouse_pos)
	prev_mouse_pos = mouse_pos
	set_cell(1,mouse_pos,0,Vector2i(11,9))

func has_block_on_cursor():
	if get_cell_tile_data(0,prev_mouse_pos):
		cursor_on_block.emit(true)
	cursor_on_block.emit(false)

func scrape_block(remaining_duration , coords) -> float:
	#ideas:
	#que devuelva la vida restante del bloque seleccionado (usando esta)
	#que haya una variable que devuelva la durabilidad del bloque seleccionado
	remaining_duration -= 10
	var block = get_cell_tile_data(0,coords)
	print(str(remaining_duration - block.get_custom_data("Hardness")))
	return remaining_duration - block.get_custom_data("Hardness")
