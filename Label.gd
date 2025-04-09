extends Label

@onready var tile_map = $"../../TileMap"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(tile_map.prev_mouse_pos)
