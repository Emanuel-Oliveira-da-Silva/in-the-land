class_name Tile_Map
extends TileMap

var prev_mouse_pos


func _process(delta):
	var mouse_pos = local_to_map(get_local_mouse_position())
	if mouse_pos != prev_mouse_pos:
		update_mouse_position(mouse_pos)

func update_mouse_position(mouse_pos):
	if prev_mouse_pos:
		erase_cell(1,prev_mouse_pos)
	prev_mouse_pos = mouse_pos
	set_cell(1,mouse_pos,0,Vector2i(11,9))

func _block(float durabilidad restante, Vector2i coords) -> float:
	#ideas:
	#que devuelva la vida restante del bloque seleccionado (usando esta)
	#que haya una variable que devuelva la durabilidad del bloque seleccionado
	
	return 0.5
