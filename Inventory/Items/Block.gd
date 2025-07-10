extends Inv_Item
class_name Inv_Block

@export var Source_ID : int
@export var Atlas_coord : Vector2i
@export var durable : bool

func use(player : Player):
	if player.tilemap.get_block_on_cursor():
		return
	player.tilemap.place_block(Source_ID,Atlas_coord)
	if not durable:
		player.inventory.remove_item(player.hotbar.equipped_item_index)
